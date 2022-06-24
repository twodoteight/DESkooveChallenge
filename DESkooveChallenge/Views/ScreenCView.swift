//
//  ScreenC1View.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct ScreenCView: View {
    var titleText: String = ""
    @EnvironmentObject var viewModel: ViewModel
    @State var type: ScreenType = .screenC2
    @State private var colorOpacity: Double = 1
    
    var body: some View {
        Group {
            VStack() {
                Spacer()
                // Typically, the text presented would be the result of an API call,
                // based on the option / choice the user picked on screen B.
                // Here, a simple switch-case should suffice to display a mock-up.
                if titleText.count > 0 {
                    Text(titleText).font(.headline).bold()
                }
                Group{
                    switch type {
                    case .screenC1:
                        Text("Where were we. Yeah, sure, okay. Who the hell is John F. Kennedy? We're gonna take a little break but we'll be back in a while so, don't nobody go no where. Believe me, Marty, you're better off not having to worry about all the aggravation and headaches of playing at that dance. My god, do you know what this means? It means that this damn thing doesn't work at all. It's my dad. So tell me, Marty, how long have you been in port? Good, you could start by sweeping the floor. Ho, you mean you're gonna touch her on her- Um, yeah, I'm on my way. That's good advice, Marty. I said the keys are in here. The way I see it, if you're gonna build a time machine into a car why not do it with some style. Besides, the stainless, steel construction made the flux dispersal- look out. In that case, I'll tell you strait out.")
                    case .screenC2:
                        Text("Robot ipsum Pornor pneumatship dichlortonia sempertomy megaeer ventrocoele hexaprismoesque. Ailurodromous androet benzgeny isfy sexix permaaholic saprouronic thiacratic. Omphaloparous chromothermy vasobiosis baryphilia caconasty chromofoliate myelacean. Mastzyme pantfoliate pseudoious Nippomancy binomy cacoone ergatan encephalcephalous actinofacient. Hyloric re-wise panstasis quinqucyte kinesiator nosoyne schmpenia hispanoiatric. Toxoeous selenphyta toxicy ruthenioence plumboest osteogon digicrat. Quadrrrhagia syncarpous attoese backvirile.")
                    default:
                        Text("No Text")
                    }
                }
                .padding(30)
                .multilineTextAlignment(.center)
                
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    .offset(y: -50)
                
                NavigationLink(destination: ScreenDView(), isActive: $viewModel.canProceedToD) {
                    EmptyView()
                }
            }
            .navigationTitle(type.rawValue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.screenC.opacity(colorOpacity))
            .ignoresSafeArea()
        }
        .onAppear {
            pickColor()
            wait(until: .now() + 3)
        }
        .onChange(of: viewModel.isLoginSuccesful, perform: updateStatus)
        .onChange(of: viewModel.hasTimeElapsed, perform: updateStatus)
    }
    
    func pickColor() {
        switch type {
        case .screenC1:
            colorOpacity = 1
        case .screenC2:
            colorOpacity = 0.75
        default:
            colorOpacity = 1
        }
    }
    
    func wait(until time: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: time) {
            viewModel.hasTimeElapsed = true
            // Print to check if it works
            print("3 Seconds elapsed")
        }
    }
    
    func updateStatus(newValue: Bool) {
        viewModel.canProceedToD = viewModel.isLoginSuccesful && viewModel.hasTimeElapsed
    }
}

struct ScreenCxView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCView(titleText: "Header").environmentObject(ViewModel()).previewInterfaceOrientation(.portrait)
    }
}
