//
//  ScreenshotCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    let screenshotImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.25
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(screenshotImageView)
        screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
        screenshotImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        screenshotImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        screenshotImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        screenshotImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
