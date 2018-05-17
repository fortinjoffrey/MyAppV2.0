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
        request.sortDescriptors = [NSSortDescriptor(key: "endDate", ascending: false)]
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
        
        alertController.addAction(UIAlertAction(title: trainingCategories[0], style: .default, handler: { (_) in
            self.presentCreateTrainingController(isDone: true)
        }))
        
        [trainingCategories[1],trainingCategories[2]].forEach {
            alertController.addAction(UIAlertAction(title: $0, style: .default, handler: { (_) in
                self.presentCreateTrainingController(isDone: false)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func presentCreateTrainingController(isDone: Bool) {
        
        let createTrainingController = CreateTrainingController()
        createTrainingController.isDone = isDone
        let navController = UINavigationController(rootViewController: createTrainingController)
        self.present(navController, animated: true, completion: nil)        
    }
}



