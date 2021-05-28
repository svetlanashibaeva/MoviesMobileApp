//
//  DataModel.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

struct ResponseMovie: Decodable {
    let page: Int
    let results: [MovieStruct]
}

struct MovieStruct: Decodable {
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    var imageURL: String? {
        guard let posterPath = posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w300/\(posterPath)"
    }
}


