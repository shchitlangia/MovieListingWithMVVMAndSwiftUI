//
//  MovieListingViewModel.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import Combine
import Foundation

// View model for Popular Listing
final class MovieListingViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var selectedMovie: Movie?
    @Published var isLoading: Bool = true

    private let movieListingAPI: MovieListingAPIProtocol
    
    // MARK: - Initializer
    init(movieListingAPI: MovieListingAPIProtocol) {
        self.movieListingAPI = movieListingAPI
    }

    // MARK: - API Calls
    func fetchPopularMovies() {
        isLoading = true
        movieListingAPI.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    
                case .failure(let error):
                    debugPrint("Error fetching popular movies: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
        }
    }
    
    // MARK: - Helpers
    func hasMoviesData() -> Bool {
        if let movies {
            return movies.count >= 10
        }
        return false
    }
}
