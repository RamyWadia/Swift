//
//  AppDelegate.swift
//  CoreDataTutorial
//
//  Created by Ramy Atalla on 2022-05-15.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var persistenctCoordinator: PersistenceCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        return true
    }
    
//    func configurePersistenceCoordinator() {
        
        //You can skipp this step if you want the persistentContainer
        //to set it up automatically for you.
        //ApplicationSupportDirectory, or DocumentsDirectroy are OK
        //Of course you aviod using TempDirectory
//        let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
//        let dataBasePath = applicationSupportURL?.appendingPathComponent("DataBase")
        
        
//        let description = NSPersistentStoreDescription()
//        description.type = NSSQLiteStoreType
        //to set the url to where the data will be physically stored
        //this will allow us to controll wher the actual data will be
        //stored
        //the default location will be the documents directory in the
        //ApplicationSupport directory.
        //the NSPersistenceContainer manages this automatically but to
        //change it set the url yourself.
        //and this is used for persisting data to a folder
        //but for inMemory Store we do not need to set this.
//        description.url = dataBasePath
        
//        let bundle = Bundle(for: AppDelegate.self)
        
//        guard let url = bundle.url(forResource: "CoreDataTutorial", withExtension: "momd"),
//              let model = NSManagedObjectModel(contentsOf: url) else {
//            print("Failed to construct the managed object model.")
//            return
//        }
        
//        persistenctCoordinator = PersistenceCoordinator(model: model, storeDescription: description)
//
//        //construct the stack itself
//        persistenctCoordinator.constructCoreDataStack { error in
//
//            if let error = error {
//               print("Failed to construct the coreData stack \(error.localizedDescription)")
//            }
//        }
//    }
}

