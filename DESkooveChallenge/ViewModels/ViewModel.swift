//
//  ViewModel.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import Foundation
import SwiftUI

class ViewModel: NSObject, ObservableObject {
    @Published var nextBScreen: ScreenType? = nil
    @Published var isSelectionSubmitted: Bool = false
    @Published var isLoginSuccesful: Bool = false
    
    var sessionID: String?
    
    // Hard coded lists for options. Ideally, these would be represented by suitable models but done this way for convenience.
    var choices = ["Choice A", "Choice B", "Choice C", "Choice D", "Choice E"]
    var options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
    
    // Function that strats the atempts to login. Retries are done recursively.
    func attemptLogIn(maxTries: Int = 20) {
        print("Remaining Attempts: \(maxTries)")
        if maxTries == 0 {
            print("Login Failed")
            return
        }
        
        let urlString = "http://localhost:3000/rLogin"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        let apiRequest = APIRequest(url: url)
        apiRequest.perform(expecting: Session.self) {[weak self] result in
            
            switch result {
            case .success(let data):
                print("Login Success! ID: \(data!.sessionID)")
                DispatchQueue.main.async {
                    self?.isLoginSuccesful = true
                    self?.sessionID = data!.sessionID
                }
            case .failure(let error):
                print("Login Failure! \(error.localizedDescription)")
                self?.attemptLogIn(maxTries: maxTries - 1)
            }
        }
    }
    
    // Function that requests the next B screen from the API.
    func fetchNextScreen() {
        // Check if a previouslt fethed result is persisted in UserDefaults.
        if let data = UserDefaults.standard.object(forKey: "fetchedScreen") {
            print("Fetching screen type from cache")
            nextBScreen = ScreenType(rawValue: data as? String ?? "")
            return
        }
            
        let urlString = "http://localhost:3000/rFetchExperiments"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let apiRequest = APIRequest(url: url)
        apiRequest.perform(expecting: ScreenType.self) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    UserDefaults.standard.set(data!.rawValue, forKey: "fetchedScreen")
                    self?.nextBScreen = data!
                }
            case .failure(let error):
                print("Could not get the next screen! \(error.localizedDescription)")
            }
        }
    }
    
    // Function that mocks the submit logic.
    func submitSelection() {
        let urlString = "http://localhost:3000/rSubmitSelection"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let apiRequest = APIRequest(url: url)
        apiRequest.submit() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print(response.statusCode)
                    self?.isSelectionSubmitted = true
                }
            case .failure(let error):
                print("Could not submit! \(error.localizedDescription)")
            }
        }
    }
}
