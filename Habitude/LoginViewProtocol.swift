//
//  LoginViewProtocol.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

import Foundation

protocol HabitudeTextFieldDelegate: AnyObject {
    func sendEmail(email: String)
    func sendPassword(password: String)
}

protocol LoginBottomViewDelegate: AnyObject {
    func sendEmail(email: String)
    func sendPassword(password: String)
    func tapContiuneButton()
    func dismissKeyboard()
}
