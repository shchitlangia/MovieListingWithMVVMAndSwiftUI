//
//  MovieListingRequest.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

// Request abstraction for fetching popular movies
struct MovieListingRequest: Request {
    typealias Response = MovieResponse

    let queryParams: [String: String]?
    let endpoint: String
}
