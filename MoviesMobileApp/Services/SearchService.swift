//
//  SearchService.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 31.05.2021.
//

import Foundation

class SearchService {
    
    private let apiService = ApiService<ResponseMovie>()
    
    func getList(query: String, page: Int, completion: @escaping ((Result<ResponseMovie, Error>) -> Void)) {
        apiService.performRequest(with: MoviesEndpoint.searchMovies(query: query, page: page), completion: completion)
    }
}
