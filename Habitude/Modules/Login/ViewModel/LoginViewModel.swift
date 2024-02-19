//
//  SignUpViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//
import FirebaseAuth

final class LoginViewModel: LoginViewModelContract {
    
    // MARK: -Properties
    
    weak var delegate: LoginHandleViewModelDelegate?
    weak var appDelegate: AppDelegateViewOutput?
    var authService: AuthenticationContract!
    var typeOfLogin: LoginTypeEnum?
    
    // MARK: -init
    
    init(authService: AuthenticationContract, for type: LoginTypeEnum) {
        self.authService = authService
        self.authService.delegate = self
        self.typeOfLogin = type
    }
}

// MARK: -ServiceCalls

extension LoginViewModel {
    
    func signUp(email: String, password: String) {
        delegate?.handleViewOutput(.setLoading(true))
        authService.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        delegate?.handleViewOutput(.setLoading(true))
        authService.signIn(email: email, password: password)
    }
    
    func signUpWithFacebook() {
    }
    
    func signUpWithGoogle() {
    }
}

// MARK: -ServiceResponse

extension LoginViewModel: AuthenticationDelegate {
    
    func fetchedData(email: String?, error: Error?) {
        delegate?.handleViewOutput(.setLoading(false))
        
        guard let email = email else {
            delegate?.handleViewOutput(.showAlert(message: error?.localizedDescription ?? ""))
            return
        }
        //- :TODO check when failed.
        KeychainManager.shared.setData(email, forKey: "userEmail")
        appDelegate?.goToHomePage(email: email)
    }
}

// MARK: -Actions

extension LoginViewModel {
    
    func changeTheLoginType() {
        delegate?.handleViewOutput(.changeTheLoginType)
    }
}
