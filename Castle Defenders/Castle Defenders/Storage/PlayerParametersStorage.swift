//
//  PlayerParametersStorage.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.01.25.
//
import SwiftUI
import FirebaseFirestore

class PlayerParametersStorage {
    let db = Firestore.firestore()
    func savePlayerData(playerID: String, data: [String: Any]) {
        db.collection("players").document(playerID).setData(data) { error in
            if let error = error {
                print("Error saving player data: \(error)")
            }
        }
    }
    
    func loadPlayerData(playerID: String, completion: @escaping ([String: Any]?) -> Void) {
        db.collection("players").document(playerID).getDocument { document, error in
            if let document = document, document.exists {
                completion(document.data())
            } else {
                print("Player data not found: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
