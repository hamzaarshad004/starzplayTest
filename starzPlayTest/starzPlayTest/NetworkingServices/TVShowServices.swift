//
//  TVShowServices.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import Foundation
import Alamofire

class TVShowServices {
    
    func fetchPopularTVShows(completion: @escaping (Result<TVShowListResponse, Error>) -> Void) {
        
        let getTVShows = APIURLs.getTVShows
        let url = "\(getTVShows.baseURL)\(getTVShows.path)"
        
        // Define the parameters
        let parameters: [String: Any] = [
            "api_key": "ecef14eac236a5d4ec6ac3a4a4761e8f", // Replace with your actual API key
            "language": "en-US",
            "page": 1
        ]
        
        // Make the network request using Alamofire
        AF.request(url, parameters: parameters).responseDecodable(of: TVShowListResponse.self) { response in
            switch response.result {
            case .success(let tvShowListResponse):
                completion(.success(tvShowListResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchTVShowDetails(showId: Int, completion: @escaping (Result<TVShowDetailsDto, Error>) -> Void) {
        
        let getTVShowsDetails = APIURLs.getTVShowDetails(showId: showId)
        let url = "\(getTVShowsDetails.baseURL)\(getTVShowsDetails.path)"
        
        // Define the parameters
        let parameters: [String: Any] = [
            "api_key": "ecef14eac236a5d4ec6ac3a4a4761e8f"
        ]
        
        // Make the network request using Alamofire
        AF.request(url, parameters: parameters).responseDecodable(of: TVShowDetailsDto.self) { response in
            switch response.result {
            case .success(let tvShowListResponse):
                completion(.success(tvShowListResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSeasonDetails(showId: Int, seasonId: Int, completion: @escaping (Result<SeasonDetailsDto, Error>) -> Void) {
        
        let getTVShowsDetails = APIURLs.getSeasonDetails(showId: showId, seasonId: seasonId)
        let url = "\(getTVShowsDetails.baseURL)\(getTVShowsDetails.path)"
        
        // Define the parameters
        let parameters: [String: Any] = [
            "api_key": "ecef14eac236a5d4ec6ac3a4a4761e8f"
        ]
        
        // Make the network request using Alamofire
        AF.request(url, parameters: parameters).responseDecodable(of: SeasonDetailsDto.self) { response in
            switch response.result {
            case .success(let tvShowListResponse):
                completion(.success(tvShowListResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
