//
//  APIRequest.swift
//  DEFreeNowTask
//
//  Created by Kerem on 26.12.2021.
//

import Foundation

protocol APIRequestProtocol {
    func perform(completion: @escaping (Result<Data, Error>) -> Void)
}

final class APIRequest: APIRequestProtocol {
    
    enum APIError: Error {
        case invalidData
        case failedRequest(errorCode: Int)
        case noResponse
    }
    
    let url: URL
    let requestType: String
    
    init(requestType:String, url: URL) {
        self.requestType = requestType
        self.url = url
    }
    
    func perform(completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.invalidData))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.noResponse))
                return
            }
            
            if response.statusCode == 200 {
                completion(.success(data))
            } else {
                print("Server returned error: \(response.statusCode) - (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))")
                completion(.failure(APIError.failedRequest(errorCode: response.statusCode)))
            }
        }
        task.resume()
    }
    
    //    // Slightly different version to mimic the submit behaviour. Realistically, this would be a POST request.
    //    func perform(with completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //            if let response = response as? HTTPURLResponse {
    //                if response.statusCode == 200 {
    //                    completion(.success(response))
    //                } else {
    //                    print("Server returned error: \(response.statusCode) - (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))")
    //                    completion(.failure(APIError.httpError(errorCode: response.statusCode)))
    //                }
    //            }
    //        }
    //        task.resume()
    //    }
}

