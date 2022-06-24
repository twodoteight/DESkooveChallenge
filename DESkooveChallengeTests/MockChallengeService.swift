//
//  MockChallengeService.swift
//  DESkooveChallengeTests
//
//  Created by Kerem on 24.06.2022.
//

import Foundation
@testable import DESkooveChallenge

final class MockChallengeService: ChallengeServiceProtocol {
    func get<T>(from endpoint: String, completion: @escaping (Result<T?, Error>) -> Void) where T : Decodable {
        let result = Result<T?, Error>.success(nil)
        completion(result)
    }
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.success("200"))
    }
}
