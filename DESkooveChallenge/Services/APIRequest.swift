//
//  APIRequest.swift
//  DEFreeNowTask
//
//  Created by Kerem on 26.12.2021.
//

import Foundation

class APIRequest {
    
    enum ApiError: Error {
        case invalidData
        case httpError(errorCode: Int)
        case decodingError
    }
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    // Simple resuable generic function for api GET calls.
    func perform<T: Decodable>(expecting: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(ApiError.invalidData))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let result = try decoder.decode(expecting, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(ApiError.decodingError))
                    }
                } else {
                    completion(.failure(ApiError.httpError(errorCode: response.statusCode)))
                }
            }
        }
        task.resume()
    }
    
    // Slightly different version to mimic the submit behaviour. Potentially, this could be a POST request.
    func submit(with completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(.success(response))
                } else {
                    print("Server returned error: \(response.statusCode) - (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))")
                    completion(.failure(ApiError.httpError(errorCode: response.statusCode)))
                }
            }
        }
        task.resume()
    }
}

