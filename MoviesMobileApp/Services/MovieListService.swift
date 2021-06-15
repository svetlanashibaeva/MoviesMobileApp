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
       
        let params = filters.reduce([String: String]()) { result, filter in
            var result = result
            result.merge(filter.additionalParams) { current, _ in current}
            return result
        }
        
        apiService.performRequest(with: MoviesEndpoint.getMovies(page: page, filtersParams: params), completion: completion)
    }
}

