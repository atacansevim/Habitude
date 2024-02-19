//
//  ProfileManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.02.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

// MARK: -Constants

private enum Constants {
    static let profilePhoto: String = "profile"
    static let hearderPhoto: String = "header"
    static let collection: String = "userProfiles"
}

final class ProfileManager: ProfileContract {
    private let db = Firestore.firestore()
    private let storageRef = Storage.storage().reference()
    
    func uploadPhoto(image: UIImage, isProfilePhoto: Bool = true, completion: @escaping (Result<URL, Error>) -> Void) {
        let photoPath = isProfilePhoto ? Constants.profilePhoto  : Constants.hearderPhoto
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(
                NSError(
                    domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"]
                )
            ))
            return
        }
        
        let imageRef = storageRef.child(photoPath).child("\(String.getUserEmail()).jpg")
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            imageRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    completion(.success(downloadURL))
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                }
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let storageRef = Storage.storage().reference(forURL: url.absoluteString)
        
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(.failure(error))
            } else if let data = data {
                let image = UIImage(data: data)
                completion(.success(image))
            }
        }
    }
    
    func uploadData(profile: Profile, completion: @escaping (Error?) -> Void) {
        db.collection(Constants.collection)
        
        db.collection(Constants.collection)
            .document(String.getUserEmail())
            .setData(
                profile.getDictionary()
            )
        { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func setProfilePhotoUrl(url: String, completion: @escaping (Error?) -> Void) {
        db.collection(Constants.collection)
        
        db.collection(Constants.collection)
            .document(String.getUserEmail())
            .setData(
                ["imageURL": url],
                merge: true
            )
        { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func getProfileData(completion: @escaping (Result<Profile?, Error>) -> Void) {
        let documentRef = db.collection(Constants.collection).document(String.getUserEmail())

        documentRef.addSnapshotListener { documentSnapshot, error in
            
            guard let document = documentSnapshot else {
                return
            }
            
            guard let data = document.data() else {
                completion(.success(nil))
                return
            }
            
            completion(.success(Profile(profileDictionary: data)))
        }
    }
}

