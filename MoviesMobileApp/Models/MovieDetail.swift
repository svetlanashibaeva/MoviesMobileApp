//
//  MovieDetail.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 28.05.2021.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let releaseDate: String?
    let posterPath: String?
    let overview: String?
    
    var genre: [String] {
        return ["Ужасы", "Фантастика"]
    }
    
    var imageURL: String? {
        guard let posterPath = posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w300/\(posterPath)"
    }
}
