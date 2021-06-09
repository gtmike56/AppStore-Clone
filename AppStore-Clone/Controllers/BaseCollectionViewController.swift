//
//  BaseListController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-06.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
