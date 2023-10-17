//
//  PopularResponseModel.swift
//  NetworkExample
//
//  Created by Ahmet Utlu on 12.10.2023.
//

import Foundation

struct PopularResponseModel: Codable {
    
    let page: Int
    let results: [PopularMoviesModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct PopularMoviesModel: Codable {
    let adult: Bool
        let backdropPath: String
        let genreIDS: [Int]
        let id: Int
        let originalTitle, overview: String
        let popularity: Double
        let posterPath, releaseDate, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
}
