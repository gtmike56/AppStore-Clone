//
//  AppReviewsController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class AppReviewsController: HorizontalSnappingController {
    
    let reviewCellId = "reviewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
    }

}

extension AppReviewsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 40, height: view.frame.height)
    }
}
