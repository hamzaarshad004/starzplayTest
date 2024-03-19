//
//  TVShowListResponse.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let originalName: String
    let overview: String
    let firstAirDate: String
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]
    let originCountry: [String]
    let adult: Bool
    let originalLanguage: String
    
    var tvShowImgUrl: String {
        return "https://image.tmdb.org/t/p/original\(posterPath ?? "")"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, overview
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case originCountry = "origin_country"
        case adult
        case originalLanguage = "original_language"
    }
}

struct TVShowListResponse: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
