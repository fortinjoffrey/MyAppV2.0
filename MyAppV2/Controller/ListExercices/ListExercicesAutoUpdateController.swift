//
//  ListExercicesAutoUpdateController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 28/05/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol ListExercicesAutoUpdateControllerDelegate {
    func didAddExerciceToTraining(exercice: Exercice)
}

class ListExercicesAutoUpdateController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let listExercicesCellId = "listExercicesCellId"
    
    var training: Training?
    var delegate: ListExercicesAutoUpdateControllerDelegate?
    
    var selectedExercices = [Exercice]()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    lazy var fetchResultsController: NSFetchedResultsController<Exercice> = {
        
        let request: NSFetchRequest<Exercice> = Exercice.fetchRequest()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let groupSortDescriptor = NSSortDescriptor(key: "primaryGroup", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        //        request.predicate = NSPredicate(format: "date > %@", NSDate())
        request.predicate = NSPredicate(format: "isListed = true")
        
        request.sortDescriptors = [groupSortDescriptor, nameSortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "primaryGroup", cacheName: nil)
        
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
        setupTableView()
        navigationItem.title = "Listes des exercices"
        
        
        
        if training == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddView))
            tableView.allowsSelection = false
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Terminer", style: .plain, target: self, action: #selector(handleDone))
            tableView.allowsSelection = true
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        
        if UserDefaults.standard.object(forKey: "hasAlreadyBeenLauched") == nil {
            createDefaultsExercices()
            UserDefaults.standard.set(true, forKey: "hasAlreadyBeenLauched")
        }
        
    }
    
    fileprivate func createDefaultsExercices() {
        
        var defaultsExercicesArray = [[String]]()
        defaultsExercicesArray.append(["Développé Couché Haltères", "Pectoraux", "Triceps","Poids libre"])
        defaultsExercicesArray.append(["Dips", "Triceps", "Pectoraux", "", "Poids du corps"])
        
        defaultsExercicesArray.forEach { (exercice) in
            _ = CoreDataManager.shared.createExercice(name: exercice[0], category: exercice[1], primaryGroup: exercice[2], secondaryGroup: exercice[3], training: nil)
        }
    }
    
    /*
     * Might call this method upon "Reset All Exercices To Default" inside the settings page
     */
    @objc fileprivate func handleReset() {
        UserDefaults.standard.set(nil, forKey: "hasAlreadyBeenLauched")
        
        fetchResultsController.fetchedObjects?.forEach({ (exercice) in
            _ = CoreDataManager.shared.deleteExercice(exercice: exercice)
        })        
    }
    
    @objc fileprivate func handleAddView() {
        let createExerciceController = CreateExerciceController()
        createExerciceController.modalPresentationStyle = .overFullScreen
        present(createExerciceController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleDone() {
        dismiss(animated: true) {
            self.selectedExercices.forEach {
                self.createExerciceIntoTraining(exercice: $0)
            }
        }
    }
    
    fileprivate func createExerciceIntoTraining(exercice: Exercice) {
        
        guard let training = self.training else { return }
        guard let name = exercice.name else { return }
        guard let category = exercice.category else { return }
        guard let primaryGroup = exercice.primaryGroup else { return }
        
        print(name)
        
        let tuple = CoreDataManager.shared.createExercice(name: name, category: category, primaryGroup: primaryGroup, secondaryGroup: exercice.secondaryGroup, training: training)
        if let error = tuple.1 {
            print(error)
        } else {
            if let exercice = tuple.0 {
                self.delegate?.didAddExerciceToTraining(exercice: exercice)
            }            
        }
    }
    
}
