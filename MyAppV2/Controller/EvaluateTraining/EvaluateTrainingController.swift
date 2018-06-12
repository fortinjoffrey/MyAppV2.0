//
//  EvaluateTrainingController.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 12/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit
import CoreData

protocol EvaluateTrainingControllerDelegate {
    func didEvaluateTraining(training: Training)
}

class EvaluateTrainingController: UIViewController {
    
    var training: Training?
    var delegate: EvaluateTrainingControllerDelegate?
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.alpha = 1
        return visualEffectView
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
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
    
    let validateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Valider", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleValidate), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        [visualEffectView, mainView].forEach { view.addSubview($0) }
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: view.frame.height * 0.3)
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        let notationLabel = createLabel(for: "Notez la séance")
        let notationContainerView = setupNotationContainerView()
        let stackView = setupStackview(with: [notationLabel, notationContainerView, validateButton], for: .vertical)
        
        [stackView].forEach { mainView.addSubview($0) }
        
        stackView.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    fileprivate func setupNotationContainerView() -> UIView {
        
        let notationContainerView = UIView()
        notationContainerView.addSubview(notationPicker)
        
        NSLayoutConstraint.activate([
            notationPicker.centerXAnchor.constraint(equalTo: notationContainerView.centerXAnchor),
            notationPicker.centerYAnchor.constraint(equalTo: notationContainerView.centerYAnchor)
            ])
        
        notationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: view.frame.width - 32)
        
        return notationContainerView
    }            
    
    @objc fileprivate func handleValidate() {
        guard let training = training else { return }        
        CoreDataManager.shared.saveNotationForTraining(notation: notationPicker.selectedData, training: training)
        dismiss(animated: true) {
            self.delegate?.didEvaluateTraining(training: training)
        }
    }
    
    
    
    
}
