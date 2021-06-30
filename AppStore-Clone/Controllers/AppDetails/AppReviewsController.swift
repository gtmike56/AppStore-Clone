//
//  AppReviewsController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class AppReviewsController: HorizontalSnappingController {
    
    let reviewCellId = "reviewCell"
    
    var appReviews: AppReviews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        collectionView.contentInset = .init(top: 0, left: 15, bottom: 15, right: 15)
    }

}

extension AppReviewsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appReviews?.feed.entry.count ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
        if let appReview = appReviews?.feed.entry[indexPath.item] {
            cell.authorLabel.text = appReview.author.name.label
            cell.titleLabel.text = appReview.title.label
            cell.reviewBodyLabel.text = appReview.content.label
            for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
                if let rating = Int(appReview.rating.label) {
                    if index >= rating {
                        view.alpha = 0
                    } else {
                        view.alpha = 1
                    }
                }
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: view.frame.height)
    }
}
