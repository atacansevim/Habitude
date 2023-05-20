//
//  SignUpViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//
import FirebaseAuth

final class SignUpViewModel: SignUpViewModelContract {
    
   weak var delegate: SignUpHandleViewOutput?
   weak var appDelegate: AppDelegateViewOutput?
   var authService: AuthenticationContract!
   var typeOfLogin: LoginTypeEnum?
    
    init(authService: AuthenticationContract, for type: LoginTypeEnum) {
        self.authService = authService
        self.authService.delegate = self
        self.typeOfLogin = type
    }
}

//MARK: -ServiceCalls

extension SignUpViewModel {
    
    func signUp(email: String, password: String) {
        delegate?.setLoading(isLoading: true)
        authService.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        delegate?.setLoading(isLoading: true)
        authService.signIn(email: email, password: password)
    }
    
    func signUpWithFacebook() {
    }
    
    func signUpWithGoogle() {
    }
}

//MARK: -ServiceResponse

extension SignUpViewModel: AuthenticationDelegate {
    
    func fetchedData(email: String?, error: Error?) {
        delegate?.setLoading(isLoading: false)
        
        guard let email = email else {
            delegate?.showError(error: error!)
            return
        }
        appDelegate?.goToHomePage()
    }
}

//MARK: -Actions

extension SignUpViewModel {
    
    func changeTheLoginType() {
        delegate?.changeTheLoginType()
    }
}
