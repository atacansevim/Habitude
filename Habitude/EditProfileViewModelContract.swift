//
//  EditProfileViewModelContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.02.2024.
//

import Foundation
import UIKit

protocol EditProfileViewModelContract: AnyObject {
    var profilePhoto: UIImage? { get set }
    var name: String? { get set }
    var surname: String? { get set }
    var bio: String? { get set }
    var profileManager: ProfileContract { get set }
    var delegate: EditProfileViewModelDelegate? { get set }
    
    func uploadProfilePhoto(_ image: UIImage)
    func uploadData()
    func setProfileData()
}

protocol EditProfileViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: EditProfileViewModelOutput)
}

enum EditProfileViewModelOutput: Equatable {
    case setLoading(Bool)
    case setProfilePhoto(UIImage)
    case setState(state: ListState)
    case setProfileData
    case backToProfile
}
