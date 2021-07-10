//
//  Constant.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 24/5/2021.
//

import SwiftUI
// MARK: - Formatter
 let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
// MARK: - UI
var  backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomLeading)
}
// MARK: - UX
let feedback = UINotificationFeedbackGenerator()
