//
//  ProfileViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import Foundation
import UIKit

protocol ProfileViewModelContracts {
    var title: String { get }
    var profile: Profile? { get set }
    var profilePhoto: UIImage? { get set }
    var delegate: ProfileViewModelDelegate? { get set }
    
    func goEditProfile()
    func loadData()
}

protocol ProfileViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: ProfileViewModelOutput)
}

enum ProfileViewModelOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case goToEditProfile(profile: Profile?)
    case setProfilePhoto(UIImage)
}
