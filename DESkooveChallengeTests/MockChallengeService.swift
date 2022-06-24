//
//  MockChallengeService.swift
//  DESkooveChallengeTests
//
//  Created by Kerem on 24.06.2022.
//

import Foundation
@testable import DESkooveChallenge
import UIKit

// A mock of the service, without any calls to background queues
final class MockChallengeService: ChallengeServiceProtocol {
    
    // A mock json string. Could have also been put in a json data file.
    var mockJson: String = "{\"sessionId\":\"e8e35dcd-b070-4933-8890-6c70342361c6\"}"
    var shouldFail: Bool = false
    func get<T>(from endpoint: String, completion: @escaping (Result<T?, Error>) -> Void) where T : Decodable {
        if shouldFail {
            completion(.failure(ChallengeService.ServiceError.decodingFailed))
        }
        
        let mockData: Data = mockJson.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let result = Result<T?, Error>.success(try? decoder.decode(T.self, from: mockData))
        completion(result)
    }
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.success("200"))
    }
}
