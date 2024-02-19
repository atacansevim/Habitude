//
//  SignUpViewModelContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

protocol SignUpViewModelContract: AnyObject {
    var delegate: SignUpHandleViewOutput? { get set }
    var appDelegate: AppDelegateViewOutput? { get set }
    var typeOfLogin: LoginTypeEnum? { get set }
    
    func signUp(email: String, password: String)
    func signIn(email: String, password: String)
    func signUpWithFacebook()
    func signUpWithGoogle()
    func changeTheLoginType()
}

protocol SignUpHandleViewOutput: AnyObject {
    func setLoading(isLoading: Bool)
    func fetchedData(email: String)
    func showError(error: Error)
    func changeTheLoginType()
}

protocol AppDelegateViewOutput: AnyObject {
    func goToHomePage(email: String)
}

