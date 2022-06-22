//
//  ContentView.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            ScreenAView().onAppear() {
                print("Screen A appeared")
                // Start login attempts when the top-level view appears
                viewModel.attemptLogIn()
            }
        }
        // Set navigation style to stack navigation to avoid buggy behaviour
        .navigationViewStyle(StackNavigationViewStyle())
        // Use an environment object for dependency injection. Mostly for convenience
        .environmentObject(viewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
