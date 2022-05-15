//
//  Note+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Ramy Atalla on 2022-05-15.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var creatingDate: Date?
    @NSManaged public var folder: Folder?

}

extension Note : Identifiable {

}
