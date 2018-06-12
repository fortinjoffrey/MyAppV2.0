//
//  ReportTrainingController+UI.swift
//  MyAppV2
//
//  Created by Joffrey Fortin on 08/06/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension ReportTrainingController {
    
    func setupSubViews() {
        view.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)
        [dismissButton, groupsCollectionView, performancesTableView].forEach { scrollContainerView.addSubview($0) }
    }
    
    // 8 P + 25 D + 16 P + 70 D + collectionViewHeight + tableViewHeigt
    
    func setupLayout() {
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollContainerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 8 + 25 + 16 + 70 + collectionViewHeight + tableViewHeight)
        
        dismissButton.anchor(top: scrollContainerView.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let notationLabel = createAndFillNotationLabel()
        
        let durationExercicesStackView = UIStackView(arrangedSubviews: [durationLabel, notationLabel,exercicesNumberLabel])
        durationExercicesStackView.axis = .horizontal
        durationExercicesStackView.distribution = .fillEqually
        
        scrollContainerView.addSubview(durationExercicesStackView)
        
        durationExercicesStackView.anchor(top: dismissButton.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        groupsCollectionView.anchor(top: durationExercicesStackView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: collectionViewHeight)
        
        performancesTableView.anchor(top: groupsCollectionView.bottomAnchor, left: scrollContainerView.leftAnchor, bottom: nil, right: scrollContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: tableViewHeight)
    }
    
    fileprivate func createAndFillNotationLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        
        if let notation = training?.notation {
            let hue = CGFloat(notation)/CGFloat(10) * 0.3
            let hueColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
            label.backgroundColor = hueColor
            label.text = "Note\n\(notation)"            
        }
        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
        print(UIFont.preferredFont(forTextStyle: .headline).pointSize)
        label.font = UIFont(name: "AvenirNext-Bold", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        
        return label
    }
    
}
