//
//  NavigationService.swift
//  DESkooveChallenge
//
//  Created by Kerem on 23.06.2022.
//

import Foundation
import SwiftUI

protocol ChallengeServiceProtocol {
    func get<T>(from endpoint: String, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class ChallengeService: ChallengeServiceProtocol {
    
    enum ServiceError: Error {
        case decodingFailed
    }
    
    var baseUrl: String;
    
    init(baseUrl: String = "http://localhost:3000/") {
        self.baseUrl = baseUrl
    }
    
    // Simple, resuable generic function for get api calls.
    func get<T>(from endpoint: String, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        APIRequest(requestType: "GET", url: url).perform() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(ServiceError.decodingFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Slightly different version to mimic the submit behaviour. Realistically, this would be a POST request.
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        APIRequest(requestType: "GET", url: url).perform() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(.success("200"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
