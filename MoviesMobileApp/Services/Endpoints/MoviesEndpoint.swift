//
//  MoviesEndpoint.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

enum MoviesEndpoint {
    case getMovies(page: Int)
    case getMovieDetails(id: Int)
}

extension MoviesEndpoint: EndpointProtocol {
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/3/discover/movie"
        case let .getMovieDetails(id):
            return "/3/movie/\(id)"
        }
        
    }
    
    var params: [String : String] {
        var params = [
            "language": "ru-RU",
            "api_key":"8477f03bc569ce2a7688ae7c56e24465"
        ]
        
        switch self {
        case let .getMovies(page):
            params["sort_by"] = "popularity.desc"
            params["page"] = "\(page)"
        default:
            break
        }
        
        return params
    }

}
