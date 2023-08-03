//
//  Request.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

// Protocol for handling API requests
protocol Request {
    associatedtype Response: Decodable

    var endpoint: String { get }
    var queryParams: [String: String]? { get }
    var url: URL { get }
    
    func decodeResponse(data: Data) throws -> Response
}

extension Request {
    var baseURL: String {
       return APIConstants.baseURL
    }
    
    var url: URL {
        var components = URLComponents(string: "\(baseURL)/\(endpoint)")!
        components.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }
    
    func decodeResponse(data: Data) throws -> Response {
        return try Utility.jsonDecoder.decode(Response.self, from: data)
    }
}
