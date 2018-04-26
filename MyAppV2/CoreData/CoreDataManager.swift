//
//  CoreDataManager.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // will live forever
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyAppV2Model")
        container.loadPersistentStores{ (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchTrainings() -> [Training]{
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Training>(entityName: "Training")
        
        do {
            let trainings = try context.fetch(fetchRequest)
            return trainings
        } catch let fetchErr {
            print("Failed to fetch trainings:", fetchErr)
            return []
        }
    }
    
    func performBatchDeleteRequest() -> Bool {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Training.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            return true
            
        } catch let delErr {
            print("Failed to perform batch delete request", delErr)
            return false
        }
    }
    
    
}
