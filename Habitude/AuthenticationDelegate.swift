//
//  AuthenticationDelegate.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

protocol AuthenticationDelegate: AnyObject {
    func fetchedData(email: String?, error: Error?)
}
