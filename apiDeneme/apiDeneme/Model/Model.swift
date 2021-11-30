//
//  MoviesData.swift
//  apiDeneme
//
//  Created by selin eylül bilen on 11/30/21.
//

import Foundation

struct MoviesData: Codable{
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey{
        case title, overview
        case year = "released_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}
