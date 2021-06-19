//
//  HeaderHorizontalController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-09.
//

import UIKit

fileprivate let reuseIdentifier = "appsHeaderCellID"

class AppsHeaderHorizontalController: BaseCollectionViewController {
    
    var appsHeader = [AppsHeader]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppHeaderCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

}

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsHeader.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AppHeaderCell else { return UICollectionViewCell() }
        let app = appsHeader[indexPath.item]
        cell.companyLabel.text = app.name
        cell.textLabel.text = app.tagline
        ImageCacheService.shared.loadAppImage(imageURL: app.imageUrl) { appIcon in
            cell.imageView.image = appIcon
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width-40, height: view.frame.height)
    }

}
