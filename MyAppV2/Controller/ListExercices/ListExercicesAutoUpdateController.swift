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
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Entrez nom de l'exercice"
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
        searchController.searchBar.tintColor = .white // Cancel color
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    var training: Training?
    var delegate: ListExercicesAutoUpdateControllerDelegate?
    
    var selectedExercices = [Exercice]()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
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
        setupSearchBar()
        
        navigationItem.title = training == nil ? "Listes des exercices" : "Ajouter exercices"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if training == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddView))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
            tableView.allowsSelection = false
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Terminer", style: .plain, target: self, action: #selector(handleDone))
            tableView.allowsSelection = true
        }
        
//        if UserDefaults.standard.object(forKey: "hasAlreadyBeenLauched") == nil {
//            createDefaultsExercices()
//            UserDefaults.standard.set(true, forKey: "hasAlreadyBeenLauched")
//        }
        
    }
    
    func setupSearchBar() {
        
//        navigationController?.navigationBar.addSubview(searchBar)
//
//        guard let navBar = navigationController?.navigationBar else { return }
//
//        searchBar.anchor(top: navBar.topAnchor, left: navBar.leftAnchor, bottom: navBar.bottomAnchor, right: navBar.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: navBar.frame.width * 0.7, height: 0)
        
    }
    
    /*
     * Might call this method upon "Reset All Exercices To Default" inside the settings page
     */
    @objc fileprivate func handleReset() {
        UserDefaults.standard.set(nil, forKey: "hasAlreadyBeenLauched")
        
        fetchResultsController.fetchedObjects?.forEach({ (exercice) in
            _ = CoreDataManager.shared.deleteExercice(exercice: exercice)
        })
        
        createDefaultsExercices()
        UserDefaults.standard.set(true, forKey: "hasAlreadyBeenLauched")
        
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
