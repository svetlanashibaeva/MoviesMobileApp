//
//  MoviesEndpoint.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

enum MoviesEndpoint {
    case getMovies(page: Int, filtersParams: [String: String])
    case getMovieDetails(id: Int)
    case searchMovies(query: String, page: Int)
    case getVideo(id: Int)
    case getGenre
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
        case .searchMovies:
            return "/3/search/movie"
        case let .getVideo(id):
            return "/3/movie/\(id)/videos"
        case .getGenre:
            return "/3/genre/movie/list"
        }
    }
    
    var params: [String : String] {
        var params = [
            "language": "ru-RU",
            "api_key":"8477f03bc569ce2a7688ae7c56e24465"
        ]
        
        switch self {
        case let .getMovies(page, filtersParams):
            if filtersParams.isEmpty {
                params["sort_by"] = "popularity.desc"
                params["vote_count.gte"] = "500"
            } else {
                filtersParams.forEach { key, value in
                    params[key] = value
                }
            }
            
            params["page"] = page.description
        case let .searchMovies(query, page):
            params["page"] = page.description
            params["query"] = query
        default:
            break
        }
        
        return params
    }

}
