//
//  NavigationService.swift
//  DESkooveChallenge
//
//  Created by Kerem on 23.06.2022.
//

import Foundation
import SwiftUI

protocol ChallengeServiceProtocol {
    //func get<T>(from endpoint: String, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable
    func login(from endpoint: String, completion: @escaping (Result<Session, Error>) -> Void)
    func getBScreen(from endpoint: String, completion: @escaping (Result<ScreenType, Error>) -> Void)
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class ChallengeService: ChallengeServiceProtocol {
    
    var baseUrl: String;
    
    init(baseUrl: String = "http://localhost:3000/") {
        self.baseUrl = baseUrl
    }
    
    func login(from endpoint: String, completion: @escaping (Result<Session, Error>) -> Void) {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        APIRequest(requestType: "GET", url: url).perform() { (result: Result<Session, Error>)  in
            DispatchQueue.main.async {
                switch result {
                case .success(let session):
                    completion(.success(session))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getBScreen(from endpoint: String, completion: @escaping (Result<ScreenType, Error>) -> Void) {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        APIRequest(requestType: "GET", url: url).perform() { (result: Result<ScreenType, Error>)  in
            DispatchQueue.main.async {
                switch result {
                case .success(let screenType):
                    completion(.success(screenType))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
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
