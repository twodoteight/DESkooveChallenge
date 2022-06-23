//
//  Utility.swift
//  DESkooveChallenge
//
//  Created by Kerem on 21.06.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let screenA = Color("ScreenA")
    static let screenB = Color("ScreenB")
    static let screenC = Color("ScreenC")
    static let screenD = Color("ScreenD")
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
