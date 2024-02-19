//
//  ProfileContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.02.2024.
//

import Foundation
import UIKit

protocol ProfileContract: AnyObject {
    func uploadPhoto(image: UIImage, isProfilePhoto: Bool, completion: @escaping (Result<URL, Error>) -> Void)
    func uploadData(profile: Profile, completion: @escaping (Error?) -> Void)
    func getProfileData(completion: @escaping (Result<Profile?, Error>) -> Void)
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void)
    func setProfilePhotoUrl(url: String, completion: @escaping (Error?) -> Void)
}
