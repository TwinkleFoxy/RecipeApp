//
//  GradientForPictureProfileView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.01.2023.
//

import SwiftUI

struct GradientForPictureProfileView: View {
    var profilePicture: String
    var userImage: UIImage?
    
    var body: some View {
        ZStack {
            AngularGradient(colors: Color.rainbowGradient, center: .center)
                .mask {
                    Circle()
                        .frame(width: 66, height: 66)
                        .blur(radius: 5)
                }
                .blur(radius: 8)
            if userImage == nil {
                Image(profilePicture)
                    .resizable()
                    .opacity(0.75)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .mask {
                        Circle()
                    }
            } else if let userImage = userImage {
                Image(uiImage: userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .mask {
                        Circle()
                    }
            }
        }
    }
}

struct GradientForPictureProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GradientForPictureProfileView(profilePicture: "user")
    }
}
