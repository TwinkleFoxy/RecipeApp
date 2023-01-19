//
//  SignUpView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 12.01.2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signInViewSwitcher: Bool = true
    @State private var rotationAngle = 0.0
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                Text(signInViewSwitcher ? "Sign In" : "Sign UP")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text(signInViewSwitcher ? "Login in account and receive more function of this app" : "Create account and receive more function of this app")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .opacity(0.7)
                TextFieldWithGlowIconView(iconName: "envelope.open.fill", textPlaceHolder: "Email", text: $email)
                    .textContentType(.emailAddress)
                TextFieldWithGlowIconView(iconName: "key.fill", textPlaceHolder: "Password", text: $password)
                    .textContentType(.password)
                ButtonWithGlowView(title: signInViewSwitcher ? "Sign in" : "Create accaunt") {
                    firebaseManager.signInSignUp(email: email, password: password, signInSwitcher: signInViewSwitcher)
                }
                
                Rectangle() // Divider
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.1))
                
                
                VStack(alignment: .leading, spacing: 15) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.65)) {
                            signInViewSwitcher.toggle()
                            rotationAngle += 180
                        }
                    } label: {
                        HStack {
                            Text(signInViewSwitcher ? "Don't have account?" : "Already have an accaunt?")
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.7))
                            Text(signInViewSwitcher ? "Sign up" : "Sign in")
                                .font(.footnote)
                                .GradientForeground(colors: [Color.pink_gradient_1, Color.pink_gradient_2])
                        }
                    }
                    
                    Button { // Restore password button
                        firebaseManager.sendPasswordReset(email: email)
                    } label: {
                        HStack {
                            Text("Forgot password?")
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.7))
                            Text("Restore password")
                                .font(.footnote)
                                .GradientForeground(colors: [Color.pink_gradient_1, Color.pink_gradient_2])
                        }
                    }
                }
                .padding(.bottom, 10)
            }
            .padding()
        }
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
        .background {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.2))
                .background(Color.secondaryBackground.opacity(0.5))
                .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                .shadow(color: .black.opacity(0.8), radius: 60, x: 0, y: 30)
        }
        .cornerRadius(30)
        .padding(.horizontal)
        .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher, actions: {}, message: {
            Text(firebaseManager.alertMessage)
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
                return firebaseManager
            }() )
        //            .preferredColorScheme(.light)
    }
}
