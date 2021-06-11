//
//  NetworkManager.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

class MovieListService {
    
    private let apiService = ApiService<ResponseMovie>()
    
    func getList(page: Int, filters: [Filter], completion: @escaping ((Result<ResponseMovie, Error>) -> Void)) {
        var params = [String: String]()
        filters.forEach { (filter) in
            params[filter.key] = filter.value
        }
        apiService.performRequest(with: MoviesEndpoint.getMovies(page: page, filtersParams: params), completion: completion)
    }
}

