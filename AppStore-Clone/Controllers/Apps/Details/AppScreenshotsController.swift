//
//  AppScreenshotsController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class AppScreenshotsController: HorizontalSnappingController {
    
    let screenshotCellId = "screenshotCell"
    
    var app: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellId)
    }
}

extension AppScreenshotsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as? ScreenshotCell else { return UICollectionViewCell() }
        if let app = app {
            ImageCacheService.shared.loadAppImage(imageURL: app.screenshotUrls[indexPath.item]) { appIcon in
                cell.screenshotImageView.image = appIcon
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

