//
//  APIURLs.swift
//  starzPlayTest
//
//  Created by Hamza Sheikh on 19/03/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum APIURLs {
    
    
    case getTVShows
    case getTVShowDetails(showId: Int)
    case getSeasonDetails(showId: Int, seasonId: Int)
    
    var path: String {
        switch self {
        case .getTVShows:
            return "tv/popular"
        case .getTVShowDetails(let showId):
            return "tv/\(showId)"
        case .getSeasonDetails(let showId, let seasonId):
            return "tv/\(showId)/season/\(seasonId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTVShows, .getTVShowDetails(_), .getSeasonDetails(_, _):
            return .get
        }
    }
        
    var parameters: [String: Any]? {
        switch self {
            default:
                return ["api_key": "ecef14eac236a5d4ec6ac3a4a4761e8f"]
        }
    }
    
    var baseURL: URL {
        // Provide your base URL here
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    func encodeToJSONData<T>(_ value: T) throws -> Data? {
        if let dictionary = value as? [String: Any] {
            return try JSONSerialization.data(withJSONObject: dictionary, options: [])
        } else if let encodableValue = value as? Encodable {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try encoder.encode(encodableValue)
        }
        
        return nil
    }
}

