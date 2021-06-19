//
//  AppSectionModel.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-10.
//

import Foundation

struct AppSection: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
    
}
