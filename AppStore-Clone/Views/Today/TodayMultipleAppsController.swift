//
//  TodayMultipleAppsController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-14.
//

import UIKit

class TodayMultipleAppsController: BaseCollectionViewController {
    
    fileprivate let todayAppCellId = "todayAppCell"
    
    var apps: [FeedResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TodayAppCell.self, forCellWithReuseIdentifier: todayAppCellId)
        collectionView.isScrollEnabled = false
        
    }
    
    fileprivate let spacing: CGFloat = 20
    
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayAppCellId, for: indexPath) as? TodayAppCell else {return UICollectionViewCell()}
        guard let app = apps?[indexPath.item] else { return cell }
        cell.appCompanyLabel.text = app.artistName
        cell.appNameLabel.text = app.name
        ImageCacheService.shared.loadAppImage(imageURL: app.artworkUrl100) { appIcon in
            cell.appImageView.image = appIcon
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
