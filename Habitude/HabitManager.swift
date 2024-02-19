//
//  HabitManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 13.02.2024.
//

import Foundation
import FirebaseFirestore

// MARK: -Constants

private enum Constants {
    static let collection: String = "habitsNew"
}

final class HabitManager {
    static let shared = HabitManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func addHabit(documentId: String, data: [String: Any], key: String? = nil, completion: @escaping (Error?) -> Void) {
        let habitId = key ?? String.currentTime()
        db.collection(Constants.collection)
            .document(documentId)
            .setData([habitId: data], merge: true) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
    }
    
    func getHabits(completion: @escaping (Result<[Habit], Error>) -> Void) {
        var habits: [Habit] = []
        let documentRef = db.collection(Constants.collection).document(getUserEmail())

        documentRef.addSnapshotListener { documentSnapshot, error in
            
            guard let document = documentSnapshot else {
                return
            }
            
            guard let data = document.data() else {
                completion(.success(habits))
                return
            }
            
            for habitItem in data {
                habits.append(Habit(
                    createdDate: habitItem.key,
                    habitDictionary: habitItem.value as! [String : Any]
                ))
            }
            
            completion(.success(habits))
        }
    }
    
    private func generateMapId() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    private func getUserEmail() -> String {
        let email:String? = KeychainManager.shared.getData(forKey: "userEmail")
        
        if let email {
            return email
        } else {
            return ""
        }
    }
}
