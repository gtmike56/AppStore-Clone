//
//  AppFullScreenCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-03.
//

import UIKit

class AppFullScreenCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Introducing the", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " all-new Apple Gift Card.", attributes: [.foregroundColor: UIColor.gray]))
                
        attributedText.append(NSAttributedString(string: "\n\nWith the Apple Gift Card, customers can purchase Apple products and acccessories, apps, games, musics, movies, TV shows, subscribtions, iCloud storage, and more.", attributes: [.foregroundColor: UIColor.gray]))
                
        attributedText.append(NSAttributedString(string: "\n\nSoon you can purchase the Apple Gift Card in the Apple Store app, on apple.com, and at Apple retail locations and top retailers including Shoppers Drug Mart, Loblaws, Walmart, Sobeys, Circle K.", attributes: [.foregroundColor: UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
