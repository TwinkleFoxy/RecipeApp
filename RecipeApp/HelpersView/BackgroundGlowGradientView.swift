//
//  BackgroundGlowGradientView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 26.10.2022.
//

import SwiftUI

struct BackgroundGlowGradientView: View {
    var body: some View {
        AngularGradient(gradient: Gradient(colors: Color.rainbowGradient), center: .center)
            .blur(radius: 9)
    }
}

struct BackgroundGlowGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGlowGradientView()
    }
}
