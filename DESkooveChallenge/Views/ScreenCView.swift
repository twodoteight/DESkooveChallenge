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
    @State private var canProceed: Bool = false
    @State private var hasTimeElapsed: Bool = false
    
    var body: some View {
        Group {
            VStack(spacing: 10) {
                Text(titleText).font(.headline).bold()
                
                switch type {
                case .screenC1:
                    Text("Where were we. Yeah, sure, okay. Who the hell is John F. Kennedy? We're gonna take a little break but we'll be back in a while so, don't nobody go no where. Believe me, Marty, you're better off not having to worry about all the aggravation and headaches of playing at that dance. My god, do you know what this means? It means that this damn thing doesn't work at all. It's my dad. So tell me, Marty, how long have you been in port? Good, you could start by sweeping the floor. Ho, you mean you're gonna touch her on her- Um, yeah, I'm on my way. That's good advice, Marty. I said the keys are in here. The way I see it, if you're gonna build a time machine into a car why not do it with some style. Besides, the stainless, steel construction made the flux dispersal- look out. In that case, I'll tell you strait out.")
                        .padding(20)
                        .multilineTextAlignment(.center)
                case .screenC2:
                    Text("Robot ipsum Pornor pneumatship dichlortonia sempertomy megaeer ventrocoele hexaprismoesque. Ailurodromous androet benzgeny isfy sexix permaaholic saprouronic thiacratic. Omphaloparous chromothermy vasobiosis baryphilia caconasty chromofoliate myelacean. Mastzyme pantfoliate pseudoious Nippomancy binomy cacoone ergatan encephalcephalous actinofacient. Hyloric re-wise panstasis quinqucyte kinesiator nosoyne schmpenia hispanoiatric. Toxoeous selenphyta toxicy ruthenioence plumboest osteogon digicrat. Quadrrrhagia syncarpous attoese backvirile.")
                        .padding(20)
                        .multilineTextAlignment(.center)
                default:
                    Text("No Text")
                        .padding(20)
                        .multilineTextAlignment(.center)
                }
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.screenC.opacity(colorOpacity))
            .ignoresSafeArea()
            
            NavigationLink(destination: ScreenDView(), isActive: $canProceed) {
                EmptyView()
            }
        }
        .navigationTitle(type.rawValue)
        .onAppear {
            switch type {
            case .screenC1:
                colorOpacity = 1
            case .screenC2:
                colorOpacity = 0.75
            default:
                colorOpacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                hasTimeElapsed = true
                canProceed = hasTimeElapsed && viewModel.isLoginSuccesful
                print("3 Seconds elapsed")
            }
        }
        .onChange(of: viewModel.isLoginSuccesful) { newValue in
            canProceed = viewModel.isLoginSuccesful && hasTimeElapsed
        }
    }
}

struct ScreenCxView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCView(titleText: "Header").environmentObject(ViewModel())
    }
}
