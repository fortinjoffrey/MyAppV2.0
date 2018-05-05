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
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Training>(entityName: "Training")
        
        do {
            let trainings = try context.fetch(fetchRequest)
            return trainings
        } catch let fetchErr {
            print("Failed to fetch trainings:", fetchErr)
            return []
        }
    }
    
    func deleteTraining(training: Training) -> Bool {
        
        let context = persistentContainer.viewContext
        
        context.delete(training)
        
        do {
            try context.save()
            return true
        } catch let saveErr {
            print("Failed to delete training:", saveErr)
            return false
        }
    }
    
    func performBatchDeleteRequest() -> Bool {
        
        let context = persistentContainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Training.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            return true
            
        } catch let delErr {
            print("Failed to perform batch delete request", delErr)
            return false
        }
    }
    
    
    // MARK: Exercices
    func createExercice(name: String, category: String, training: Training) -> (Exercice?, Error?) {
        
        let context = persistentContainer.viewContext
        
        let exercice = NSEntityDescription.insertNewObject(forEntityName: "Exercice", into: context) as! Exercice
        
        exercice.name = name
        exercice.date = Date()
        exercice.category = category
        exercice.training = training
        
        do {
            try context.save()
            return (exercice, nil)
        } catch let saveErr {
            print("Failed to create exercice:", saveErr)
            return (nil, saveErr)
        }
    }
    
    func deleteExercice(exercice: Exercice) -> Bool {
        
        let context = persistentContainer.viewContext
        context.delete(exercice)
        
        do {
            try context.save()
            return true
        } catch let saveErr {
            print("Failed to delete exercice:", saveErr)
            return false
        }
    }
    
    func createSet(duration: Int16, speed: Int16, repetitions: Int16, weight: Int16, exercice: Exercice) -> (Set?, Error?) {
        
        let context = persistentContainer.viewContext
        
        let set = NSEntityDescription.insertNewObject(forEntityName: "Set", into: context) as! Set
        
        set.date = Date()
        set.duration = duration
        set.speed = speed
        set.repetitions = repetitions
        set.weight = weight
        set.exercice = exercice
        
        do {
            try context.save()
            return (set, nil)
        } catch let saveErr {
            print("Failed to create set:", saveErr)
            return (nil, saveErr)
        }
        
    }
    
    func deleteSet(set: Set) -> Bool {
        
        let context = persistentContainer.viewContext        
        context.delete(set)

        do {
            try context.save()
            return true
        } catch let saveErr {
            print("Failed to delete set:", saveErr)
            return false
        }
        
    }
    
    
    
}
