//
//  ScreenB3View.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct B3View: View {
    @State var canProceed: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Text("Where were we. Yeah, sure, okay. Who the hell is John F. Kennedy? We're gonna take a little break but we'll be back in a while so, don't nobody go no where. Believe me, Marty, you're better off not having to worry about all the aggravation and headaches of playing at that dance. My god, do you know what this means? It means that this damn thing doesn't work at all. It's my dad. So tell me, Marty, how long have you been in port? Good, you could start by sweeping the floor. Ho, you mean you're gonna touch her on her- Um, yeah, I'm on my way. That's good advice, Marty. I said the keys are in here. The way I see it, if you're gonna build a time machine into a car why not do it with some style. Besides, the stainless, steel construction made the flux dispersal- look out. In that case, I'll tell you strait out.")
                .padding(20)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button {
                canProceed = true
            } label: {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
            }
            .offset(y: -50)
            
            NavigationLink(destination: ScreenCView(), isActive: $canProceed) {
                EmptyView()
            }
        }
    }
}

struct ScreenB3View_Previews: PreviewProvider {
    static var previews: some View {
        B3View().environmentObject(ViewModel())
    }
}
