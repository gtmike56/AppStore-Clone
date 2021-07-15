//
//  TodayViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class TodayViewController: BaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        fetchApps()
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView.register(TodayViewCell.self, forCellWithReuseIdentifier: TodayCellModel.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppsCell.self, forCellWithReuseIdentifier: TodayCellModel.CellType.multiple.rawValue)
        
        collectionView.contentInset = .init(top: 30, left: 0, bottom: 30, right: 0)
        
        self.lastTabBarFrame = self.tabBarController?.tabBar.frame
    }
    
    var todayItems = [TodayCellModel]()
    
    fileprivate func fetchApps() {
        let dispatchGroup = DispatchGroup()
        
        var topFreeAppsGroup: AppSection?
        var newAppsGroup: AppSection?
        
        dispatchGroup.enter()
        APIService.shared.fetchTopFreeApps { appSection, error in
            if let error = error {
                print(error)
                return
            }
            topFreeAppsGroup = appSection
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchNewApps { appSection, error in
            if let error = error {
                print(error)
                return
            }
            newAppsGroup = appSection
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.todayItems = [
                TodayCellModel.init(categoty: "OUR FAVOURITES", title: topFreeAppsGroup?.feed.title ?? "Apps We Like", image: UIImage(named: "garden")!, description: "Test Description 1", apps: topFreeAppsGroup, cellType: .multiple),
                TodayCellModel.init(categoty: "THE BASICS", title: "The Gift Card for Everything Apple", image: UIImage(named: "appleGiftCard")!, description: "", apps: nil, cellType: .single),
                TodayCellModel.init(categoty: "OUR FAVOURITES", title: newAppsGroup?.feed.title ?? "Apps We Like", image: UIImage(named: "garden")!, description: "", apps: newAppsGroup, cellType: .multiple),
            ]
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .darkGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        return activity
    }()
    
    var appFullScreenController: AppFullScreenController?
    
    var startingFrame: CGRect?
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    var lastTabBarFrame: CGRect?
    
    
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = todayItems[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath)
        
        if let cell = cell as? TodayViewCell {
            cell.todayItem = todayItems[indexPath.item]
        } else if let cell = cell as? TodayMultipleAppsCell {
            cell.todayItem = todayItems[indexPath.item]
        }
        return cell
    }
    
    static let cellSize: CGFloat = 450
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 65, height: TodayViewController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        //get cell coordinates
        guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        startingFrame = startFrame
        
        let detailedVC = AppFullScreenController()
        detailedVC.view.layer.cornerRadius = 15
        view.addSubview(detailedVC.view)
        
        detailedVC.view.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = detailedVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: startFrame.origin.y)
        leadingConstraint = detailedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startFrame.origin.x)
        widthConstraint = detailedVC.view.widthAnchor.constraint(equalToConstant: startFrame.width)
        heightConstraint = detailedVC.view.heightAnchor.constraint(equalToConstant: startFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        self.appFullScreenController = detailedVC
        addChild(appFullScreenController!)
        appFullScreenController?.dismissHandler = {
            self.handleRemoveDetailedView()
        }
        appFullScreenController?.todayCellInfo = todayItems[indexPath.item]
        
        appFullScreenController?.tableView.reloadData()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            guard let cell = self.appFullScreenController?.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else {return}
            cell.todayCell.stackViewTopConstraint?.constant = 50
            cell.layoutIfNeeded()
            
            self.hideTabbar(self.tabBarController, self.lastTabBarFrame, self.view)
            
            self.collectionView.isUserInteractionEnabled = false
        } completion: { _ in }
        
    }
    
    @objc fileprivate func handleRemoveDetailedView(){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            
            self.appFullScreenController?.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else {return}
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            self.showTabbar(self.tabBarController, self.lastTabBarFrame)
            
            guard let cell = self.appFullScreenController?.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else {return}
            cell.todayCell.stackViewTopConstraint?.constant = 20
            cell.layoutIfNeeded()
        } completion: { _ in
            self.appFullScreenController?.view.removeFromSuperview()
            self.appFullScreenController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
    
    func showTabbar(_ tabBarController: UITabBarController?, _ lastTabBarFrame: CGRect?) {
        if #available(iOS 13, *) {
            UIView.animate(withDuration: 0.2, animations: {
                tabBarController?.tabBar.frame = lastTabBarFrame ?? .zero
            }, completion: { (_) in
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                tabBarController?.tabBar.transform = .identity
            }, completion: { (_) in
            })
        }
    }
    func hideTabbar(_ tabBarController: UITabBarController?, _ lastTabBarFrame: CGRect?, _ view: UIView) {
        if #available(iOS 13, *) {
            UIView.animate(withDuration: 0.2, animations: {
                tabBarController?.tabBar.frame = CGRect(x: 0, y: view.bounds.height + (lastTabBarFrame?.height ?? 0.0) + 20, width: lastTabBarFrame?.width ?? 0.0, height: lastTabBarFrame?.height ?? 0.0)
            }) { (_) in
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: tabBarController?.tabBar.frame.height ?? 0.0)
            }) { (_) in
            }
        }
    }
}

