//
//  ProfileViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

final class ProfileViewModel: ProfileViewModelContracts {
  
    // MARK: -Properties
    
    var title: String = "Profile"
    weak var delegate: ProfileViewModelDelegate?
    
    // MARK: - init
    
    init(title: String) {
        self.title = title
    }
}

extension ProfileViewModel {
    
    func goEditProfile() {
        delegate?.handleViewOutput(.goToEditProfile)
    }
}
