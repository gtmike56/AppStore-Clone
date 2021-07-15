//
//  TodayMultipleAppsCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-14.
//

import UIKit

class TodayMultipleAppsCell: UICollectionViewCell {
    
    var todayItem: TodayCellModel? {
        didSet {
            categotyLabel.text = todayItem?.categoty
            titleLabel.text = todayItem?.title
            todayAppsVC.apps = todayItem?.apps?.feed.results
            todayAppsVC.collectionView.reloadData()
        }
    }
    
    var categotyLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Caregory"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Title"
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 2
        return label
    }()
    
    let todayAppsVC = TodayMultipleAppsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        let stackView = UIStackView(arrangedSubviews: [categotyLabel, titleLabel, todayAppsVC.view])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15 ).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
