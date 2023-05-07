//
//  Authentication.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

import FirebaseAuth

final class Authentication: AuthenticationContract {
    weak var delegate: AuthenticationDelegate?
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error as? NSError {
                self?.delegate?.fetchedData(email: nil, error: error)
            } else {
                print("User signs up successfully")
                self?.delegate?.fetchedData(email: Auth.auth().currentUser?.email, error: nil)
            }
        }
    }
    
    func signInWithFacebook() {
    }
    
    func signInWithGoogle() {
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error as? NSError {
                self?.delegate?.fetchedData(email: nil, error: error)
            } else {
                print("User signs up successfully")
                self?.delegate?.fetchedData(email: Auth.auth().currentUser?.email, error: nil)
            }
        }
    }

    func signUpWithFacebook() {
    }

    func signUpWithGoogle() {
    }
}
