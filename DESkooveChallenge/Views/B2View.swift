//
//  ScreenB2View.swift
//  DESkooveChallenge
//
//  Created by Kerem on 18.06.2022.
//

import SwiftUI

struct B2View: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var selectionIndex: Int = 0
    @State var flags: [Bool]
    
    var body: some View {
        VStack {
            Spacer()
            VStack (alignment: .leading, spacing: 10) {
                ForEach(flags.indices) { i in
                    ToggleItem(storage: self.$flags, tag: i, label: viewModel.options[i])
                        .padding(.horizontal)
                        .toggleStyle(.checkboxToggle)
                        .onChange(of: flags) { value in
                            selectionIndex = flags.firstIndex(of: true) ?? 0
                        }
                }
            }
            
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
            
            NavigationLink(destination: ScreenCView(titleText: viewModel.options[selectionIndex], type: .screenC2), isActive: $viewModel.isSelectionSubmitted) {
                EmptyView()
            }
            
        }
        .onAppear(){
            flags[0] = true
        }
    }
    
    struct ToggleList: View {
        var itemList: [String]
        @State private var flags: [Bool]
        
        var body: some View{
            Text("Hopa")
        }
    }
    
    struct ToggleItem: View {
        @Binding var storage: [Bool]
        var tag: Int
        var label: String = ""
        var body: some View {
            let isOn = Binding (get: { self.storage[self.tag] },
                                set: { value in
                withAnimation {
                    self.storage = self.storage.enumerated().map { $0.0 == self.tag }
                }
            })
            return Toggle(label, isOn: isOn)
        }
    }
}

struct ToggleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "checkmark.square")
                .symbolVariant(configuration.isOn ? .fill : .none)
                .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                .imageScale(.large)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ToggleCheckboxStyle {
    static var checkboxToggle: ToggleCheckboxStyle { .init() }
}

struct ScreenB2View_Previews: PreviewProvider {
    static var previews: some View {
        B2View(flags: [true, false, false, false, false])
    }
}
