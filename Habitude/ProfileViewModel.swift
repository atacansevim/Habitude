//
//  ProfileViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

import Foundation
import UIKit

final class ProfileViewModel: ProfileViewModelContracts {
    // MARK: -Properties
    
    var title: String = "Profile"
    weak var delegate: ProfileViewModelDelegate?
    var profileManager: ProfileContract
    var profile: Profile?
    var profilePhoto: UIImage?
        
    // MARK: - init
    
    init(profileManager: ProfileContract) {
        self.profileManager = profileManager
    }
}

extension ProfileViewModel {
    
    func goEditProfile() {
        delegate?.handleViewOutput(.goToEditProfile(profile: profile))
    }
    
    func loadData() {
        profileManager.getProfileData {[weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let profile):
                guard let profile else {
                    return
                }
                self.profile = profile
                self.delegate?.handleViewOutput(.setState(state: .finished(.data)))
                
                guard let url = URL(string: profile.imageUrl) else {
                    return
                }
                profileManager.downloadImage(from: url) {[weak self] image in
                    guard let self, let profilePhoto = image else {
                        return
                    }
                    self.profilePhoto = profilePhoto
                    self.delegate?.handleViewOutput(.setProfilePhoto(profilePhoto))
                }
                
            case .failure(let failure):
                break
            }
        }
    }
}
