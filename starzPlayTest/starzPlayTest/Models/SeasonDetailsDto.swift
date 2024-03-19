//
//  SeasonDetailsDto.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import Foundation

struct SeasonDetailsDto: Codable {
    let _id: String?
    let air_date: String?
    let episodes: [EpisodeDTO]?
    let name: String?
    let overview: String?
    let id: Int?
    let poster_path: String?
    let season_number: Int?
    let vote_average: Double?
}

struct EpisodeDTO: Codable {
    let air_date: String?
    let episode_number: Int?
    let episode_type: String?
    let id: Int?
    let name: String?
    let overview: String?
    let production_code: String?
    let runtime: Int?
    let season_number: Int?
    let show_id: Int?
    let still_path: String?
    let vote_average: Double?
    let vote_count: Int?
    let crew: [CrewDTO]?
    let guest_stars: [GuestStarDTO]?
    
    var tvShowImgUrl: String {
        return "https://image.tmdb.org/t/p/original\(still_path ?? "")"
    }

}

struct CrewDTO: Codable {
    // Define properties of CrewDTO if available
}

struct GuestStarDTO: Codable {
    // Define properties of GuestStarDTO if available
}
