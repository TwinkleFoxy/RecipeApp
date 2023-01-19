//
//  ButtonWithGlowView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 12.01.2023.
//

import SwiftUI

struct ButtonWithGlowView: View {
    
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                BackgroundGlowGradientView()
                    .blendMode(.overlay)
                    .blur(radius: 8)
                    .mask {
                        RoundedRectangle(cornerRadius: 15)
                            .blur(radius: 6)
                            .frame(height: 50)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.7))
                            .background {
                                Color.tertiaryBackground.opacity(0.93)
                            }
                            .cornerRadius(15)
                            .blendMode(.normal)
                            .frame(height: 50)
                    }
                Text(title)
                    .GradientForeground(colors: [Color.pink_gradient_1, Color.pink_gradient_2])
            }
            .frame(height: 50)
        }
    }
}

struct ButtonWithGlowView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithGlowView(title: "Sign Up", action: {})
            .preferredColorScheme(.light)
    }
}
