//
//  TodayViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class TodayViewController: BaseCollectionViewController {
    
    fileprivate var cellId = "todayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
                
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView.register(TodayViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = .init(top: 30, left: 0, bottom: 30, right: 0)
        
        self.lastTabBarFrame = self.tabBarController?.tabBar.frame
    }
    
    let todayItems = [
        TodayCellModel.init(categoty: "Test Category 1", title: "Test Title 1", image: UIImage(named: "garden")!, description: "Test Description 1", backgroundColor: .white),
        TodayCellModel.init(categoty: "Test Category 2", title: "Test Title 2", image: UIImage(named: "garden")!, description: "Test Description 2", backgroundColor: .white)
    ]
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayViewCell
        cell.todayItem = todayItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 65, height: 450)
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

