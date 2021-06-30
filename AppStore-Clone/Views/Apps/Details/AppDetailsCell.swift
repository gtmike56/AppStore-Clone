//
//  AppDetailsCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-26.
//

import UIKit

class AppDetailsCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 140).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 140).isActive = true
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    let whatsNewLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.text = "Release Notes"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let appCompanyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("$3.99", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let headerVerticalStackView = UIStackView(arrangedSubviews: [nameLabel, appCompanyLabel, UIStackView(arrangedSubviews: [priceButton, UIView()])])
        headerVerticalStackView.axis = .vertical
        headerVerticalStackView.distribution = .equalCentering

        let headerHorizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, headerVerticalStackView])
        headerHorizontalStackView.spacing = 20
        
        let mainStackView = UIStackView(arrangedSubviews: [headerHorizontalStackView, whatsNewLabel, releaseNotesLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
