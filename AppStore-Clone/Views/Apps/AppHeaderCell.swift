//
//  AppHeaderCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-09.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Facebook"
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .systemBlue
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Keeping up with friends is faster than ever"
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 2
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mainStackView = UIStackView(arrangedSubviews: [companyLabel, textLabel, imageView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
