//
//  SortBy.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 10.06.2021.
//

import Foundation

enum SortBy: String {
    case popularity = "popularity.desc"
    case releaseDate = "primary_release_date.desc"
    case voteAverage = "vote_average.desc"
}
