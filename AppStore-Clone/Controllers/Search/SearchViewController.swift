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
        cell.appResult = appResults[indexPath.item]
        return cell
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
