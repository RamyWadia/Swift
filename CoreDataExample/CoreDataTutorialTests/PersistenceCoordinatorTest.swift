//
//  PersistenceCoordinatorTest.swift
//  CoreDataTutorialTests
//
//  Created by Ramy Atalla on 2022-05-15.
//

import XCTest
import CoreData
@testable import CoreDataTutorial

class PersistenceCoordinatorTest: XCTestCase {
    
    var managedObjectModel: NSManagedObjectModel!
    var persistenceCoordinator: PersistenceCoordinator!

    override func setUpWithError() throws {
      
        let bundle = Bundle(for: PersistenceCoordinatorTest.self)
        
        guard let url = bundle.url(forResource: "CoreDataTutorial",
                                   withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            XCTFail("Failed to load the test dependency")
            return
        }
        
       managedObjectModel = model
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        persistenceCoordinator = PersistenceCoordinator(model: managedObjectModel, storeDescription: description)
        XCTAssertNotNil(persistenceCoordinator)
        
        let constructExpectation = self.expectation(description: "ConstructExpectation")
        persistenceCoordinator.constructCoreDataStack { error in
            XCTAssertNil(error, "construct error is not nil")
            constructExpectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }

    override func tearDownWithError() throws {
        managedObjectModel = nil
        persistenceCoordinator = nil
    }
    
    //Idea for naming testFunc
    // test_methodName_withCertainState_shouldDoSomthing
    
    func testInitializer_providedManagedObjectModelAndtStoreDescription_coordinatorInitializedSuccessfully() {
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        XCTAssert(persistenceCoordinator.model === managedObjectModel)
        XCTAssert(persistenceCoordinator.persistentContainer.name.isEmpty)
        XCTAssert(persistenceCoordinator.persistentContainer.managedObjectModel === managedObjectModel)
        XCTAssert(persistenceCoordinator.persistentContainer.persistentStoreDescriptions.first === description)
    }
    
    func testInitializer_providedPersistentContainer_coordinatorInitializedSuccessfully() {
        
        let persistentContainer = NSPersistentContainer(name: "", managedObjectModel: managedObjectModel)
        
        let persistenctCoordinator = PersistenceCoordinator(persistentContainer: persistentContainer)
        
        XCTAssertNotNil(persistenctCoordinator.persistentContainer)
        XCTAssert(persistenctCoordinator.persistentContainer.managedObjectModel === managedObjectModel)
        XCTAssert(persistenctCoordinator.model === managedObjectModel)
    }
    
    func testConstructCoreDataStack_completionHandlerCalledSuccess() {
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        let persistenceCoordinator = PersistenceCoordinator(model: managedObjectModel, storeDescription: description)
        
        let setupExpectation = self.expectation(description: "Construct Stack Expectation")
        
        persistenceCoordinator.constructCoreDataStack { error in
            
            XCTAssertNil(error)
            XCTAssert(persistenceCoordinator.persistentContainer.persistentStoreDescriptions.count == 1)
            XCTAssert(persistenceCoordinator.persistentContainer.persistentStoreDescriptions.first === description)
            XCTAssert(persistenceCoordinator.persistentContainer.persistentStoreDescriptions.first?.type == NSInMemoryStoreType)
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testSaveChages_inBackgroundContext_CompletionHandlerCalledSuccess() {
        
        let expectedFolderTitle = "Test Folder Title"
        let expectedFolderCreatingDate = Date()
        
        let expectedNoteTitle = "Test Note Title"
        let expectedNoteText = "Test Note Text"
        let expectedNoteCreatingDate = Date()
        
        let savingContext = persistenceCoordinator.backgroundContext
        
        let folder = Folder(context: savingContext)
        folder.title = expectedFolderTitle
        folder.creatingDate = expectedFolderCreatingDate
        
        let note = Note(context: savingContext)
        note.title = expectedNoteTitle
        note.text = expectedNoteText
        note.creatingDate = expectedNoteCreatingDate
        
        folder.addToNotes(note)
        
        let saveExpectation = self.expectation(description: "Save Expectation")
        
        persistenceCoordinator.saveChanges(in: savingContext) { error in
            XCTAssertNil(error)
            XCTAssertFalse(Thread.current.isMainThread)
            self.persistenceCoordinator.fetch(from: savingContext, fetchRequest: Folder.fetchRequest()) { result in
                switch result {
                case .success(let managedObjects):
                    XCTAssert(managedObjects is [Folder])
                    XCTAssert(managedObjects.count == 1)
                    XCTAssertNotNil(managedObjects)
                    XCTAssertNil(error, "error is not nil")
                    
                    let folders = managedObjects as? [Folder]
                    let folder = folders?.first
                    
                    XCTAssertNotNil(folder)
                    XCTAssertEqual(folder?.title, expectedFolderTitle)
                    XCTAssertEqual(folder?.creatingDate, expectedFolderCreatingDate)
                    XCTAssert(folder?.notes?.count == 1)
                    XCTAssert(folder?.managedObjectContext === savingContext)
                    
                    if let notes = folder?.notes?.allObjects as? [Note] {
                        for note in notes {
                            XCTAssertEqual(note.title, expectedNoteTitle)
                            XCTAssertEqual(note.text, expectedNoteText)
                            XCTAssertEqual(note.creatingDate, expectedNoteCreatingDate)
                            XCTAssert(note.folder === folder)
                            XCTAssertNotNil(note.folder)
                            XCTAssert(note.managedObjectContext === savingContext)
                        }
                    }
                    
                case .failure(let err):
                    XCTAssertNotNil(err)
                }
                
                saveExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    

}

