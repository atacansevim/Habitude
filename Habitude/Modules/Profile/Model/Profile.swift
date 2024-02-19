//
//  Profile.swift
//  Habitude
//
//  Created by Atacan Sevim on 18.02.2024.
//

import Foundation

struct Profile: Equatable {
    let name:String
    let surname: String
    let bio: String
    let imageUrl: String
    
    init(name: String, surname: String, bio: String, imageUrl: URL?) {
        self.name = name
        self.surname = surname
        self.bio = bio
        self.imageUrl = imageUrl?.absoluteString ?? ""
    }
    
    init(profileDictionary: [String : Any]) {
        self.name = profileDictionary["name"] as! String
        self.surname = profileDictionary["surname"] as! String
        //TODO CHECK THIS OPTIONAL VALUES
        self.bio = profileDictionary["bio"] as! String
        self.imageUrl = profileDictionary["imageURL"] as! String
    }
    
    func getDictionary() -> [String: Any] {
        [
            "name": name,
            "surname": surname,
            "bio": bio,
            "imageURL": imageUrl
        ]
    }
    
    var fullName: String {
        "\(name) \(surname)"
    }
}
