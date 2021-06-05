//
//  SearchResultCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    let appSecondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second title"
        label.textColor = .darkGray
        return label
    }()
    
    let appRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "49K"
        label.textColor = .darkGray
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    lazy var screenshotImage1 = self.createScreenShotsImageView()
    lazy var screenshotImage2 = self.createScreenShotsImageView()
    lazy var screenshotImage3 = self.createScreenShotsImageView()
    
    fileprivate func createScreenShotsImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = UIStackView(arrangedSubviews: [appNameLabel, appSecondNameLabel, appRatingLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2.5
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshotImage1, screenshotImage2, screenshotImage3])
        screenshotsStackView.spacing = 10
        screenshotsStackView.distribution = .fillEqually
        
        let appInfoStackView = UIStackView(arrangedSubviews: [appImageView, labelsStackView, getButton])
        appInfoStackView.spacing = 10
        appInfoStackView.alignment = .center
        
        let mainStackView = UIStackView(arrangedSubviews: [appInfoStackView, screenshotsStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 15
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
