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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        
        navigationItem.title = "Créer training"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        
        setupUI()
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
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
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        
    }
    
}
