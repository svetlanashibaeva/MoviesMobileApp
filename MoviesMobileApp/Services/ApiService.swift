//
//  ApiService.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 28.05.2021.
//

import Foundation

class ApiService<T: Decodable> {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder? = nil) {
        if let decoder = decoder {
            self.decoder = decoder
        } else {
            self.decoder = JSONDecoder()
            self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
    }
    
    func performRequest(with endpoint: EndpointProtocol, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = buildUrl(with: endpoint) else { return completion(Result.failure(ApiError.urlError)) }
        
        resumeTask(url: url, completion: completion)
    }
    
    private func buildUrl(with endpoint: EndpointProtocol) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        return urlComponents.url
    }
    
    private func resumeTask(url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let result = self.parseJSON(withData: data) {
                    completion(Result.success(result))
                } else {
                    completion(Result.failure(ApiError.parseError))
                }
            } else if let error = error {
                completion(Result.failure(error))
            } else {
                completion(Result.failure(ApiError.unkmownError))
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}
