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
    
    var loginResult: Result<Session, Error> = .success(Session(sessionID: "e8e35dcd-b070-4933-8890-6c70342361c6"))
    var getBResult: Result<ScreenType, Error> = .success(ScreenType.screenB1)
    var submitResult: Result<String, Error> = .success("200")

    func login(from endpoint: String, completion: @escaping (Result<Session, Error>) -> Void) {
        completion(loginResult)
    }
    
    func getBScreen(from endpoint: String, completion: @escaping (Result<ScreenType, Error>) -> Void) {
        completion(getBResult)
    }
    
    func submit(to endpoint: String, completion: @escaping (Result<String, Error>) -> Void) {
        completion(submitResult)
    }
}
