//
//  AppsHorizontalController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-06.
//

import UIKit

class AppsHorizontalController: BaseCollectionViewController {
    
    let cellID = "appsHorizontalCellId"
    
    var appSectionFeed: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appSectionFeed?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? AppRowCell else { return UICollectionViewCell() }
        guard let app = appSectionFeed?.results[indexPath.item] else { return UICollectionViewCell() }
        cell.appNameLabel.text = app.name
        cell.appCompanyLabel.text = app.artistName
        ImageCacheService.shared.loadAppImage(imageURL: app.artworkUrl100) { appIcon in
            cell.appImageView.image = appIcon
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 30, height: (view.frame.height-40)/3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
