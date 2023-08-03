//
//  Movie.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import Foundation

// Movie Model for Pouplar Listing & Movie Details
struct Movie: Decodable, Identifiable, Hashable {
    let adult: Bool?
    let voteCount: Int?
    let id: Int
    let backdropPath: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let voteAverage: Double?
    let genres: [MovieGenre]?

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }

    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }

    var genreText: String {
        genres?.first?.name ?? "n/a"
    }

    var ratingText: String {
        let rating = Int(voteAverage ?? 0)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct MovieGenre: Decodable {
    let name: String
}
