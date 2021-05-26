//
//  MoviesEndpoint.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

enum MoviesEndpoint: EndpointProtocol {
    case getMovies(page: Int)
    
//    https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&page=1&api_key=8477f03bc569ce2a7688ae7c56e24465&language=ru-RU
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        return "/3/discover/movie"
    }
    
    var params: [String : String] {
        switch self {
        case let .getMovies(page):
            return ["sort_by": "popularity.desc",
                    "language": "ru-RU",
                    "api_key":"8477f03bc569ce2a7688ae7c56e24465",
                    "page": "\(page)"
                    ]
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
