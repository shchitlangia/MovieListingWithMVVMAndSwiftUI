//
//  RequestManager.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    // Add other HTTP methods if needed (e.g., POST, PUT, DELETE, etc.)
}

struct RequestResult<T: Decodable> {
    let data: T?
    let response: URLResponse?
    let error: Error?
}

// Network manager for API requests
final class RequestManager {
    private let session = URLSession.shared

    func performRequest<T: Decodable>(with request: any Request, completion: @escaping (Result<T, APIError>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = RequestMethod.get.rawValue

        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse(NSError())))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.apiError(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil))))
                return
            }

            guard let data = data else {
                completion(.failure(.noData(NSError())))
                return
            }

            do {
                if let decodedData = try request.decodeResponse(data: data) as? T {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.serializationError(NSError())))
                }
            } catch {
                completion(.failure(.serializationError(error)))
            }
        }.resume()
    }
}
