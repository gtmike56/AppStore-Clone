//
//  TodayCellModel.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-13.
//

import UIKit

struct TodayCellModel {
    let categoty: String
    let title: String
    let image: UIImage
    let description: String
    
    let apps: AppSection?
    
    let cellType: CellType
    
    enum CellType: String {
        case single, multiple
    }
}
