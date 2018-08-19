//
//  PersistenceService.swift
//  TodoList
//
//  Created by Aminjoni Abdullozoda on 8/18/18.
//  Copyright © 2018 Aminjoni Abdullozoda. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService
{
    // MARK: - Core Data stack
    
    var container : NSPersistentContainer
    {
        let container = NSPersistentContainer(name: "ModelData")
        
        container.loadPersistentStores { (description, error) in
            
            guard error == nil else
            {
                print("Error Description : \(String(describing: error?.localizedDescription))")
                return
            }
        }
        
        return container
    }
    
    var manageContext : NSManagedObjectContext {return container.viewContext}
    
    
}
