//
//  TrainingCell.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class TrainingCell: UITableViewCell {
    
    var training: Training? {
        didSet {

            if let name = training?.name, let date = training?.startDate, let isDone = training?.isDone {
                
                if isDone {
                    accessoryType = UITableViewCellAccessoryType.checkmark
                    backgroundColor = .doneGreen
                } else {
                    accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                let dateString = dateFormatter.string(from: date)
                nameAndDate.text = "\(name) Date: \(dateString)"                
            } else {
                nameAndDate.text = training?.name
            }
        }
    }
    
    let nameAndDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .tealColor
        
        addSubview(nameAndDate)
        
        nameAndDate.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
