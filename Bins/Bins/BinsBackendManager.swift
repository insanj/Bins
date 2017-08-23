//
//  BinsBackendManager.swift
//  Bins
//
//  Created by Julian Weiss on 8/22/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import UIKit
import CoreData

class BinsBackendManager: NSObject {
    // MARK: - foundational methods
    static func context() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    static func save() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    // MARK: - entity methods
    static func createBin(name: String) {
        let bin = Bin(context: context())
        bin.name = name
        save()
    }
    
    static func getAllBins() -> [Bin]? {
        var allBins: [Bin]?
        do {
            allBins = try context().fetch(Item.fetchRequest())
        } catch {
            print("[DEBUG][\(#function)]: unable to fetch all bins from context")
        }
        
        return allBins
    }
}
