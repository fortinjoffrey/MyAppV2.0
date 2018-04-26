//
//  CustomCell.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var training: Training? {
        didSet {
            
            if let name = training?.name, let date = training?.date {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                let dateString = dateFormatter.string(from: date)
                nameAndDate.text = "\(name) --- Date: \(dateString)"
                
            } else {
                nameAndDate.text = training?.name
            }
            
        }
    }
    
    let nameAndDate: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(nameAndDate)
        nameAndDate.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameAndDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        nameAndDate.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameAndDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
