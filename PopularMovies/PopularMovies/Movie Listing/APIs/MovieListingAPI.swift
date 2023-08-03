//
//  MovieListingAPI.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

// Protocol to support better testability of code
protocol MovieListingAPIProtocol {
    func fetchMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
}

// Service class for fetching top 10 popular movies
final class MovieListingAPI: MovieListingAPIProtocol {
    func fetchMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        let movieListingRequest = MovieListingRequest(queryParams: [APIKeys.apiKey: APIConstants.apiKey],
                                                                 endpoint: Endpoints.popular)
        RequestManager().performRequest(with: movieListingRequest) { (result: Result<MovieResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
