//
//  Extensions.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation
import SwiftUI

extension Color {
    static let bottomSheetBackground = LinearGradient(gradient: Gradient(colors: [Color("Background 1").opacity(0.26), Color("Background 2").opacity(0.26)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let underline = LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white, .white.opacity(0)]), startPoint: .leading, endPoint: .trailing)
    static let cardBackground = Color("Card Background")
    static let secondaryBackground = Color("secondaryBackground")
    static let tertiaryBackground = Color("tertiaryBackground")
    static let pink_gradient_1 = Color("pink-gradient-1")
    static let pink_gradient_2 = Color("pink-gradient-2")
    static let cardBackground2 = Color("Card Background 2")
    static let probabilityText = Color("Probability Text")
    static let shadowColor = Color("shadowColor")
    static let rainbowGradient: [Color] = [
        Color.init(red: 33/255, green: 74/255, blue: 39/255), // Green
        Color.init(red: 18/255, green: 23/255, blue: 101/255), // Blue
        Color.init(red: 154/255, green: 40/255, blue: 28/255), // Red
        Color.init(red: 192/255, green: 287/255, blue: 71/255) // Yellow
    ]
}

extension View {
    public func GradientForeground(colors: [Color]) -> some View {
        self
            .overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
    public func textEditorBackground<V>(@ViewBuilder _ content: () -> V) -> some View where V : View {
        self
            .onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
            .background(content())
    }
}
