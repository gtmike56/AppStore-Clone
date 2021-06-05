//
//  SearchViewController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

import UIKit

class SearchViewController: UICollectionViewController {
    
    let cellID = "searchCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"

        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        
        fetchApps()
    }
    
    fileprivate func fetchApps(){
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        
        guard let url = URL(string: urlString) else {
            print("URL is not correct (fetchApps) ")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let err = error {
                print("Error fetching the apps: ", err)
                return
            }
            
            guard let data = data else {
                print("There is no data (fetchApps) ")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                
            } catch {
                print("There is an error decoding JSON (fetchApps) ", error)
            }
            
            
        }
        
        task.resume()
    }
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        cell.appNameLabel.text = "App Name"
        return cell
    }
}
