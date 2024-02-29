//
//  HabitudeTests.swift
//  HabitudeTests
//
//  Created by Atacan Sevim on 29.02.2024.
//

import XCTest
@testable import Habitude // Import your app module

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var authServiceMock: AuthenticationServiceMock!
    var delegateMock: LoginHandleViewModelDelegateMock!
    var appDelegateMock: AppDelegateViewOutputMock!
    
    override func setUp() {
        super.setUp()
        authServiceMock = AuthenticationServiceMock()
        delegateMock = LoginHandleViewModelDelegateMock()
        appDelegateMock = AppDelegateViewOutputMock()
        viewModel = LoginViewModel(authService: authServiceMock, for: .someType)
        viewModel.delegate = delegateMock
        viewModel.appDelegate = appDelegateMock
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        authServiceMock = nil
        delegateMock = nil
        appDelegateMock = nil
    }
    
    // Test signUp method
    func testSignUp() {
        let email = "test@example.com"
        let password = "password123"
        
        // When signing up
        viewModel.signUp(email: email, password: password)
        
        // Check if setLoading(true) is called on the delegate
        XCTAssertTrue(delegateMock.setLoadingCalled)
        
        // Check if signUp method is called on the authService
        XCTAssertTrue(authServiceMock.signUpCalled)
        XCTAssertEqual(authServiceMock.signUpEmail, email)
        XCTAssertEqual(authServiceMock.signUpPassword, password)
    }
    
    // Add more test cases for other methods as needed
}

// Mocks

class AuthenticationServiceMock: AuthenticationContract {
    
    var signUpCalled = false
    var signUpEmail: String?
    var signUpPassword: String?
    
    func signUp(email: String, password: String) {
        signUpCalled = true
        signUpEmail = email
        signUpPassword = password
    }
    
    // Implement other methods as needed
}

class LoginHandleViewModelDelegateMock: LoginHandleViewModelDelegate {
    
    var setLoadingCalled = false
    
    func handleViewOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            setLoadingCalled = isLoading
        default:
            break
        }
    }
    
    // Implement other delegate methods as needed
}

class AppDelegateViewOutputMock: AppDelegateViewOutput {
    
    func goToHomePage(email: String) {
        // Implement mock behavior
    }
    
    // Implement other mock methods as needed
}
