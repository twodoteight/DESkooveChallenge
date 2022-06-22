//
//  ScreenB1View.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct B1View: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var selectionIndex: Int = 0
    @State var canProceed: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Picker("Please choose", selection: $selectionIndex) {
                ForEach(0..<viewModel.choices.count) { index in
                    Text("\(viewModel.choices[index])")
                        .tag(index)
                        .font(.title)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            Button {
                viewModel.submitSelection()
            } label: {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
            }
            .offset(y: -50)
            
            NavigationLink(destination: ScreenCView(titleText: viewModel.choices[selectionIndex], type: .screenC1), isActive: $viewModel.isSelectionSubmitted) {
                EmptyView()
            }
        }
    }
}

struct ScreenB1View_Previews: PreviewProvider {
    static var previews: some View {
        B1View()
    }
}
