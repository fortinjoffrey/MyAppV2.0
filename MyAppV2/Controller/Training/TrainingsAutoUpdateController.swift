//
//  TrainingsAutoUpdateController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 27/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

class TrainingsAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let cellId = "cellId"
    
    lazy var fetchResultsController: NSFetchedResultsController<Training> = {
        
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        
//        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let endDateSortDescriptor = NSSortDescriptor(key: "endDate", ascending: false)
        
        request.sortDescriptors = [endDateSortDescriptor]
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Entraînements"
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
        setupTableView()
        
        fetchResultsController.fetchedObjects?.forEach { print($0.name ?? "")}
    }
    
    @objc private func handleAdd() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let trainingCategories = ["Entraînement terminé", "Entraînement en cours", "Entraînement futur"]
        
        for (index, value) in trainingCategories.enumerated() {
            
            var isDone: Bool = true
            
            if index == 0 {
                isDone = true
            } else {
                isDone = false
            }
            
            alertController.addAction(UIAlertAction(title: value, style: .default, handler: { (_) in
                self.presentCreateTrainingController(isDone: isDone)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func presentCreateTrainingController(isDone: Bool) {
        
        let createTrainingController = CreateTrainingController()
        createTrainingController.isDone = isDone
        createTrainingController.delegate = self
        
        let navController = UINavigationController(rootViewController: createTrainingController)
        self.present(navController, animated: true, completion: nil)        
    }
}



