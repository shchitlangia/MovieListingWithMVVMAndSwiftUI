//
//  MovieDetailView.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import Foundation
import SwiftUI

// Movie details view comprising of title, overview, rating, genre etc
struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    // MARK: - Initializer
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if let movieDetails = viewModel.selectedMovie {
                ScrollView {
                    VStack(alignment: .center) {
                        AsyncImage(url: movieDetails.backdropURL) { phase in
                            if let image = phase.image {
                                // Displays the loaded image
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(20)
                            } else if phase.error != nil {
                                // Indicates an error, show default image
                                Text("No image available")
                                    .padding()
                                    .foregroundColor(.black)
                            } else {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                        }
                        .accessibilityIdentifier("backdrop")
                        .frame(width: 100, height: 150, alignment: .center)
                        
                        Text(movieDetails.overview ?? "")
                            .titleStyle()
                            .accessibilityIdentifier("overview")
                        Text("Release Date: \(movieDetails.releaseDate ?? "NA")")
                            .titleStyle()
                            .accessibilityIdentifier("releaseDate")
                        Text("Genre: \(movieDetails.genreText)")
                            .titleStyle()
                            .accessibilityIdentifier("genre")
                        Text("Rating: \(movieDetails.ratingText)")
                            .titleStyle()
                            .accessibilityIdentifier("rating")
                    }
                }
                .accessibilityIdentifier("moviedetailsView")
                .padding()
                .navigationTitle(movieDetails.title)
            } else {
                // Show loading indicator or error message
                Text("Loading...")
            }
        }.onAppear {
            viewModel.fetchMovieDetails()
        }.refreshable {
            viewModel.fetchMovieDetails()
        }
    }
}
