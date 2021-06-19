//
//  AppRowCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-08.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let appImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 62).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 62).isActive = true
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = UIStackView(arrangedSubviews: [appNameLabel, appCompanyLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2.5
        
        let mainStackView = UIStackView(arrangedSubviews: [appImageView, labelsStackView, getButton])
        mainStackView.spacing = 15
        mainStackView.alignment = .center
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
