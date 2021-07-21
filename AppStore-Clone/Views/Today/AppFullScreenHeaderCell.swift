//
//  AppFullScreenHeaderCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-13.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayViewCell()
        
    let closeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(todayCell)
        todayCell.translatesAutoresizingMaskIntoConstraints = false
        todayCell.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        todayCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        todayCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        todayCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
