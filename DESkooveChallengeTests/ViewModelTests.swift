//
//  ViewModelTests.swift
//  DESkooveChallengeTests
//
//  Created by Kerem on 24.06.2022.
//

import XCTest
@testable import DESkooveChallenge

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    var mockService: MockChallengeService!
    
    override func setUp() {
        mockService = MockChallengeService()
        viewModel = .init(service: mockService)
    }
    
    func test_SuccessfullySubmittingSelectionSetsCanProceedToCTrue() {
        XCTAssertFalse(viewModel.canProceedToC)
        viewModel.submitSelection()
        XCTAssertTrue(viewModel.canProceedToC)
    }
    
    func test_B3ScreenTypeSetsCanProceedToCTrueWithoutSubmitting() {
        XCTAssertFalse(viewModel.isSelectionSubmitted)
        XCTAssertFalse(viewModel.canProceedToC)
        viewModel.bScreen = .screenB3
        viewModel.submitSelection()
        XCTAssertFalse(viewModel.isSelectionSubmitted)
        XCTAssertTrue(viewModel.canProceedToC)
    }
    
    func test_SuccessfullyFetchedBScreenIsCached() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        
        var firstFetch: ScreenType?, secondFetch: ScreenType?
        
        mockService.mockJson = "\"screenB1\""
        viewModel.fetchBScreen()
        firstFetch = self.viewModel.bScreen
        XCTAssertNotNil(firstFetch)
        
        mockService.mockJson = "\"screenB2\""
        viewModel.fetchBScreen()
        secondFetch = self.viewModel.bScreen
        XCTAssertNotNil(secondFetch)
        XCTAssertEqual(firstFetch, secondFetch)
    }
    
    func test_LoginFailsAfterSpecifiedAmountOfRetries() {
        mockService.shouldFail = true
        viewModel.attemptLogIn(maxTries: 20)
        XCTAssertEqual(viewModel.loginTries, 20)
    }
}
