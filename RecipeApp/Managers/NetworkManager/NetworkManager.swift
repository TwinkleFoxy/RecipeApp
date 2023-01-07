//
//  NetworkManager.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.10.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func featchData<T: Codable>(urlString: String, clouser: @escaping (T?, String?)-> ()) {
        guard let url = URL(string: urlString) else { print("Error cheking URL: \(urlString)"); clouser(nil, "Error cheking URL"); return}
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            if let error = error {
                print("Error request data from URL: \(error)")
                clouser(nil, "Error request data from URL: \(error.localizedDescription)")
            }
            
            let decodedData = decodeData(type: T.self, data: data)
            
            if decodedData != nil {
                clouser(decodedData, nil)
            } else {
                clouser(nil, "Error: can't decoded data recived from API.")
            }

        }.resume()
    }
    
    private func decodeData<T: Codable>(type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        guard let data = data else { print("Error extraction Data for decoder");
                                        return nil }
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch let error {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
