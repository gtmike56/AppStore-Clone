//
//  AppsGroupCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-06.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Section"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    let horizontalController = AppsHorizontalController()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        addSubview(horizontalController.view)
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        horizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        horizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        horizontalController.view .bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
