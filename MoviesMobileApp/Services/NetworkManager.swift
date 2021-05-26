//
//  NetworkManager.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

class NetworkManager {

    func performRequest(with endpoint: EndpointProtocol, completion: @escaping ((Result<[MovieStruct], Error>) -> Void)) {
            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.scheme
            urlComponents.host = endpoint.host
            urlComponents.path = endpoint.path
            urlComponents.queryItems = endpoint.params.map({ (key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: value)
            })
            guard let url = urlComponents.url else { return completion(Result.failure(MyError.urlError)) }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let moviesData = self.parseJSON(withData: data) {
                        completion(Result.success(moviesData.results))
                    } else {
                        completion(Result.failure(MyError.parseError))
                    }
                } else if let error = error {
                    completion(Result.failure(error))
                } else {
                    completion(Result.failure(MyError.unkmownError))
                }
            }
            task.resume()
        }
    
//    func performRequest(with endpoint: EndpointProtocol, completion: @escaping ((ResponseMovie) -> Void)) {
//         var urlComponents = URLComponents()
//         urlComponents.scheme = endpoint.scheme
//         urlComponents.host = endpoint.host
//         urlComponents.path = endpoint.path
//         urlComponents.queryItems = endpoint.params.map({ (key, value) -> URLQueryItem in
//             URLQueryItem(name: key, value: value)
//         })
//
//         guard let url = urlComponents.url else { return }
//            print(url)
//         let session = URLSession(configuration: .default)
//         let task = session.dataTask(with: url) { (data, response, error) in
//             if let data = data {
//                 if let moviesData = self.parseJSON(withData: data) {
//                     completion(moviesData)
//                 }
//             }
//         }
//         task.resume()
//    }
    
        
        private func parseJSON(withData data: Data) -> ResponseMovie? {
            let decoder = JSONDecoder()
            return try? decoder.decode(ResponseMovie.self, from: data)
        }
}

