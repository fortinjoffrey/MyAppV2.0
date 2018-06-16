//
//  EvaluateTrainingController+UI.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 15/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension EvaluateTrainingController {
    
    func setupUI() {
        setupVisualEffectMainViews()
        setupNotationViewsAndValidateButton()
    }
    
    fileprivate func setupVisualEffectMainViews() {
        
        [visualEffectView, mainView].forEach { view.addSubview($0) }
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        mainView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: view.frame.height * 0.3)
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    fileprivate func setupNotationViewsAndValidateButton() {
        
        let notationLabel = createLabel(for: "Notez la séance")
        let notationContainerView = setupNotationContainerView()
        let stackView = createStackView(with: [notationLabel, notationContainerView, validateButton], for: .vertical)
        
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
    
    
}
