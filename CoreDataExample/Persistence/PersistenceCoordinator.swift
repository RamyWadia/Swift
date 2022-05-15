//
//  PersistenceCoordinator.swift
//  CoreDataTutorial
//
//  Created by Ramy Atalla on 2022-05-15.
//

import Foundation
import CoreData

class PersistenceCoordinator {
    
    typealias CompletionHandler = (Error?) -> Void
    typealias FetchedResultsHandler = (Result<[NSManagedObject], Error>) -> Void
    
    var fetchingContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    let persistentContainer: NSPersistentContainer
    let model: NSManagedObjectModel
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.model = persistentContainer.managedObjectModel
    }
    //We might want the capability to switch to SQLite persistence coordinator, to and in memory store type.
    //For this we also need to have another initialiser that gives us the raw materials needed so we can build a persistence container directly from those parameters with a configurable store description. (In memory coordinator or SQLite coordinator)
    init(model: NSManagedObjectModel, storeDescription: NSPersistentStoreDescription) {
        self.model = model
        //the name is empty string as the NSMnagedObjectModel object overrides the lookup of the model by the provided name value.
        self.persistentContainer = NSPersistentContainer(name: "", managedObjectModel: model)
        self.persistentContainer.persistentStoreDescriptions = [storeDescription]
    }
    
    func constructCoreDataStack(_ completion: @escaping CompletionHandler) {
        
        var loadedStoresCount = 0
        let storesToLoad = persistentContainer.persistentStoreDescriptions.count
        
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            
            if let error = error {
                print("The load call failed: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            loadedStoresCount += 1
            
            if loadedStoresCount == storesToLoad {
                completion(nil)
            }
        }
    }
    
    func saveChanges(in context: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        
        context.perform {
            do {
                if context.hasChanges {
                    try context.save()
                    try context.parent?.save()
                }
                completion(nil)
            } catch {
                print("Hit an error: \(error.localizedDescription)")
                completion(error)
            }
            
        }
    }
    
    func fetch(from context: NSManagedObjectContext, fetchRequest: NSFetchRequest<NSFetchRequestResult>, fetchCompletionHandler: FetchedResultsHandler) {
        
        do {
            let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let fetchedResults = fetchedResults {
                fetchCompletionHandler(.success(fetchedResults))
            }
        } catch {
            print("Hit an error \(error.localizedDescription)")
            fetchCompletionHandler(.failure(error))
        }
    }
}
