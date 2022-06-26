//
//  APIRequestTests.swift
//  DESkooveChallengeTests
//
//  Created by Kerem on 26.06.2022.
//

import XCTest
@testable import DESkooveChallenge

class APIRequestTests: XCTestCase {
    
    // A mock json string. Could have also been put in a json data file.
    var mockSessionJson: String = "{\"sessionId\":\"e8e35dcd-b070-4933-8890-6c70342361c6\"}"
    var mockScreenJson: String = "\"screenB1\""

    override func setUp() {
    }
    
    func test_loginResponseDecoding() {
        // In case if we want to test async API calls
        let expectation = XCTestExpectation(description: "loginRequestExpectation")
        MockAPIRequest(mockJson: mockSessionJson).perform { (result: Result<Session, Error>) in
            let session = try? result.get()
            XCTAssertNotNil(session)
            XCTAssertEqual(session!.sessionID, "e8e35dcd-b070-4933-8890-6c70342361c6")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_fetchScreenResponseDecoding() {
        let expectation = XCTestExpectation(description: "screenRequestExpectation")
        MockAPIRequest(mockJson: mockScreenJson).perform { (result: Result<ScreenType, Error>) in
            let screenType = try? result.get()
            XCTAssertNotNil(screenType)
            XCTAssertEqual(screenType, ScreenType.screenB1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
