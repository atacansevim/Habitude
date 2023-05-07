//
//  AuthenticationContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

protocol AuthenticationContract: AnyObject {
    var delegate: AuthenticationDelegate? { get set }
    func signUp(email: String, password: String)
    func signUpWithFacebook()
    func signUpWithGoogle()
    func signIn(email: String, password: String)
    func signInWithFacebook()
    func signInWithGoogle()
}
