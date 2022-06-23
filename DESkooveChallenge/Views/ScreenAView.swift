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
    
    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                Spacer()
                // Unimportant view, mostly for testing.
                //                Text(viewModel.nextBScreen?.rawValue ?? "Fetching Next View")
                ProgressView("In Progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    .font(.system(size:20))
                    .foregroundColor(.black)
                    .onAppear {
                        viewModel.fetchNextScreen()
                    }
                // Temporary controls for debugging and testing.
//                VStack {
//                    Toggle("Want to navigate back here?", isOn: $canComeBack).padding([.leading, .trailing], 50)
//
//                }
//                VStack {
//
//                    Button("Start fetching") {
//                        viewModel.fetchNextScreen()
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .foregroundColor(Color.black)
//                    .accentColor(Color.black)
//                    .frame(width: 300, height: 40, alignment: .bottomTrailing)
//
//                    Group {
//                        Button("Select B1"){
//                            viewModel.nextBScreen = .screenB1
//                        }
//
//                        Button("Select B2"){
//                            viewModel.nextBScreen = .screenB2
//                        }
//
//                        Button("Select B3"){
//                            viewModel.nextBScreen = .screenB3
//                        }
//
//                        Button("Select No View"){
//                            viewModel.nextBScreen = .noScreenB
//                        }
//
//                    }
//                    .buttonStyle(.bordered)
//                    .foregroundColor(Color.black)
//                    .frame(width: 300, height: 40, alignment: .bottomTrailing)
//                }
                
                Spacer()
            }
            .navigationTitle(ScreenType.screenA.rawValue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.screenA)
            .ignoresSafeArea()
            
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB1, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB2, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.screenB3, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenCView().navigationBarBackButtonHidden(!canComeBack), tag: ScreenType.noScreenB, selection: $viewModel.nextBScreen) {
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
