//
//  MovieDetailsViewModel.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Combine
import Foundation

// View model for Movie Details
final class MovieDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var selectedMovie: Movie?
    
    private let movieDetailsAPI: MovieDetailsAPIProtocol
    
    // MARK: - Initializer
    init(movieDetailsAPI: MovieDetailsAPIProtocol) {
        self.movieDetailsAPI = movieDetailsAPI
    }

    // MARK: - API Calls
    func fetchMovieDetails() {
        isLoading = true
        movieDetailsAPI.fetchMovieDetails { [weak self] result in
            self?.isLoading = false
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetails):
                    self?.selectedMovie = movieDetails

                case .failure(let error):
                    debugPrint("Error fetching movie details: \(error)")
                }
            }
        }
    }
}
