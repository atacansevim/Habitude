//
//  UserBasic.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//


struct UserBasic {
    private(set) var email: String
    private(set) var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
