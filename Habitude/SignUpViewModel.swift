//
//  SignUpViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//
import FirebaseAuth

final class SignUpViewModel: SignUpViewModelContract {
    
   weak var handleViewOutput: SignUpHandleViewOutput?
   var authService: AuthenticationContract!
    
    init(authService: AuthenticationContract) {
        self.authService = authService
        self.authService.delegate = self
    }
}

//MARK: -ServiceCalls

extension SignUpViewModel {
    func signUp(email: String, password: String) {
        handleViewOutput?.setLoading(isLoading: true)
        authService.signUp(email: email, password: password)
    }
    
    func signUpWithFacebook() {
    }
    
    func signUpWithGoogle() {
    }
}

//MARK: -ServiceResponse

extension SignUpViewModel: AuthenticationDelegate {
    
    func fetchedData(email: String?, error: Error?) {
        handleViewOutput?.setLoading(isLoading: false)
        
        guard let email = email else {
            handleViewOutput?.showError(error: error!)
            return
        }
        handleViewOutput?.fetchedData(email: email)
    }
}
