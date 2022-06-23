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
    
    @State private var bgColor: Color = .white
    @State private var canSkipSubmit: Bool = false
    
    // Wrapper view that handles the B-level of the navigation flow.
    var body: some View {
        VStack {
            Spacer()
            Group {
                switch viewModel.nextBScreen {
                case .screenB1:
                    B1View(choices: viewModel.choices, selection: $selection).onAppear() {
                        print("Screen B1 appeared")
                    }
                    NavigationLink(destination: ScreenCView(titleText: selection, type: .screenC1), isActive: $viewModel.isSelectionSubmitted) {
                        EmptyView()
                    }
                case .screenB2:
                    B2View(options: viewModel.options,
                           selection: $selection,
                           flags: Array(repeating: false, count: viewModel.options.count)).onAppear() {
                        print("Screen B2 appeared")
                    }
                    NavigationLink(destination: ScreenCView(titleText: selection, type: .screenC2), isActive: $viewModel.isSelectionSubmitted) {
                        EmptyView()
                    }
                case .screenB3:
                    B3View().onAppear() {
                        print("Screen B3 appeared")
                    }
                    NavigationLink(destination: ScreenCView(type: .screenC2), isActive: $canSkipSubmit) {
                        EmptyView()
                    }
                default:
                    Text("Invalid Fetched Screen").onAppear() {
                        print("Invalid Fetched Screen")
                    }
                }
            }
            .navigationTitle(viewModel.nextBScreen?.rawValue ?? "No B Screen")
            .onAppear(perform: setup)
            
            Spacer()
            Button {
                viewModel.nextBScreen == .screenB3 ? canSkipSubmit = true : viewModel.submitSelection()
            } label: {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
            }
            .offset(y: -50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
        .ignoresSafeArea()
    }
    
    func setup() {
        switch viewModel.nextBScreen {
        case .screenB1:
            bgColor = Color.screenB
        case .screenB2:
            bgColor = Color.screenB.opacity(0.75)
        case .screenB3:
            bgColor = Color.screenB.opacity(0.5)
        default:
            bgColor = Color.screenB
        }
    }
}

struct B1View: View {
    var choices: [String]
    
    @Binding var selection: String
    @State private var selectionIndex: Int = 0
    
    var body: some View {
        Picker("Please choose", selection: $selectionIndex.onChange(pickerChanged)) {
            ForEach(0..<choices.count) { index in
                Text("\(choices[index])")
                    .tag(index)
                    .font(.title)
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            selection = choices[0]
        }
    }
    
    func pickerChanged(newValue: Int) {
        selection = choices[newValue]
        print("Selection changed to \(selection)")
    }
}


struct B2View: View {
    var options: [String]
    
    @Binding var selection: String
    @State var flags: [Bool]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            ForEach(flags.indices) { i in
                ToggleItem(storage: self.$flags.onChange(checklistChanged), tag: i, label: options[i])
                    .padding(.horizontal)
                    .toggleStyle(.checkboxToggle)
            }
        }.onAppear(){
            selection = options[0]
            flags[0] = true
        }
    }
    func checklistChanged(newValue: [Bool]) {
        selection = options[flags.firstIndex(of: true) ?? 0]
        print("Selection changed to \(selection)")
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

struct B3View: View {
    var body: some View {
        Text("Where were we. Yeah, sure, okay. Who the hell is John F. Kennedy? We're gonna take a little break but we'll be back in a while so, don't nobody go no where. Believe me, Marty, you're better off not having to worry about all the aggravation and headaches of playing at that dance. My god, do you know what this means? It means that this damn thing doesn't work at all. It's my dad. So tell me, Marty, how long have you been in port? Good, you could start by sweeping the floor. Ho, you mean you're gonna touch her on her- Um, yeah, I'm on my way. That's good advice, Marty. I said the keys are in here. The way I see it, if you're gonna build a time machine into a car why not do it with some style. Besides, the stainless, steel construction made the flux dispersal- look out. In that case, I'll tell you strait out.")
            .padding(20)
            .multilineTextAlignment(.center)
    }
}

struct ScreenBView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenBView().environmentObject(ViewModel())
    }
}
