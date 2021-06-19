//
//  APIService.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-05.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchJsonData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void){
        guard let url = URL(string: urlString) else {
            print("URL is not correct (fetchSection) ")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let err = error {
                completion(nil, err)
                return
            }
            
            guard let data = data else {
                print("There is no data (fetchApps) ")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                completion(result, nil)
                
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func fetchSearchedApps(searchText: String, completion: @escaping (SearchResult?, Error?) -> ()){
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        fetchJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFreeApps(completion: @escaping (AppSection? , Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-free/all/50/explicit.json"
        fetchJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaidApps(completion: @escaping (AppSection? , Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-paid/all/50/explicit.json"
        fetchJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchNewApps(completion: @escaping (AppSection? , Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/ca/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchJsonData(urlString: urlString, completion: completion)
    }
        
    func fetchAppsHeader(completion: @escaping ([AppsHeader]? , Error?) -> ()){
        let urlString = "https://gtmike56.github.io/Helpers/AppStore-Clone/appsPageHeaderAPI.json"
        fetchJsonData(urlString: urlString, completion: completion)
    }
    
}
