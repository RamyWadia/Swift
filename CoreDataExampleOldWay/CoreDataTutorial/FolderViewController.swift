//
//  FolderViewController.swift
//  CoreDataTutorial
//
//  Created by Ramy Atalla on 2022-05-17.
//

import UIKit
import CoreData

class FolderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var persistenceCoordinator: PersistenceCoordinator = {
        let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        let dataBasePath = applicationSupportURL?.appendingPathComponent("DataBase")
        
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        description.url = dataBasePath
        
        let bundle = Bundle(for: AppDelegate.self)
        
        guard let url = bundle.url(forResource: "CoreDataTutorial", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to construct the managed object model.")
        }
        
        var coordinator = PersistenceCoordinator(model: model, storeDescription: description)
        return coordinator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createNewFoler(_ sender: Any) {
        displayAlert()
    }
    
    func displayAlert() {
        let ac = UIAlertController(title: "Folder Name", message: "Enter a folder name", preferredStyle: .alert)
        
        ac.addTextField { textField in
            textField.placeholder = "Folder Name"
        }
        
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            if let folderName = ac.textFields?.first?.text, !folderName.isEmpty {
                self.createFolder(folderName)
            } else {
                print("Invalid folder name input")
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func createFolder(_ folderName: String) {
       
        let savingContext = persistenceCoordinator.fetchingContext
        
        let folder = Folder(context: savingContext)
        folder.title = folderName
        folder.creatingDate = Date()
        
        persistenceCoordinator.saveChanges(in: savingContext) { saveError in
            if saveError == nil  {
                print("Successfully saved \(folderName)")
            }
        }
    }
}
