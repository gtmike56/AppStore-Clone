//
//  AppsPageHeader.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-09.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let headerHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerHorizontalController.view)
        headerHorizontalController.view.translatesAutoresizingMaskIntoConstraints = false
        headerHorizontalController.view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        headerHorizontalController.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        headerHorizontalController.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        headerHorizontalController.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
