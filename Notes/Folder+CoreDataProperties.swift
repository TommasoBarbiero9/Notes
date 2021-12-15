//
//  Folder+CoreDataProperties.swift
//  Notes
//
//  Created by Francesco Panariello on 15/12/21.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var name: String?
    @NSManaged public var note: NSSet?

    public var wrappedName : String {
        name ?? "Unknown folder name"
    }
    
    public var noteArray: [Note] {
         let set = note as? Set<Note> ?? []

         return set.sorted {
             $0.wrappedTitle < $1.wrappedTitle
         }
     }
}

// MARK: Generated accessors for note
extension Folder {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Note)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Note)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

extension Folder : Identifiable {

}
