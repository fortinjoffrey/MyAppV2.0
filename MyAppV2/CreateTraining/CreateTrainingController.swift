//
//  CreateTrainingController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateTrainingControllerDelegate {
    func didAddTraining(training: Training)
    func didEditTraining(training: Training)
}

class CreateTrainingController: UIViewController {
    
    var delegate: CreateTrainingControllerDelegate?
    var training: Training? {
        didSet {
            nameTextField.text = training?.name
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        
        navigationItem.title = "Créer training"
        
        setupCancelButton()
        
        setupSaveButtonInNavBar(selector: #selector(handleSave))
        
        setupUI()
    }
    
    
    @objc private func handleSave() {
        
        if training == nil {
            createTraining()
        } else {
            saveTrainingChanges()
        }
    }
    
    private func createTraining() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let training = NSEntityDescription.insertNewObject(forEntityName: "Training", into: context)
        
        training.setValue(nameTextField.text, forKey: "name")
        training.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
            
            dismiss(animated: true) {
                self.delegate?.didAddTraining(training: training as! Training)
            }
        } catch let saveErr {
            print("Failed to save training:", saveErr)
        }
    }
    
    private func saveTrainingChanges() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        training?.name = nameTextField.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditTraining(training: self.training!)
            })
            
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
        
    }
    
    private func setupUI() {
        
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        
        [lightBlueBackgroundView, nameLabel, nameTextField].forEach { view.addSubview($0) }

        lightBlueBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        nameTextField.anchor(top: nameLabel.topAnchor, left: nameLabel.rightAnchor, bottom: nameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
}
