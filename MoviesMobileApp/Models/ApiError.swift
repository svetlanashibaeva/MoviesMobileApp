//
//  Error.swift
//  MoviesMobileApp
//
//  Created by Света Шибаева on 25.05.2021.
//

import Foundation

enum ApiError: LocalizedError {
    case urlError
    case unkmownError
    case parseError
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "url error"
        case .unkmownError:
            return "unknown error"
        case .parseError:
            return "parse error"
        }
    }
}
