//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Francesco Panariello on 15/12/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var lastModify: Date?
    @NSManaged public var title: String?
    @NSManaged public var inFolder: Folder?

    public var wrappedTitle: String {
         title ?? "Unknown Title"
     }
    
}

extension Note : Identifiable {

}
