//
//  MovieDetailsAPI.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

// Protocol to support better testability of code
protocol MovieDetailsAPIProtocol {
    func fetchMovieDetails(completion: @escaping (Result<Movie, APIError>) -> Void)
}

// Service class for fetching movie details
final class MovieDetailsAPI: MovieDetailsAPIProtocol {
    private let request: MovieDetailsRequest
    
    init(movieId: Int) {
        let endpoint = "\(Endpoints.movieDetails)\(movieId)"
        request = MovieDetailsRequest(queryParams: [APIKeys.apiKey: APIConstants.apiKey],
                                      endpoint: endpoint)
    }
    
    func fetchMovieDetails(completion: @escaping (Result<Movie, APIError>) -> Void) {
        RequestManager().performRequest(with: request) { (result: Result<Movie, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
