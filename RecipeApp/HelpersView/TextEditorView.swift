//
//  TextEditorView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import SwiftUI

struct TextEditorView: View {
    
    var textPlaceHolder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(textPlaceHolder)
                        .foregroundColor(.white.opacity(0.9))
                        .preferredColorScheme(.dark)
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .foregroundColor(.white.opacity(0.7))
                    .preferredColorScheme(.dark)
                    .textEditorBackground {
                        Color.secondaryBackground
                            .opacity(0.80)
                            .cornerRadius(10)
                    }
            }
        }
        .frame(minHeight: 150, maxHeight: 150, alignment: .leading)
    }
}

struct TextEditorWithGlowIconView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(textPlaceHolder: "Email", text: .constant(""))
            .preferredColorScheme(.dark)
    }
}

