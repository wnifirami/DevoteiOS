//
//  CheckBoxStyle.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 10/7/2021.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    playSound(sound: configuration.isOn ? "sound-rise" : "sound-tap", type: "mp3")
                    if configuration.isOn {
                    feedback.notificationOccurred(.success)
                    }
                }
            
            configuration.label
        }//:HStack
    }
}

struct CheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder Label", isOn: .constant(false))
            .toggleStyle(CheckBoxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
