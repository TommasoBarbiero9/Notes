//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Tommaso Barbiero on 13/12/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var folder: Folder?
    @NSManaged public var lastModify: Date?
    
    public var wrappedTitle : String {
        title ?? "Unknown note title"
    }
}

extension Note : Identifiable {

}
