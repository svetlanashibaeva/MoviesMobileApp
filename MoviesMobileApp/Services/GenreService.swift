//
//  GenreService.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 08.06.2021.
//

import Foundation

class GenreService {
    private let apiService = ApiService<GenreResponse>()
    
    func genresList(completion: @escaping ((Result<GenreResponse, Error>) -> Void)) {
        apiService.performRequest(with: MoviesEndpoint.getGenre, completion: completion)
    }
}
