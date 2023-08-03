//
//  MovieListView.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

// Listing of top 10 popular movies
struct MovieListView: View {
    @ObservedObject var viewModel: MovieListingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.hasMoviesData(), let movies = viewModel.movies?.prefix(10) {
                    // If we have more than 10 elements, load them in the list
                    List(movies) { movie in
                        let movieDetailsModel = MovieDetailsViewModel(movieDetailsAPI: MovieDetailsAPI(movieId: movie.id))
                        NavigationLink(destination: MovieDetailsView(viewModel: movieDetailsModel)) {
                            movieRowView(for: movie)
                        }
                    }
                    .accessibilityIdentifier("movieList")
                    .scrollContentBackground(.hidden)
                    .listRowSeparator(.hidden)
                    .background(Color.clear.ignoresSafeArea())
                } else if viewModel.isLoading {
                    // Handle loader for API
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    // Handle no network condition
                    Text("Error loading Movie Listing data")
                        .titleStyle()
                }
            }
            .onAppear {
                viewModel.fetchPopularMovies()
            }
            .refreshable {
                viewModel.fetchPopularMovies()
            }
            .navigationBarTitle("Popular Movies", displayMode: .inline)
        }
        .foregroundColor(.clear)
    }
    
    @ViewBuilder
    // Row View for Listing of popular movies
    private func movieRowView(for movie: Movie) -> some View {
        VStack(alignment: .center) {
            /* Using WebImage - AsyncImage with caching support (SDWebImage)
             Can use AsyncImage, but it is buggy with List. Image Request gets cancelled on scroll.
             */
            WebImage(url: movie.posterURL)
                .resizable()
                .retryOnAppear(true)
                .placeholder(Image(systemName: "photo")) // Placeholder Image
                .placeholder {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .accessibilityIdentifier("movieImage")
                .cornerRadius(20)
                .padding([.leading, .trailing], 10)
        }
    }
}
