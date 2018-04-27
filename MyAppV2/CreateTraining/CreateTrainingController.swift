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
    
//    var delegate: CreateTrainingControllerDelegate?
    var training: Training? {
        didSet {
            
            guard let name = training?.name else { return }
            guard let startDate = training?.startDate else { return }
            guard let endDate = training?.endDate else { return }
            guard let notation = training?.notation else { return }
            guard let tirednessNotation = training?.tirednessNotation else { return }
            guard let notes = training?.notes else { return }
            
            
            nameTextField.text = name
            startDatePicker.date = startDate
            endDatePicker.date = endDate
            notationPicker.selectRow(Int(notation), inComponent: 0, animated: false)
            tirednessNotationPicker.selectRow(Int(tirednessNotation), inComponent: 0, animated: false)
            notesTextView.text = notes
            
        }
    }
    
    var selectedTextArea: Any?
    var textfieldMode: Bool?
    let heightForHorizontalPickerView: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Entrez un nom pour votre séance"
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Entrez l'heure de début"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Fin de l'entraînement"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let endDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.locale = Locale(identifier: "FR_fr")
        return dp
    }()
    
    let notationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notez la séance"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let notationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    let tirednessNotationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notez votre état de fatigue"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let tirednessNotationPicker: NotationPickerView = {
        let pv = NotationPickerView()
        pv.dataSource = pv
        pv.delegate = pv
        pv.selectRow(5, inComponent: 0, animated: false)
        let rotationAngle: CGFloat = -.pi / 2
        pv.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return pv
    }()
    
    let notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Remarques sur la séance"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var notesTextView: UITextView = {
        let tf = UITextView()
        tf.delegate = self
        tf.text = ""
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .white
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = training == nil ? "Créer training" : "Modifier"
        
        setupCancelButton()
        
        setupSaveButtonInNavBar(selector: #selector(handleSave))
        
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        
        if name.isEmpty {
            showEmptyTrainingNameAlert()
            return
        }
        
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
        training.setValue(startDatePicker.date, forKey: "startDate")
        training.setValue(endDatePicker.date, forKey: "endDate")
        training.setValue(notationPicker.selectedData, forKey: "notation")
        training.setValue(tirednessNotationPicker.selectedData, forKey: "tirednessNotation")
        training.setValue(notesTextView.text, forKey: "notes")
        
        do {
            try context.save()
            
            dismiss(animated: true) {
//                self.delegate?.didAddTraining(training: training as! Training)
            }
        } catch let saveErr {
            print("Failed to save training:", saveErr)
        }
    }
    
    private func saveTrainingChanges() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        training?.name = nameTextField.text
        training?.startDate = startDatePicker.date
        training?.endDate = endDatePicker.date
        training?.notation = notationPicker.selectedData
        training?.tirednessNotation = tirednessNotationPicker.selectedData
        training?.notes = notesTextView.text
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
//                self.delegate?.didEditTraining(training: self.training!)
            })
            
        } catch let saveErr {
            print("Failed to save company changes:", saveErr)
        }
        
    }
    
    private func setupUI() {
        
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        let scrollContainerView = UIView()
        scrollContainerView.backgroundColor = .lightBlue
        
        scrollView.addSubview(scrollContainerView)
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 800)
        
        let notationContainerView = UIView()
        let tirednessNotationContainerView = UIView()
        
        [nameTextField, startDateLabel, startDatePicker, endDateLabel, endDatePicker, notationLabel, notationContainerView, tirednessNotationLabel, tirednessNotationContainerView, notesLabel, notesTextView].forEach { scrollContainerView.addSubview($0)}
        
        nameTextField.anchor(top: scrollContainerView.topAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 50)
        
        startDateLabel.anchor(top: nameTextField.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        startDatePicker.anchor(top: startDateLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 65)
        
        endDateLabel.anchor(top: startDatePicker.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        endDatePicker.anchor(top: endDateLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 65)
        
        notationLabel.anchor(top: endDatePicker.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        notationContainerView.anchor(top: notationLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 65)
        
        notationContainerView.addSubview(notationPicker)
        
        notationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        notationPicker.centerXAnchor.constraint(equalTo: notationContainerView.centerXAnchor).isActive = true
        notationPicker.centerYAnchor.constraint(equalTo: notationContainerView.centerYAnchor).isActive = true
        
        tirednessNotationLabel.anchor(top: notationContainerView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        tirednessNotationContainerView.anchor(top: tirednessNotationLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 65)
        tirednessNotationContainerView.addSubview(tirednessNotationPicker)
        
        tirednessNotationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        tirednessNotationPicker.centerXAnchor.constraint(equalTo: tirednessNotationContainerView.centerXAnchor).isActive = true
        tirednessNotationPicker.centerYAnchor.constraint(equalTo: tirednessNotationContainerView.centerYAnchor).isActive = true
        
        notesLabel.anchor(top: tirednessNotationContainerView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        notesTextView.anchor(top: notesLabel.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
    }
    
}
