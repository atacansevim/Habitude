//
//  SignUpViewModelContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

protocol SignUpViewModelContract: AnyObject {
    var handleViewOutput: SignUpHandleViewOutput? { get }
    
    func signUp(email: String, password: String)
    func signUpWithFacebook()
    func signUpWithGoogle()
}

protocol SignUpHandleViewOutput: AnyObject {
    func setLoading(isLoading: Bool)
    func fetchedData(email: String)
    func showError(error: Error)
}

