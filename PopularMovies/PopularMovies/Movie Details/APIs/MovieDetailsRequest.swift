//
//  MovieDetailsRequest.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

// Request abstraction for fetching movie details
struct MovieDetailsRequest: Request {
    typealias Response = Movie

    let queryParams: [String: String]?
    let endpoint: String
}
