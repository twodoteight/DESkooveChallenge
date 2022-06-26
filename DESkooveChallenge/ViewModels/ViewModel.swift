//
//  ViewModel.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import Foundation
import SwiftUI

class ViewModel: NSObject, ObservableObject {
    @Published var bScreen: ScreenType? = nil
    @Published var cScreen: ScreenType? = nil
    
    @Published var isSelectionSubmitted: Bool = false
    @Published var isLoginSuccesful: Bool = false
    @Published var hasTimeElapsed: Bool = false

    @Published var canProceedToC: Bool = false
    @Published var canProceedToD: Bool = false
    
    // Hard coded lists for options. Ideally,
    // these would be represented by suitable models but done this way for convenience.
    let choices = ["Choice A", "Choice B", "Choice C", "Choice D", "Choice E"]
    let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
    
    var loginTries: Int = 0
    var cacheBScreen: Bool = true
    
    private let service: ChallengeServiceProtocol
    private var sessionID: String?

    init(service: ChallengeServiceProtocol = ChallengeService()) {
        self.service = service
    }
    
    // Function that strats the atempts to login. Retries are done recursively.
    func attemptLogIn(maxTries: Int = 20) {
        print("Remaining Attempts: \(maxTries)")
        if maxTries == 0 {
            print("Login Failed")
            return
        }
        loginTries += 1

        // Could be enum cases
        let endpoint = "rLogin"
        service.login(from: endpoint) {[weak self] (result: Result<Session, Error>) in
            switch result {
            case .success(let session):
                print("Login Success! ID: \(session.sessionID)")
                    self?.isLoginSuccesful = true
                    self?.sessionID = session.sessionID
            case .failure(let error):
                print("Login Failure! \(error.localizedDescription)")
                self?.attemptLogIn(maxTries: maxTries - 1)
            }
        }
    }
    
    // Function that requests the next B screen from the API.
    func fetchBScreen() {
        // Check if a previouslt fethed result is persisted in UserDefaults.
        // Could be done within the ChallengeService class
        if cacheBScreen == true, let cachedScreen = getBScreenFromCache() {
            setBScreen(screenType: cachedScreen, shouldCache: false)
            return
        }
            
        let endpoint = "rFetchExperiments"
        service.getBScreen(from: endpoint) { [weak self] (result: Result<ScreenType, Error>) in
            switch result {
            case .success(let screenType):
                    //UserDefaults.standard.set(screenType.rawValue, forKey: "rFetchExperiments")
                self?.setBScreen(screenType: screenType, shouldCache: true)
            case .failure(let error):
                print("Could not get the next screen! \(error.localizedDescription)")
            }
        }
    }
    
    // Function that mocks the submit logic.
    func submitSelection() {
        if let bScreen = bScreen, bScreen == .screenB3 {
            print("No submission needed!")
            canProceedToC = true
            return
        }
        
        let endpoint = "rSubmitSelection"
        service.submit(to: endpoint) { [weak self] (result: Result<String, Error>) in
            switch result {
            case .success(let response):
                    print(response)
                    self?.canProceedToC = true
                    self?.isSelectionSubmitted = true
            case .failure(let error):
                print("Could not submit! \(error.localizedDescription)")
            }
        }
    }
    
    func setBScreen(screenType: ScreenType, shouldCache: Bool = false) {
        if shouldCache {
            UserDefaults.standard.set(screenType.rawValue, forKey: "rFetchExperiments")
        }
        bScreen = screenType
        fetchCScreen()
    }
    
    func getBScreenFromCache() -> ScreenType? {
        if let data = UserDefaults.standard.object(forKey: "rFetchExperiments") {
            print("Fetched screen type from cache")
            return ScreenType(rawValue: data as? String ?? "")
        }
        return nil
    }
    
    func fetchCScreen() {
        switch bScreen {
        case .screenB1:
            cScreen = .screenC1
        case .screenB2, .screenB3:
            cScreen = .screenC2
        case .noScreenB:
            cScreen = .screenC2
            canProceedToC = true
        default:
            cScreen = .screenC2
        }
    }
}
