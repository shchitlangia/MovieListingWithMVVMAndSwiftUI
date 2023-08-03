//
//  MockMovieDetailsAPI.swift
//  PopularMoviesTests
//
//  Created by Shweta Chitlangia on 04/08/23.
//

import Foundation
@testable import PopularMovies

class MockMovieDetailsAPI: MovieDetailsAPIProtocol {
    var mockMovieDetailsResponse: Result<Movie, APIError>?
    private let request: MovieDetailsRequest
    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
        let endpoint = "\(Endpoints.movieDetails)\(movieId)"
        request = MovieDetailsRequest(queryParams: [APIKeys.apiKey: APIConstants.apiKey],
                                      endpoint: endpoint)
    }
    
    func fetchMovieDetails(completion: @escaping (Result<Movie, APIError>) -> Void) {
        if let response = mockMovieDetailsResponse {
            completion(response)
        }
    }
}
