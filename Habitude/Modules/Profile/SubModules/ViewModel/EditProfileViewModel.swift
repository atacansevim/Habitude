//
//  EditProfileViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.02.2024.
//

import Foundation
import UIKit

final class EditProfileViewModel: EditProfileViewModelContract {
    
    // MARK: -Constants
    
    private enum Constants {
        static let userNameKeychainKey: String = "userName"
    }
    
    // MARK: -Properties
    
    var name: String?
    var surname: String?
    var bio: String?
    var profilePhotoURL: URL?
    var profilePhoto: UIImage?
    var profile: Profile?
    
    var profileManager: ProfileContract
    weak var delegate: EditProfileViewModelDelegate?
    
    // MARK: -init
    
    init(profileManager: ProfileContract, profile: Profile? = nil, profilePhoto: UIImage? = nil) {
        self.profileManager = profileManager
        self.profilePhoto = profilePhoto
        self.profile = profile
    }
}

// MARK: -Network Functions

extension EditProfileViewModel {
    
    func uploadProfilePhoto(_ image: UIImage) {
        delegate?.handleViewOutput(.setLoading(true))
        profileManager.uploadPhoto(image: image, isProfilePhoto: true) {[weak self] result in
            guard let self else {
                return
            }
            delegate?.handleViewOutput(.setLoading(false))
            switch result {
            case .success(let photoUrl):
                profileManager.setProfilePhotoUrl(url: photoUrl.absoluteString) { [weak self] error in
                    guard let error else {
                        self?.profilePhotoURL = photoUrl
                        self?.profilePhoto = image
                        self?.delegate?.handleViewOutput(.setProfilePhoto(image))
                        self?.delegate?.handleViewOutput(.backToProfile)
                        return
                    }
                    self?.delegate?.handleViewOutput(.showAlert(message: error.localizedDescription))
                }
            case .failure(let error):
                self.delegate?.handleViewOutput(.showAlert(message: error.localizedDescription))
            }
        }
    }
    
    func uploadData() {
        delegate?.handleViewOutput(.setLoading(true))
        profileManager.uploadData(profile: Profile(
            name: name.safelyUnwrapped(),
            surname: surname.safelyUnwrapped(),
            bio: bio.safelyUnwrapped(),
            imageUrl: profilePhotoURL
        )) { [weak self] error in
            
            guard let self else {
                return
            }
            delegate?.handleViewOutput(.setLoading(false))
            guard let error else {
                saveUserNameToKeyChain()
                delegate?.handleViewOutput(.backToProfile)
                return
            }
            self.delegate?.handleViewOutput(.showAlert(message: error.localizedDescription))
        }
    }
    
    private func saveUserNameToKeyChain() {
        KeychainManager.shared.setData(name.safelyUnwrapped(), forKey: Constants.userNameKeychainKey)
    }
}

// MARK: -Helper Functions

extension EditProfileViewModel {
    
    func setProfileData() {
        guard let profile else {
            return
        }
        
        if let profilePhoto {
            profilePhotoURL = URL(string: profile.imageUrl)
            delegate?.handleViewOutput(.setProfilePhoto(profilePhoto))
        }
        
        if profile.name != "" {
            name = profile.name
        }
        
        if profile.surname != "" {
            surname = profile.surname
        }
        
        if profile.bio != "" {
            bio = profile.bio
        }
        delegate?.handleViewOutput(.setState(state: .finished(.data)))
        
    }
}
