//
//  ScreenBView.swift
//  DESkooveChallenge
//
//  Created by Kerem on 21.06.2022.
//

import SwiftUI

struct ScreenBView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var selection: String = ""
    
    @State private var colorOpacity: Double = 1
    @State private var canProceed: Bool = false
    
    // Wrapper view that handles the B-level of the navigation flow.
    var body: some View {
        Group {
        switch viewModel.nextBScreen {
            case .screenB1:
                B1View().onAppear() {
                    print("Screen B1 appeared")
                }
            case .screenB2:
            B2View(flags: Array(repeating: false, count: viewModel.options.count)).onAppear() {
                    print("Screen B2 appeared")
                }
            case .screenB3:
                B3View().onAppear() {
                    print("Screen B3 appeared")
                }
            default:
                Text("Error: No Fetched Screen").onAppear() {
                    print("No fetched B screen")
                }
            }
        }
        .navigationTitle(viewModel.nextBScreen?.rawValue ?? "No B Screen")
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.screenB.opacity(colorOpacity))
        .ignoresSafeArea()
        .onAppear() {
            switch viewModel.nextBScreen {
            case .screenB1:
                colorOpacity = 1
            case .screenB2:
                colorOpacity = 0.75
            case .screenB3:
                colorOpacity = 0.5
            default:
                colorOpacity = 1
            }
        }
    }
}

struct ScreenBView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenBView().environmentObject(ViewModel())
    }
}
