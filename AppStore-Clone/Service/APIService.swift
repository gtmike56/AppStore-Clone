//
//  APIService.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-05.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchApps(searchText: String ,completion: @escaping ([Result], Error?) -> ()){
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        
        guard let url = URL(string: urlString) else {
            print("URL is not correct (fetchApps) ")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let err = error {
                completion([], err)
                return
            }
            
            guard let data = data else {
                print("There is no data (fetchApps) ")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(result.results, nil)
                
            } catch {
                completion([], error)
            }

        }
        task.resume()
    }
}
