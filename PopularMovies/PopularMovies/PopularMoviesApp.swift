//
//  PopularMoviesApp.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import SwiftUI

@main
struct PopularMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            // Entry point for the app
            MovieListView(viewModel: MovieListingViewModel(movieListingAPI: MovieListingAPI()))
        }
    }
}
