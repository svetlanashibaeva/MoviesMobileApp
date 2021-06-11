//
//  Filter.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 11.06.2021.
//

import Foundation

enum Filter {
    case sortBy(by: String)
    case genres(by: [Genre])
    case rating(by: String)
    
    var key: String {
        switch self {
        case .sortBy:
            return "sort_by"
        case .genres:
            return "with_genres"
        case .rating:
            return "vote_average.gte"
        }
    }
    
    var value: String {
        switch self {
        case let .sortBy(by: sort):
            return sort
        case let .genres(by: genres):
            return genres.map({ $0.id.description })
                .joined(separator: ", ")
        case let .rating(by: rating):
            return rating
        }
    }
}
