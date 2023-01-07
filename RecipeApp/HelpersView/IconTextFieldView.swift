//
//  IconTextFieldView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 25.10.2022.
//

import SwiftUI

struct IconTextFieldView: View {
    
    var iconName: String
    @Binding var isGlow: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark) {
                ZStack {
                    if isGlow {
                        BackgroundGlowGradientView()
                    }
                    Color.tertiaryBackground
                        .cornerRadius(10)
                        .opacity(0.85)
                        .blur(radius: 3)
                }
            }
            .cornerRadius(10)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .cornerRadius(10)
            } else {
                Image(systemName: iconName)
                    .GradientForeground(colors: [Color.pink_gradient_1, Color.pink_gradient_2])
                    .font(.system(size: 15, weight: .medium))
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.8))
                .blendMode(.overlay)
        }
        .frame(width: 36, height: 36, alignment: .center)
        .padding([.vertical, .leading], 8)
    }
}

struct TextFieldIconView_Previews: PreviewProvider {
    static var previews: some View {
        IconTextFieldView(iconName: "envelope.open.fill", isGlow: .constant(true), image: .constant(nil))
    }
}
