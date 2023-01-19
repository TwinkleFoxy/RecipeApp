//
//  ImageButtonWithGlowIconView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.01.2023.
//

import SwiftUI

struct ImageButtonWithGlowIconView: View {
    
    let title: String
    let defaultSysIcon: String
    @Binding var imageAfterChange: UIImage?
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 15) {
                IconTextFieldView(iconName: defaultSysIcon, isGlow: .constant(false), image: $imageAfterChange)
                Text(title)
                    .GradientForeground(colors: [Color.pink_gradient_1, Color.pink_gradient_2])
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke()
                    .foregroundColor(.white)
                    .opacity(0.2)
                
                Color.secondaryBackground
                    .opacity(0.8)
                    .cornerRadius(15)
            }
        }
    }
}

struct ImageButtonWithGlowIconView_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonWithGlowIconView(title: "Choose image for profile", defaultSysIcon: "person.crop.circle", imageAfterChange: .constant(nil)) { }
    }
}

