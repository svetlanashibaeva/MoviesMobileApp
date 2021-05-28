//
//  MovieDetailsService.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 28.05.2021.
//

import Foundation

class MovieDetailsService {
    
    private let apiService = ApiService<MovieDetail>()
    
    func movieDetail(id: Int, completion: @escaping ((Result<MovieDetail, Error>) -> Void)) {
        apiService.performRequest(with: MoviesEndpoint.getMovieDetails(id: id), completion: completion)
    }
}
