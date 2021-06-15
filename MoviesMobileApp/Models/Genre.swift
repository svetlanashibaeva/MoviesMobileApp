//
//  Genre.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 28.05.2021.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable, Equatable {
    let id: Int
    let name: String
}
