//
//  ScreenAView.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct ScreenAView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var canProceed: Bool = false
    
    var body: some View {
        VStack (spacing: 30) {
            Spacer()
            
            Text(viewModel.nextBScreen?.rawValue ?? "Fetching Next View")
            
            ProgressView("In Progress")
                .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                .font(.system(size:20))
                .foregroundColor(.black)
                .onAppear {
                    viewModel.fetchNextScreen()
                }
                .onChange(of: viewModel.nextBScreen) { newValue in
                    canProceed = true
                }
            
            // Temporary controls for debugging and testing.
            VStack {
                Button("Select B1"){
                    viewModel.nextBScreen = .screenB1
                }
                
                Button("Select B2"){
                    viewModel.nextBScreen = .screenB2
                }
                
                Button("Select B3"){
                    viewModel.nextBScreen = .screenB3
                }
                
                Button("Select No View"){
                    viewModel.nextBScreen = .noScreenB
                }
            }

            NavigationLink(destination: ScreenBView(), tag: ScreenType.screenB1, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView(), tag: ScreenType.screenB2, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenBView(), tag: ScreenType.screenB3, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            NavigationLink(destination: ScreenCView(), tag: ScreenType.noScreenB, selection: $viewModel.nextBScreen) {
                EmptyView()
            }
            
            Spacer()
        }
        .navigationTitle(ScreenType.screenA.rawValue)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan)
        .ignoresSafeArea()
    }
}

struct ScreenAView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenAView().environmentObject(ViewModel())
    }
}
