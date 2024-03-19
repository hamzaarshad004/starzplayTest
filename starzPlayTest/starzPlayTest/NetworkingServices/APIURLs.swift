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
    
//    var httpBody: Data? {
//        switch self {
//        }
//    }
    
//    var headers: [String: String] {
//        var headers = ["Content-Type": "application/json"]
//        switch self {
//            case .register(_), .login(_):
//                return headers
//            default:
//                let authToken = "Bearer \(UserDefaults.standard.string(forKey: UserDefaultKeys.accessToken.rawValue) ?? "Placeholder")"
//                let addHeaders = ["Authorization": authToken]
//                headers.merge(addHeaders) { _, new in
//                    new
//                }
//                return headers
//        }
//    }
    
//    var parameters: [String: Any]? {
//        switch self {
//            case .getMedicalReports(let reportType):
//                return ["report_type": reportType]
//            default:
//                return nil
//        }
//    }
    
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

