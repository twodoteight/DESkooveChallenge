//
//  APIRequest.swift
//  DEFreeNowTask
//
//  Created by Kerem on 26.12.2021.
//

import Foundation

protocol APIRequestProtocol {
    func perform<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
    func perform(completion: @escaping (Result<Data?, Error>) -> Void)
}

final class APIRequest: APIRequestProtocol {
    
    enum APIError: Error {
        case invalidData
        case failedRequest(errorCode: Int)
        case decodingFailed
        case noResponse
    }
    
    let url: URL
    let requestType: String
    
    init(requestType:String, url: URL) {
        self.requestType = requestType
        self.url = url
    }
    
    // Resuable generic function for get api calls.
    func perform<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
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
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let result = try decoder.decode(T.self, from: data)
                    print(String(decoding: data, as: UTF8.self))
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.decodingFailed))
                }
            } else {
                print("Server returned error: \(response.statusCode) - (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))")
                completion(.failure(APIError.failedRequest(errorCode: response.statusCode)))
            }
        }
        task.resume()
    }
    
    // Slightly different version to mimic the submit behaviour without decoding.
    func perform(completion: @escaping (Result<Data?, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard data != nil else {
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
            
            print(response)
            
            if response.statusCode == 200 {
                completion(.success(nil))
            } else {
                print("Server returned error: \(response.statusCode) - (\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))")
                completion(.failure(APIError.failedRequest(errorCode: response.statusCode)))
            }
        }
        task.resume()
    }
}

