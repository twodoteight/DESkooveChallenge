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
        
        viewModel.setBScreen(screenType: .screenB3)
        viewModel.submitSelection()
        
        XCTAssertFalse(viewModel.isSelectionSubmitted)
        XCTAssertTrue(viewModel.canProceedToC)
    }
    
    func test_FirstSuccessfullyFetchedBScreenIsCached() {
        // Assert default behaviour is caching
        XCTAssertTrue(viewModel.cacheBScreen)

        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        
        var firstFetch: ScreenType?, secondFetch: ScreenType?
        
        mockService.getBResult = .success(ScreenType.screenB1)
        viewModel.fetchBScreen()
        firstFetch = self.viewModel.bScreen
        XCTAssertNotNil(firstFetch)
        
        mockService.getBResult = .success(ScreenType.screenB2)
        viewModel.fetchBScreen()
        secondFetch = self.viewModel.bScreen
        XCTAssertNotNil(secondFetch)
        
        XCTAssertEqual(firstFetch, secondFetch)
    }
    
    func test_SettingBScreenCorrectllySetsCScreen() {
        
        viewModel.cacheBScreen = false
        
        mockService.getBResult = .success(ScreenType.screenB1)
        viewModel.fetchBScreen()
        XCTAssertEqual(viewModel.cScreen, .screenC1)
        
        mockService.getBResult = .success(ScreenType.screenB2)
        viewModel.fetchBScreen()
        XCTAssertEqual(viewModel.cScreen, .screenC2)

        mockService.getBResult = .success(ScreenType.screenB3)
        viewModel.fetchBScreen()
        XCTAssertEqual(viewModel.cScreen, .screenC2)


        mockService.getBResult = .success(ScreenType.noScreenB)
        viewModel.fetchBScreen()
        XCTAssertEqual(viewModel.cScreen, .screenC2)
    }
    
    func test_LoginFailsAfterSpecifiedAmountOfRetries() {
        mockService.loginResult = .failure(APIRequest.APIError.failedRequest(errorCode: 400))
        viewModel.attemptLogIn(maxTries: 20)
        XCTAssertEqual(viewModel.loginTries, 20)
    }
}
