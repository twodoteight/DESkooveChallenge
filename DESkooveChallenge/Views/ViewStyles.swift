//
//  ViewStyles.swift
//  DESkooveChallenge
//
//  Created by Kerem on 23.06.2022.
//

import SwiftUI

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
