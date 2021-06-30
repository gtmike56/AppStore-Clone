//
//  App.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-04.
//

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl512: String
    let formattedPrice: String?
    let description: String?
    let releaseNotes: String?
}
