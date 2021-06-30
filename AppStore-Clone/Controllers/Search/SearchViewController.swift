//
//  SearchViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class SearchViewController: BaseCollectionViewController {
    
    fileprivate let cellID = "searchCell"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var appResults = [Result]()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        
        setupSearchBar()
        
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Games, Apps, Stories, and More"
    }
    
    fileprivate func fetchApps(searchText: String){
        APIService.shared.fetchSearchedApps(searchText: searchText) { [self] (searchResult, err)  in
            
            if let error = err {
                print("Failed to fetch the apps" ,error)
                return
            }
            if let searchResult = searchResult {
                appResults = searchResult.results
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 355)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SearchResultCell
        else { return UICollectionViewCell() }
        let app = appResults[indexPath.item]
        cell.appNameLabel.text = app.trackName
        cell.appCategoryLabel.text = app.primaryGenreName
        
        if let appRating = app.averageUserRating {
            cell.appRatingLabel.text = "Rating: \(String(format: "%.2f", appRating))"
        } else {
            cell.appRatingLabel.text = "No rating yet"
        }
        
        ImageCacheService.shared.loadAppImage(imageURL: app.artworkUrl512) { appIcon in
            cell.appImageView.image = appIcon
            
        }
        ImageCacheService.shared.loadAppImage(imageURL: app.screenshotUrls[0]) { appIcon in
            cell.screenshotImage1.image = appIcon
            
        }
        if app.screenshotUrls.count > 1 {
            ImageCacheService.shared.loadAppImage(imageURL: app.screenshotUrls[1]) { appIcon in
                cell.screenshotImage2.image = appIcon
            }
        }
        if app.screenshotUrls.count > 2 {
            ImageCacheService.shared.loadAppImage(imageURL: app.screenshotUrls[2]) { appIcon in
                cell.screenshotImage3.image = appIcon
                
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = appResults[indexPath.item]
        let appDetailsController = AppDetailsViewController(appId: String(app.trackId))
        navigationController?.pushViewController(appDetailsController, animated: true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.fetchApps(searchText: searchText)
        })
    }
}
