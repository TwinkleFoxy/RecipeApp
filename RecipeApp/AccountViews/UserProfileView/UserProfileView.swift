//
//  UserProfileView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.01.2023.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var showProfileSettingsSwitcher: Bool = false
    @State private var showAddMyPrivateRecipeSwitcher: Bool = false
    @Binding var signInSwitcher: Bool
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            Image("background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    ZStack {
                        GradientForPictureProfileView(profilePicture: "user", userImage: firebaseManager.userImage)
                            .frame(width: 66, height: 66)
                    }
                    .frame(width: 66, height: 66)
                    VStack(alignment: .leading) {
                        Text(firebaseManager.name)
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                        Text("Some description profile")
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    Button { // Profile settings button
                        showProfileSettingsSwitcher.toggle()
                    } label: {
                        IconTextFieldView(iconName: "gearshape", isGlow: .constant(true), image: .constant(nil))
                    }
                }
                
                // Divider
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .opacity(0.1)
                
                VStack {
                    ButtonWithGlowView(title: "Add my private Recipe") {
                        //MARK: - Delete then created my recipe view
                        //showAddMyPrivateRecipeSwitcher.toggle()
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .stroke()
                    .foregroundColor(.white)
                    .opacity(0.2)
                    .background {
                        Color.secondaryBackground.opacity(0.5)
                        VisualEffectBlur(blurStyle: .systemMaterialDark)
                            .shadow(color: .black.opacity(0.8), radius: 10, x: 4, y: 5)
                    }
            }
            .cornerRadius(30)
            .padding(.horizontal)
            
            VStack(alignment: .center) {
                Spacer()
                Button { // Logout from account button
                    firebaseManager.signOutFromFirebaseAuth {
                        signInSwitcher.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                        Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                            .background {
                                Circle()
                                    .stroke()
                                    .opacity(0.2)
                                    .foregroundColor(.white)
                                    .frame(width: 48, height: 48)
                                    .background {
                                        VisualEffectBlur(blurStyle: .systemMaterialDark)
                                            .cornerRadius(30)
                                    }
                            }
                }
                .padding(.bottom, 110)
            }
        }
        .onAppear {
            firebaseManager.featchUserDataFromFirebase()
        }
        .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher) {} message: {
            Text(firebaseManager.alertMessage)
        }
        .fullScreenCover(isPresented: $showProfileSettingsSwitcher, content: {
            UserProfileSettingsView()
        })
        .fullScreenCover(isPresented: $showAddMyPrivateRecipeSwitcher) {
            //MARK: - Create my recipe view
//            AddMyPrivateRecipeView()
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(signInSwitcher: .constant(true))
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
//                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
            .preferredColorScheme(.dark)
    }
}
