//
//  AppFullScreenScontroller.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-03.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    fileprivate let cellID = "descriptionCell"
    
    var dismissHandler: (()->())?
    
    var todayCellInfo: TodayCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AppFullScreenCell.self, forCellReuseIdentifier: cellID)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: .zero, left: .zero, bottom: 20, right: .zero)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let headerCell = AppFullScreenHeaderCell()
            headerCell.closeBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.layer.cornerRadius = 0
            headerCell.todayCell.todayItem = todayCellInfo
            return headerCell
        } else {
             return AppFullScreenCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {return TodayViewController.cellSize}
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @objc fileprivate func handleDismiss(btn: UIButton){
        btn.isHidden = true
        dismissHandler?()
    }
}
