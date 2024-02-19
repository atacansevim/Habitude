//
//  SignUpViewModelContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

protocol LoginViewModelContract: AnyObject {
    var delegate: LoginHandleViewModelDelegate? { get set }
    var appDelegate: AppDelegateViewOutput? { get set }
    var typeOfLogin: LoginTypeEnum? { get set }
    
    func signUp(email: String, password: String)
    func signIn(email: String, password: String)
    func signUpWithFacebook()
    func signUpWithGoogle()
    func changeTheLoginType()
}

protocol LoginHandleViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: LoginHandleViewOutput)
}

enum LoginHandleViewOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case changeTheLoginType
    case showAlert(message: String)
}

protocol AppDelegateViewOutput: AnyObject {
    func goToHomePage(email: String)
}

