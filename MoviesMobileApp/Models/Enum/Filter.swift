//
//  Filter.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 11.06.2021.
//

import Foundation

enum Filter {
    case sortBy(by: SortBy)
    case genres(by: [Genre])
    case rating(by: String)
    
    var additionalParams: [String: String] {
        switch self {
        case let .sortBy(by: sort):
            return ["sort_by": sort.rawValue, "vote_count.gte": sort == .voteAverage ? "5000" : "500"]
        case let .genres(by: genres):
            return ["with_genres": genres.map({ $0.id.description }).joined(separator: ", ")]
        case let .rating(by: rating):
            return ["vote_average.gte": rating]
        }
    }
}
