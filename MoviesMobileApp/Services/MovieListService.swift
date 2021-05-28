//
//  NetworkManager.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

class MovieListService {
    
    private let apiService = ApiService<ResponseMovie>()
    
    func getList(page: Int, completion: @escaping ((Result<ResponseMovie, Error>) -> Void)) {
        apiService.performRequest(with: MoviesEndpoint.getMovies(page: page), completion: completion)
    }
}

