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
        self.makeNetworkCall(apiUrl: getTVShows, completion: completion)
    }

    func fetchTVShowDetails(showId: Int, completion: @escaping (Result<TVShowDetailsDto, Error>) -> Void) {
        
        let getTVShowsDetails = APIURLs.getTVShowDetails(showId: showId)
        self.makeNetworkCall(apiUrl: getTVShowsDetails, completion: completion)
    }
    
    func fetchSeasonDetails(showId: Int, seasonId: Int, completion: @escaping (Result<SeasonDetailsDto, Error>) -> Void) {
        
        let getSeasonDetails = APIURLs.getSeasonDetails(showId: showId, seasonId: seasonId)
        self.makeNetworkCall(apiUrl: getSeasonDetails, completion: completion)
        
    }

    func makeNetworkCall<T: Decodable>(apiUrl: APIURLs, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = "\(apiUrl.baseURL)\(apiUrl.path)"
        
        AF.request(url, parameters: apiUrl.parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
