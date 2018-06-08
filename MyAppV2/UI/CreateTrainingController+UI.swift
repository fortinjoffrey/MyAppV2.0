//
//  CreateTrainingController+UI.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 08/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension CreateTrainingController {
    
    func setupUI() {
        
        switch isDone {
        case true:
            setupUIForDoneTraining()
        default:
            _ = setupMinimalUI()
        }
    }
    
    fileprivate func setupNotationContainerView() -> UIView {
        
        let notationContainerView = UIView()
        notationContainerView.addSubview(notationPicker)
        
        NSLayoutConstraint.activate([
            notationPicker.centerXAnchor.constraint(equalTo: notationContainerView.centerXAnchor),
            notationPicker.centerYAnchor.constraint(equalTo: notationContainerView.centerYAnchor)
            ])
        
        notationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        
        return notationContainerView
    }
    
    fileprivate func setupTirednessNotationContainerView() -> UIView {
        
        let tirednessNotationContainerView = UIView()
        
        tirednessNotationContainerView.addSubview(tirednessNotationPicker)
        
        NSLayoutConstraint.activate([
            tirednessNotationPicker.centerXAnchor.constraint(equalTo: tirednessNotationContainerView.centerXAnchor),
             tirednessNotationPicker.centerYAnchor.constraint(equalTo: tirednessNotationContainerView.centerYAnchor)
            ])
        
        tirednessNotationPicker.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: heightForHorizontalPickerView, height: view.frame.width)
        
        return tirednessNotationContainerView
    }
    
    fileprivate func setupStackview(with views: [UIView]) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }
    
    fileprivate func setupUIForDoneTraining() {
        
        let scrollContainerView = setupMinimalUI()
        let notationContainerView = setupNotationContainerView()
        let tirednessNotationContainerView = setupTirednessNotationContainerView()
        
        let views = [endDateLabel,endDatePicker, notationLabel, notationContainerView, tirednessNotationLabel, tirednessNotationContainerView, notesLabel]
        
        let stackView = setupStackview(with: views)
        
        [stackView, notesTextView].forEach { scrollContainerView.addSubview($0) }
        
        stackView.anchor(top: startDatePicker.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 350)
        
        notesTextView.anchor(top: stackView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    fileprivate func setupMinimalUI() -> UIView {
        
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let scrollContainerView = UIView()
        scrollContainerView.backgroundColor = .lightBlue
        
        scrollView.addSubview(scrollContainerView)
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 800)
        
        let views = [nameLabel, nameTextField, startDateLabel, startDatePicker]
        let stackView = setupStackview(with: views)
        
        scrollContainerView.addSubview(stackView)
        stackView.anchor(top: scrollContainerView.topAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 215)
  
        return scrollContainerView
    }
    
}
