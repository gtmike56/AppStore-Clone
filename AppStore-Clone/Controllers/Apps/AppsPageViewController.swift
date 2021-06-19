//
//  AppsViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class AppsPageViewController: BaseCollectionViewController {
    
    let cellID = "appsCell"
    let headerID = "appsHeader"
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        
        collectionView.backgroundColor = .white
        title = "Apps"
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        fetchData()
    }
        
    var appGroups: [Feed] = []
    var appsHeader: [AppsHeader] = []
    
    fileprivate func fetchData() {
        
        var header: [AppsHeader]?
        var group1: Feed?
        var group2: Feed?
        var group3: Feed?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchAppsHeader { apps, error in
            dispatchGroup.leave()
            if let error = error {
                print(error)
                return
            }
            header = apps
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchTopFreeApps { appSection, error in
            dispatchGroup.leave()
            if let error = error {
                print(error)
                return
            }
            group1 = appSection?.feed
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchNewApps { appSection, error in
            dispatchGroup.leave()
            if let error = error {
                print(error)
                return
            }
            group2 = appSection?.feed
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchTopPaidApps { appSection, error in
            dispatchGroup.leave()
            if let error = error {
                print(error)
                return
            }
            group3 = appSection?.feed
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            if let header = header {
                appsHeader = header
            }
            if let group = group1 {
                appGroups.append(group)
            }
            if let group = group2 {
                appGroups.append(group)
            }
            if let group = group3 {
                appGroups.append(group)
            }
            activityIndicatorView.stopAnimating()
            collectionView.reloadData()
        }
        
        
    }
    
}

extension AppsPageViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? AppsGroupCell else { return UICollectionViewCell() }
        
        let appSection = appGroups[indexPath.item]
        
        cell.titleLabel.text = appSection.title
        cell.horizontalController.appSectionFeed = appSection
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? AppsPageHeader else { return UICollectionReusableView() }
        header.headerHorizontalController.appsHeader = appsHeader
        header.headerHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
}
