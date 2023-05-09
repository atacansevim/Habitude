//
//  ProfileViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import Foundation

protocol ProfileViewModelContracts {
    var title: String { get }
    var delegate: ProfileViewModelDelegate? { get set }
    
    func goEditProfile()
}

protocol ProfileViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: ProfileViewModelOutput)
}

enum ProfileViewModelOutput: Equatable {
    case setLoading(Bool)
    case goToEditProfile
}
