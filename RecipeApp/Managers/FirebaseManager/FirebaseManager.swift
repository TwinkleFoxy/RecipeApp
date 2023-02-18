//
//  FirebaseManager.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

import FirebaseFirestore
import FirebaseCore

class FirebaseManager: ObservableObject {
    @Published var publicRecipe: [RecipeFirebaseModel] = []
    @Published var filteredRecipe: [RecipeFirebaseModel] = []
    @Published var searchedRecipeForHomeView: [RecipeFirebaseModel] = []
    @Published var searchedRecipeForMyRecipe: [RecipeFirebaseModel] = []
    @Published var listUserFavouriteRecipes: [RecipeFirebaseModel] = []
    @Published var userFavouriteRecipeDocument: [String : Bool] = [ : ]
    @Published var userImage: UIImage?
    @Published var name: String = "Your name"
    @Published var signInSwitcher: Bool = false
    
    @Published var showAlertSwitcher: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
}

//MARK: - Firebase Firestore
extension FirebaseManager {
    
    func featchPublicRecipeWithMaxLimit(limit: Int = 10000) {
        DispatchQueue.main.async { [unowned self] in
            publicRecipe.removeAll()
            
            let db = Firestore.firestore()
            
            db.collection("Recipe").limit(to: limit).getDocuments { [unowned self] querySnapshot, error in
                
                let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
                
                if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                    publicRecipe = arrayRecipeFirebaseModel
                }
            }
        }
    }
    
    func featchAndFilterRecipeFieldIsEqualTo(collectionName: String, field: String, equalTo: Any, limitToReceive: Int = 1000) {
        DispatchQueue.main.async { [unowned self] in
            filteredRecipe.removeAll()
            
            let db = Firestore.firestore()
            
            db.collection(collectionName).whereField(field, isEqualTo: equalTo).getDocuments { [unowned self] querySnapshot, error in
                
                let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
                
                if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                    filteredRecipe = arrayRecipeFirebaseModel
                }
            }
        }
    }
    
    func searchRecipeForHomeView(searchText: String, limitToReceive: Int = 1000) {
        DispatchQueue.main.async { [unowned self] in
            searchedRecipeForHomeView.removeAll()
            searchRecipe(searchText: searchText, byField: "nameForSearch", inCollection: "Recipe", limitToReceive: limitToReceive) { [unowned self] searchedRecipe in
                searchedRecipeForHomeView = searchedRecipe
            }
        }
    }
    
    func searchRecipeForMyRecipeViwe(searchText: String, inCollection: String, limitToReceive: Int = 10000) {
        DispatchQueue.main.async { [unowned self] in
            searchedRecipeForMyRecipe.removeAll()
            searchRecipe(searchText: searchText, byField: "nameForSearch", inCollection: inCollection, limitToReceive: limitToReceive) { [unowned self] searchedRecipe in
                searchedRecipeForMyRecipe = searchedRecipe
            }
        }
    }
    
    private func searchRecipe(searchText: String, byField name: String, inCollection nameCollection: String, limitToReceive: Int = 100000, closure: @escaping ([RecipeFirebaseModel])->()) {
        
        let db = Firestore.firestore()
        
        var startSearchArray: [String] = []
        startSearchArray.append(searchText.lowercased())
        var searchResultArray: [RecipeFirebaseModel] = []
        
        db.collection(nameCollection).limit(to: limitToReceive).order(by: name).start(at: startSearchArray).getDocuments { [unowned self] querySnapshot, error in
            
            let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
            
            if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                searchResultArray = arrayRecipeFirebaseModel
                closure(searchResultArray)
            }
        }
    }
    
    func addUserRecipeDocument(previewImage: UIImage?, descriptionImages: [UIImage], recipeFirebaseModel: RecipeFirebaseModel, closure: @escaping ()->()) {
        
        var previewImageURL: String = ""
        var descriptionImagesURL: [String] = []
        
        
        guard let userID = Auth.auth().currentUser?.uid else {
            alertTitle = "Error"
            alertMessage = "Can't recive user ID"
            showAlertSwitcher.toggle()
            return
        }
        
        let db = Firestore.firestore()
        
        let firebaseDocument = db.collection(userID).document()
        let documentID = firebaseDocument.documentID
        
        uploadPreviewImageForRecipe(previewImage: previewImage, userID: userID, documentID: documentID) { [unowned self] imageURLString in
            previewImageURL = imageURLString
            uploadDescriptionImage(descriptionImages: descriptionImages, userID: userID, documentID: documentID) { [unowned self] imagesURLArrayString in
                descriptionImagesURL = imagesURLArrayString
                saveDocumentResipe(publesherUserID: userID, recipeFirebaseModel: recipeFirebaseModel, previewImageURL: previewImageURL, descriptionImagesURL: descriptionImagesURL, firebaseDocument: firebaseDocument) {
                    closure()
                }
            }
        }
    }
    
    func deliteUserRecipeDocument(documentIDNameUserRecipeForDelete documentIDName: String, closure: @escaping () -> ()) {
        
        guard let currantUserID = getCurrentUserIDFirebase() else { return }
        
        deleteDocument(inCollection: currantUserID, documentIDName: documentIDName) {
            closure()
        }
    }
}

//MARK: - Firebase Auth
extension FirebaseManager {
    
    func signInSignUp(email: String, password: String, signInSwitcher: Bool) {
        DispatchQueue.main.async {
            if signInSwitcher {
                Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
                    if let error = error {
                        alertTitle = "Error. Can't login to account"
                        alertMessage = error.localizedDescription
                        showAlertSwitcher.toggle()
                    } else {
                        print("User SignIn Success")
                    }
                }
            } else {
                Auth.auth().createUser(withEmail: email, password: password) { [unowned self] authResult, error in
                    if let error = error {
                        alertTitle = "Error. Account not created"
                        alertMessage = error.localizedDescription
                        showAlertSwitcher.toggle()
                    } else {
                        alertTitle = "Account created."
                        alertMessage = "Account create by email Success"
                        showAlertSwitcher.toggle()
                    }
                }
            }
        }
    }
    
    func getCurrentUserIDFirebase() -> String? {
        guard let userUI = Auth.auth().currentUser?.uid else {
            alertTitle = "Error"
            alertMessage = "Can't recive user ID"
            showAlertSwitcher.toggle()
            return nil
        }
        return userUI
    }
    
    func sendPasswordReset(email: String) {
        DispatchQueue.main.async {
            Auth.auth().sendPasswordReset(withEmail: email) { [unowned self] error in
                if let error = error {
                    alertTitle = "Can't restore password"
                    alertMessage = error.localizedDescription
                    showAlertSwitcher.toggle()
                } else {
                    alertTitle = "Request to restore password accepted"
                    alertMessage = "Check your inbox for email to reset you password"
                    showAlertSwitcher.toggle()
                }
            }
        }
    }
    
    func signOutFromFirebaseAuth(closure: @escaping ()->()) {
        DispatchQueue.main.async { [unowned self] in
            do {
                try Auth.auth().signOut()
                name = "Your name"
                userImage = nil
                closure()
            } catch (let error) {
                alertTitle = "Error. Can't logout from account"
                alertMessage = error.localizedDescription
                showAlertSwitcher.toggle()
            }
        }
    }
    
    func addStateDidChangeListenerFirebase() {
        Auth.auth().addStateDidChangeListener { [unowned self] auth, user in
            if user !== nil {
                signInSwitcher = true
                updateFavouriteListUserRecipeInApp() {}
            } else {
                signInSwitcher = false
            }
        }
    }
    
    func featchUserDataFromFirebase() {
        DispatchQueue.main.async { [unowned self] in
            name = Auth.auth().currentUser?.displayName ?? "Your name"
            if let imageURL = Auth.auth().currentUser?.photoURL {
                if let imageData = try? Data(contentsOf: imageURL) {
                    userImage = UIImage(data: imageData)
                }
            }
        }
    }
    
    func saveUserSettingsInFirebse(name: String, imageFormPicker: UIImage?, closure: @escaping ()->()) {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            alertTitle = "Error"
            alertMessage = "Can't recive user ID"
            showAlertSwitcher.toggle()
            return
        }
        
        let chaneUserDataRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if !name.isEmpty {
            chaneUserDataRequest?.displayName = name
        }
        if let imageFormPicker = imageFormPicker {
            uploadImage(image: imageFormPicker, saveImagePath: "users/\(userID)/profileIcons") { [unowned self] url, error in
                guard let url = url else {
                    self.alertTitle = "Save photo failure"
                    if let error = error {
                        alertMessage = error.localizedDescription
                    }
                    showAlertSwitcher.toggle()
                    return
                }
                chaneUserDataRequest?.photoURL = url
                
                chaneUserDataRequest?.commitChanges(completion: { [unowned self] error in
                    if error == nil {
                        //                self.alertTitle = "Save data succeed"
                        //                self.alertMessage = "User profile data been updated"
                        //                self.showAlertSwitcher.toggle()
                        closure()
                    } else {
                        self.alertTitle = "Save data failure"
                        if let error = error {
                            alertMessage = error.localizedDescription
                        }
                        showAlertSwitcher.toggle()
                    }
                })
            }
        } else {
            chaneUserDataRequest?.commitChanges(completion: { [unowned self] error in
                if error == nil {
                    closure()
                } else {
                    self.alertTitle = "Save data failure"
                    if let error = error {
                        alertMessage = error.localizedDescription
                    }
                    showAlertSwitcher.toggle()
                }
            })
        }
    }
}



// MARK: - Helpers
extension FirebaseManager {
    
    private func convertFirebaseRecipeDataToRecipeFirebaseModel(documentID: String, data: [String : Any]) -> RecipeFirebaseModel {
        
        let publesherUserID = data["publesherUserID"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let nameForSearch = data["nameForSearch"] as? String ?? ""
        let imagePreviewURL = data["imagePreviewURL"] as? String ?? ""
        let imagesDescriptionURL = data["imagesDescriptionURL"] as? [String] ?? []
        let category = data["category"] as? String ?? ""
        let description = data["description"] as? String ?? ""
        let prepTime = data["prepTime"] as? String ?? ""
        let servings = data["servings"] as? Int
        let chill = data["chill"] as? String ?? ""
        let cookTime = data["cookTime"] as? String ?? ""
        let totalTime = data["totalTime"] as? String ?? ""
        let yield = data["yield"] as? Int
        let ingredients = data["ingredients"] as? [String] ?? []
        
        let calories = data["calories"] as? Int
        let saturatedFat = data["saturatedFat"] as? Int
        let totalFat = data["totalFat"] as? Int
        let cholesterol = data["cholesterol"] as? Int
        let sodium = data["sodium"] as? Int
        let totalCarbohydrate = data["totalCarbohydrate"] as? Int
        let dietaryFiber = data["dietaryFiber"] as? Int
        let totalSugars = data["totalSugars"] as? Int
        let protein = data["protein"] as? Int
        let metods = data["metods"] as? [String] ?? []
        
        return RecipeFirebaseModel(documentID: documentID, publesherUserID: publesherUserID, name: name, nameForSearch: nameForSearch, imagePreviewURL: imagePreviewURL, imagesDescriptionURL: imagesDescriptionURL, category: category, description: description, prepTime: prepTime, servings: servings, chill: chill, cookTime: cookTime, totalTime: totalTime, yield: yield, ingredients: ingredients, calories: calories, saturatedFat: saturatedFat, totalFat: totalFat, cholesterol: cholesterol, sodium: sodium, totalCarbohydrate: totalCarbohydrate, dietaryFiber: dietaryFiber, totalSugars: totalSugars, protein: protein, metods: metods)
    }
    
    private func convertRecipeFirebaseModelToFirebaseRecipeData(userRecipe: RecipeFirebaseModel) -> [String: Any] {
        let firebaseRecipeData = [
            "publesherUserID": userRecipe.publesherUserID ?? "",
            "name": userRecipe.name,
            "nameForSearch": userRecipe.nameForSearch,
            "imagePreviewURL": userRecipe.imagePreviewURL ?? "",
            "imagesDescriptionURL": userRecipe.imagesDescriptionURL ?? [""],
            "category": userRecipe.category,
            "description": userRecipe.description,
            "prepTime": userRecipe.prepTime,
            "servings": userRecipe.servings ?? "No data",
            "chill": userRecipe.chill,
            "cookTime": userRecipe.cookTime,
            "totalTime": userRecipe.totalTime,
            "yield": userRecipe.yield ?? "No data",
            "ingredients": userRecipe.ingredients,
            
            "calories": userRecipe.calories ?? "No data",
            "saturatedFat": userRecipe.saturatedFat ?? "No data",
            "totalFat": userRecipe.totalFat ?? "No data",
            "cholesterol": userRecipe.cholesterol ?? "No data",
            "sodium": userRecipe.sodium ?? "No data",
            "totalCarbohydrate": userRecipe.totalCarbohydrate ?? "No data",
            "dietaryFiber": userRecipe.dietaryFiber ?? "No data",
            "totalSugars": userRecipe.totalSugars ?? "No data",
            "protein": userRecipe.protein ?? "No data",
            "metods": userRecipe.metods
        ] as [String: Any]
        return firebaseRecipeData
    }
    
    private func checkQuerySnapshotRecipeFromFirebase(querySnapshot: QuerySnapshot?, error: Error?) -> [RecipeFirebaseModel]? {
        var arrayRecipeFirebaseModel: [RecipeFirebaseModel] = []
        
        if let error = error {
            alertTitle = "Error recive documents"
            alertMessage = error.localizedDescription
            showAlertSwitcher.toggle()
            return nil
        } else {
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let documentID = document.documentID
                    let recipeFirebaseModel = self.convertFirebaseRecipeDataToRecipeFirebaseModel(documentID: documentID, data: data)
                    
                    arrayRecipeFirebaseModel.append(recipeFirebaseModel)
                }
                return arrayRecipeFirebaseModel
            } else {
                alertTitle = "Error"
                alertMessage = "Can't extract querySnapshot from Firebase"
                showAlertSwitcher.toggle()
                return nil
            }
        }
    }
    
    private func uploadImage(image: UIImage, saveImagePath: String, complition: @escaping(_ url: URL?, _ error: Error?)->()) {
        let firebaseStorageRefernce = Storage.storage().reference().child(saveImagePath)
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        firebaseStorageRefernce.putData(imageData, metadata: metaData) { storageMetadata, error in
            if error == nil{
                firebaseStorageRefernce.downloadURL { downloadURL, error in
                    if error == nil, let downloadURL = downloadURL {
                        complition(downloadURL, nil)
                    } else {
                        complition(nil, error)
                    }
                }
            } else {
                complition(nil, error)
            }
        }
    }
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}



// MARK: - Private funcs upload resipe
extension FirebaseManager {
    
    private func uploadPreviewImageForRecipe(previewImage: UIImage?, userID: String, documentID: String, closure: @escaping (_ imageURLString: String) -> ()) {
        // Upload preview image
        if let previewImage = previewImage {
            uploadImage(image: previewImage, saveImagePath: "users/\(userID)/\(documentID)/\(randomString(length: 10))") { [unowned self] url, error in
                guard let url = url else {
                    self.alertTitle = "Save photo failure"
                    if let error = error {
                        alertMessage = error.localizedDescription
                    }
                    showAlertSwitcher.toggle()
                    closure("")
                    return
                }
                closure(url.absoluteString)
            }
        } else {
            closure("")
        }
    }
    
    private func uploadDescriptionImage(descriptionImages: [UIImage], userID: String, documentID: String, closure: @escaping (_ imagesURLArrayString: [String]) -> ()) {
        // Upload description image
        var descriptionImagesURL: [String] = []
        
        if !descriptionImages.isEmpty {
            descriptionImages.forEach { descriptionImage in
                uploadImage(image: descriptionImage, saveImagePath: "users/\(userID)/\(documentID)/\(randomString(length: 10))") { [unowned self] url, error in
                    guard let url = url else {
                        self.alertTitle = "Save photo failure"
                        if let error = error {
                            alertMessage = error.localizedDescription
                        }
                        showAlertSwitcher.toggle()
                        closure([])
                        return
                    }
                    descriptionImagesURL.append(url.absoluteString)
                    if descriptionImages.count == descriptionImagesURL.count {
                        closure(descriptionImagesURL)
                    }
                }
            }
        } else {
            closure([])
        }
    }
    
    private func saveDocumentResipe(publesherUserID: String, recipeFirebaseModel: RecipeFirebaseModel, previewImageURL: String, descriptionImagesURL: [String], firebaseDocument: DocumentReference, closure: @escaping () -> ()) {
        var recipeFirebaseModel = recipeFirebaseModel
        recipeFirebaseModel.imagePreviewURL = previewImageURL
        recipeFirebaseModel.imagesDescriptionURL = descriptionImagesURL
        recipeFirebaseModel.publesherUserID = publesherUserID
        
        let userRecipe = convertRecipeFirebaseModelToFirebaseRecipeData(userRecipe: recipeFirebaseModel)
        
        // Save new Document Recipe
        firebaseDocument.setData(userRecipe, completion: { [unowned self] error in
            if error == nil {
                closure()
            } else {
                alertTitle = "Error can't save recipe"
                alertMessage = error?.localizedDescription ?? "Can't create document"
                showAlertSwitcher.toggle()
                closure()
            }
        })
    }
}

// MARK: - Work with user favourite recipe
extension FirebaseManager {
    
    private func featchUserFavouriteRecipeDocument(closure: @escaping () -> () ) {
        
        userFavouriteRecipeDocument.removeAll()
        
        guard let userID = getCurrentUserIDFirebase() else { return }
        
        featchOneDocument(collectionName: "UserFavouriteRecipe", documentIDName: userID){ [unowned self] oneDocumentFromFirebase in
            if let documentBody = oneDocumentFromFirebase?.documentBody as? [String : Bool] {
                userFavouriteRecipeDocument = documentBody
                closure()
            } else {
                closure()
            }
        }
    }
    
    private func saveUserFavouriteRecipeDocument() {
        
        guard let userID = getCurrentUserIDFirebase() else { return }
        // If the array with userFavouriteRecipeDocument recipes is out of date, the data in the database will be lost !!!
        overwritesOrCreateIfNeededDocument(collectionName: "UserFavouriteRecipe", documentIDName: userID, documentData: userFavouriteRecipeDocument)
        // successTitle: "Favourite staus updated", successMessage: "Recipe favourite status successfully updated"
    }
    
    private func featchListUserFavouriteRecipe(for listIDDocumentsFavouriteRecipe: [String : Bool], inCollection collectionName: String) {
        listUserFavouriteRecipes.removeAll()
        
        for (IDDocumentRecipe, _) in listIDDocumentsFavouriteRecipe {
            featchOneDocument(collectionName: collectionName, documentIDName: IDDocumentRecipe) { [unowned self] oneFirebaseDocument in
                if let oneFirebaseDocument = oneFirebaseDocument {
                    let oneFavouriteRecipe = self.convertFirebaseRecipeDataToRecipeFirebaseModel(documentID: oneFirebaseDocument.documentID, data: oneFirebaseDocument.documentBody)
                    listUserFavouriteRecipes.append(oneFavouriteRecipe)
                }
            }
        }
    }
}

// MARK: - Work with favourite list document
extension FirebaseManager {
    
    func updateFavouriteListUserRecipeInApp(closure: @escaping () -> ()) {
        featchUserFavouriteRecipeDocument { [unowned self] in
            featchListUserFavouriteRecipe(for: userFavouriteRecipeDocument, inCollection: "Recipe")
            closure()
        }
    }
    
    func togleFavouriteStatusInFirebase(forRecipe idRecipe: String) {
        
        updateFavouriteListUserRecipeInApp { [unowned self] in
            if userFavouriteRecipeDocument[idRecipe] == true {
                userFavouriteRecipeDocument.removeValue(forKey: idRecipe)
                saveUserFavouriteRecipeDocument()
            } else {
                userFavouriteRecipeDocument[idRecipe] = true
                saveUserFavouriteRecipeDocument()
            }
        }
    }
}

// MARK: - Work Firebase with one document
extension FirebaseManager {
    
    private func featchOneDocument(collectionName: String, documentIDName: String, closure: @escaping (FirebaseDocumentModel?) -> ()) {
        
        let db = Firestore.firestore()
        var document: FirebaseDocumentModel?
        
        db.collection(collectionName).document(documentIDName).getDocument { [unowned self] documentSnapshot, error in
            if let error = error {
                alertTitle = "Error recive documents"
                alertMessage = error.localizedDescription
                showAlertSwitcher.toggle()
                closure(nil)
            } else if let documentSnapshot = documentSnapshot {
                let documentID = documentSnapshot.documentID
                if let documentData = documentSnapshot.data() {
                    document = FirebaseDocumentModel(documentID: documentID, documentBody: documentData)
                    closure(document)
                } else {
                    closure(nil)
                }
            }
        }
    }
    
    private func overwritesOrCreateIfNeededDocument(collectionName: String, documentIDName: String, documentData: [String : Any]) {
        
        let db = Firestore.firestore()
        let firebaseDocument = db.collection(collectionName).document(documentIDName)
        firebaseDocument.setData(documentData) { [unowned self] error in
            if let error = error {
                alertTitle = "Error"
                alertMessage = error.localizedDescription
                showAlertSwitcher.toggle()
            }
        }
    }
    
    private func deleteDocument(inCollection collectionName: String, documentIDName documentID: String, closure: @escaping () -> ()) {
        
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentID).delete { [unowned self] error in
            if let errorLocalizedDescription = error?.localizedDescription {
                alertTitle = "Error"
                alertMessage = errorLocalizedDescription
                showAlertSwitcher.toggle()
                closure()
            } else {
                closure()
            }
        }
    }
}
