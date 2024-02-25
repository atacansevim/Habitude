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
    static let trackColletion: String = "habitTrack"
}

final class HabitManager: HabitManagerContract {
    private let db = Firestore.firestore()
    
    func addHabit(data: [String: Any], key: String, completion: @escaping (Error?) -> Void) {
        let habitId = key
        db.collection(Constants.collection)
            .document(getUserEmail())
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
    
    func deleteHabit(key: String, completion: @escaping (Error?) -> Void) {
        let updates = [
            key: FieldValue.delete()
        ]
        db.collection(Constants.collection)
            .document(getUserEmail())
            .updateData(updates) { error in
            if let error = error {
                completion(error)
            }
        }
        
        db.collection(Constants.trackColletion)
            .document(getUserEmail())
            .updateData(updates) { error in
            if let error = error {
                completion(error)
            }
        }
        
        completion(nil)
    }
    
    func saveProgress(data: [String: Any], key: String, completion: @escaping (Error?) -> Void) {
        db.collection(Constants.trackColletion)
            .document(getUserEmail())
            .setData([key: data], merge: true) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
    }
}

// MARK: -PrivateFunctions

extension HabitManager {
    
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
