//
//  ScreenD.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct ScreenDView: View {
    var body: some View {
        Group {
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 120, height: 120)
        }
        .navigationTitle(ScreenType.screenD.rawValue)
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.screenD)
        .ignoresSafeArea()
    }
}

struct ScreenD_Previews: PreviewProvider {
    static var previews: some View {
        ScreenDView()
    }
}
