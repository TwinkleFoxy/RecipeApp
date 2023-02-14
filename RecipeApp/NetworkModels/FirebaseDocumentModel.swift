//
//  FirebaseDocumentModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 12.02.2023.
//

import Foundation

struct FirebaseDocumentModel: Identifiable {
    
    var id = UUID()
    var documentID: String
    var documentBody: [String : Any]
    
    static func getFakeData() -> FirebaseDocumentModel {
        FirebaseDocumentModel(documentID: "tuytuyuyuy", documentBody: ["vghv" : "vhgvh"])
    }
}
