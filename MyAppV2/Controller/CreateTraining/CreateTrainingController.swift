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
}

class CreateTrainingController: UIViewController {
    
    var training: Training? {
        didSet {
            guard let name = training?.name else { return }
            guard let startDate = training?.startDate else { return }
            
            nameTextField.text = name
            startDatePicker.date = startDate
            isDone = training?.isDone
            
            if let endDate = training?.endDate, let notation = training?.notation, let tirednessNotation = training?.tirednessNotation, let notes = training?.notes {
                
                endDatePicker.date = endDate
                notationPicker.selectRow(Int(notation), inComponent: 0, animated: false)
                tirednessNotationPicker.selectRow(Int(tirednessNotation), inComponent: 0, animated: false)
                notesTextView.text = notes
            }
        }
    }
    
    var isDone: Bool?
    
    var delegate: CreateTrainingControllerDelegate?
    
    var selectedTextArea: Any?
    var textfieldMode: Bool?
    let heightForHorizontalPickerView: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom de la séance"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Ex: Jambes / Épaules"
        tf.textAlignment = .center
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
        
        setupObservers()
    }
    
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func createTraining(name: String, isDone: Bool) {
        
        let endDate = isDone ? endDatePicker.date : startDatePicker.date
        
        let tuple = CoreDataManager.shared.createTraining(name: name, startDate: startDatePicker.date, endDate: endDate, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true) {
                if let training = tuple.0 {
                    self.delegate?.didAddTraining(training: training)
                }                
            }
        }
    }
    
    private func saveTrainingChanges(name: String, isDone: Bool) {
        
        let tuple = CoreDataManager.shared.saveTrainingChanges(name: name, startDate: startDatePicker.date, endDate: endDatePicker.date, notation: notationPicker.selectedData, tirednessNotation: tirednessNotationPicker.selectedData, notes: notesTextView.text, isDone: isDone, training: training)
        
        if let error = tuple.1 {
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }        
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        guard let isDone = isDone else { return }
        
        if name.isEmpty {
            showEmptyTextFieldAlert(message: "Entrer un nom pour votre séance")
            return
        }
        
        training == nil ? createTraining(name: name, isDone: isDone) : saveTrainingChanges(name: name, isDone: isDone)
    }
}
