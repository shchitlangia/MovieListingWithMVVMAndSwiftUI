//
//  MockMovieListingAPI.swift
//  PopularMoviesTests
//
//  Created by Shweta Chitlangia on 04/08/23.
//

import Foundation
@testable import PopularMovies

// Create a mock implementation of MovieListingAPI for testing
class MockMovieListingAPI: MovieListingAPIProtocol {
    var mockMovieListingResponse: Result<[Movie], APIError>?

    func fetchMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        if let mockMovieListingResponse = mockMovieListingResponse {
            completion(mockMovieListingResponse)
        }
    }
}
