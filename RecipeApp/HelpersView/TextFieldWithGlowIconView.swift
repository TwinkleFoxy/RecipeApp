//
//  TextFieldWithGlowIconView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 26.10.2022.
//

import SwiftUI

struct TextFieldWithGlowIconView: View {
    
    var iconName: String
    var textPlaceHolder: String
    @State private var isGlowIcon: Bool = false
    @Binding var text: String
    
    var body: some View {
        HStack {
            IconTextFieldView(iconName: iconName, isGlow: $isGlowIcon, image: .constant(nil))
                .scaleEffect(isGlowIcon ? 1.1 : 1)
            TextField(textPlaceHolder, text: $text) { isEditing in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                    isGlowIcon = isEditing
                }
            }
            .foregroundColor(.white.opacity(0.7))
            .preferredColorScheme(.dark)
            .textInputAutocapitalization(.never)
        }
        .frame(maxHeight: 50, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.2), lineWidth: 1)
                .blendMode(.overlay)
            Color.secondaryBackground
                .opacity(0.8)
                .cornerRadius(15)
        }
    }
}
struct TextFieldWithGlowIconView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithGlowIconView(iconName: "envelope.open.fill", textPlaceHolder: "Email", text: .constant("dasf"))
            .preferredColorScheme(.dark)
    }
}
