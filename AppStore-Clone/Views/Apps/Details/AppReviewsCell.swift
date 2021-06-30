//
//  AppReviewsCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class AppReviewsCell: UICollectionViewCell {
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Reviews"
        return label
    }()
    
    let horizontalController = AppReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsLabel)
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        reviewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        addSubview(horizontalController.view)
        horizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        horizontalController.view.topAnchor.constraint(equalTo: reviewsLabel.topAnchor, constant: 40).isActive = true
        horizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        horizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        horizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
