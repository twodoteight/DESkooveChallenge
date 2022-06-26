//
//  MockAPIRequest.swift
//  DESkooveChallengeTests
//
//  Created by Kerem on 26.06.2022.
//

import Foundation
@testable import DESkooveChallenge
import UIKit

// A mock of the service, without any calls to background queues
final class MockAPIRequest: APIRequestProtocol {
    // A mock json string. Could have also been put in a json data file.
    var mockJson: String
    
    init(mockJson: String) {
        self.mockJson = mockJson
    }
    
    func perform(completion: @escaping (Result<Data?, Error>) -> Void) {
        completion(.success(nil))
    }
    
    func perform<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let result = try decoder.decode(T.self, from: Data(mockJson.utf8))
            completion(.success(result))
        } catch {
            completion(.failure(APIRequest.APIError.decodingFailed))
        }
    }
}
