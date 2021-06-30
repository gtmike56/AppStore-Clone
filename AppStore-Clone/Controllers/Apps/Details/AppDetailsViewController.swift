//
//  AppDetailsViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-26.
//

import UIKit

class AppDetailsViewController: BaseCollectionViewController {
    
    var appID: String?
    
    let cellDetailsID = "appDetailsCell"
    let screenshotsCellId = "appScreenshotsCell"
    let reviewsCellId = "appReviresCell"
    
    var app: Result?
    
    override func viewDidLoad() {
        
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppDetailsCell.self, forCellWithReuseIdentifier: cellDetailsID)
        collectionView.register(AppScreenshotsCell.self, forCellWithReuseIdentifier: screenshotsCellId)
        collectionView.register(AppReviewsCell.self, forCellWithReuseIdentifier: reviewsCellId)
        
        fetchAppDetails()
    }
    
    func fetchAppDetails() {
        guard let appID = appID else { return }
        APIService.shared.fetchAppDetails(appId: appID) { [ self] searchResult, error in
            if let error = error {
                print(error)
                return
            }
            app = searchResult?.results.first
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
}

extension AppDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellDetailsID, for: indexPath) as? AppDetailsCell else { return UICollectionViewCell() }
            if let app = app {
                cell.nameLabel.text = app.trackName
                ImageCacheService.shared.loadAppImage(imageURL: app.artworkUrl512) { appIcon in
                    cell.appIconImageView.image = appIcon
                }
                cell.releaseNotesLabel.text = app.releaseNotes
                cell.priceButton.setTitle(app.formattedPrice, for: .normal)
            }
            return cell
        } else if indexPath.item == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotsCellId, for: indexPath) as? AppScreenshotsCell else { return UICollectionViewCell() }
            if let app = app {
                cell.horizontalController.app = app
                cell.horizontalController.collectionView.reloadData()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as? AppReviewsCell else { return UICollectionViewCell() }
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let cell = AppDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            cell.releaseNotesLabel.text = app?.releaseNotes
            cell.layoutIfNeeded()
            return .init(width: view.frame.width, height: cell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000)).height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        } else {
            return .init(width: view.frame.width, height: 300)
        }
    }
    
    
}
