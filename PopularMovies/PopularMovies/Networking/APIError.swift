//
//  APIError.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import Foundation

// Error class for handling networking errors
enum APIError: Error, CustomNSError {
    case apiError(Error)
    case invalidEndpoint(Error)
    case invalidResponse(Error)
    case noData(Error)
    case serializationError(Error)

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
