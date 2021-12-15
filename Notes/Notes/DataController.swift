//
//  DataController.swift
//  Notes
//
//  Created by Tommaso Barbiero on 07/12/21.
//

import Foundation
import CoreData
import UIKit

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Data")
    
  
    
    init() {
        container.loadPersistentStores{ description , error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
//            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}



