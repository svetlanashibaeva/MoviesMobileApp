//
//  MovieVideoService.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 03.06.2021.
//

import Foundation

class MovieVideoService {
    
    private let apiService = ApiService<ResponseVideo>()
    
    func movieVideo(id: Int, completion: @escaping ((Result<ResponseVideo, Error>) -> Void)) {
        apiService.performRequest(with: MoviesEndpoint.getVideo(id: id), completion: completion)
    }
}
