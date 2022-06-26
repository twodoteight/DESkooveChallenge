//
//  ScreenAView.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct ScreenAView: View {
    @EnvironmentObject var viewModel: ViewModel
    // For testing
    @ State private var canComeBack: Bool = false
    @ State private var isTestMode: Bool = true
    @ State private var shouldCache: Bool = true

    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                Spacer()
                ProgressView("In Progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    .font(.system(size:20))
                    .foregroundColor(.black)
                    .onAppear {
                        // For easier review
                        if isTestMode == false {
                            viewModel.fetchBScreen()
                        }
                    }
                    .onChange(of: isTestMode) { newValue in
                        if isTestMode == false {
                        viewModel.fetchBScreen()
                        }
                    }
                // Temporary controls for debugging and testing. Just uncomment
                VStack {
                    Toggle("Test mode", isOn: $isTestMode).padding([.leading, .trailing], 50)
                    if isTestMode {
                        Toggle("Want to navigate back here?", isOn: $canComeBack).padding([.leading, .trailing], 50)
                        Toggle("Cache results?", isOn: $shouldCache).padding([.leading, .trailing], 50)
                        VStack {
                            Button("Fetch screen") {
                                viewModel.fetchBScreen()
                            }
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(Color.white)
                            .accentColor(Color.black)
                            .frame(width: 300, height: 40, alignment: .bottomTrailing)
                            
                            Group {
                                Button("Select B1"){
                                    viewModel.setBScreen(screenType: .screenB1, shouldCache: shouldCache)
                                }
                                
                                Button("Select B2"){
                                    viewModel.setBScreen(screenType: .screenB2, shouldCache: shouldCache)
                                }
                                
                                Button("Select B3"){
                                    viewModel.setBScreen(screenType: .screenB3, shouldCache: shouldCache)
                                }
                                
                                Button("Select No View"){
                                    viewModel.setBScreen(screenType: .noScreenB, shouldCache: shouldCache)
                                }
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(Color.black)
                            .frame(width: 300, height: 40, alignment: .bottomTrailing)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(ScreenType.screenA.rawValue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.screenA)
            .ignoresSafeArea()
            
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB1, selection: $viewModel.bScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB2, selection: $viewModel.bScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB3, selection: $viewModel.bScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenCView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.noScreenB, selection: $viewModel.bScreen) {
                EmptyView()
            }
        }
    }
}

struct ScreenAView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenAView().environmentObject(ViewModel())
    }
}
