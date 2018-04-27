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
        
        navigationItem.title = "Training Auto Updates"
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
        setupTableView()
        
        fetchResultsController.fetchedObjects?.forEach { print($0.name ?? "")}
    }
    
    @objc private func handleAdd() {
        let createTrainingController = CreateTrainingController()
        let navController = UINavigationController(rootViewController: createTrainingController)
        present(navController, animated: true, completion: nil)
    }
}



