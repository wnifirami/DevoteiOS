//
//  HideKeyboardExtension.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 24/5/2021.
//

import SwiftUI
#if canImport(UIKIT)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
