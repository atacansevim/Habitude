//
//  SignUpViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 25.04.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    // MARK: -Constants
    
    private enum Constants {
        static let illustrationName = "LoginScreenIllustration"
        static let illustrationImageHeight: CGFloat = 422
    }
    
    // MARK: -Properties
    
    private let illustrationImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: Constants.illustrationName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginView: LoginBottomView = {
        let view = LoginBottomView(titleText: "Sign Up", actionLabelText: "Sign in")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = false
        return indicator
    }()
    
    private var email: String?
    private var password: String?
    
    private var viewModel: SignUpViewModel = SignUpViewModel(authService: Authentication())
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        viewModel.handleViewOutput = self
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension SignUpViewController {
    func style() {
        view.backgroundColor = UIColor.Habitute.primaryLight
    }
    
    func layout() {
        view.addSubview(illustrationImageView)
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: illustrationImageView.topAnchor),
            view.leadingAnchor.constraint(equalTo: illustrationImageView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: illustrationImageView.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: Constants.illustrationImageHeight)
        ])
        
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 10
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showIndicator(isShow: Bool){
        if isShow {
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
        activityIndicator.isHidden = false
    }

}

extension SignUpViewController: LoginBottomViewDelegate {
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func sendEmail(email: String) {
        self.email = email
    }
    
    func sendPassword(password: String) {
        self.password = password
    }
    
    func tapContiuneButton() {
        viewModel.signUp(email: email!, password: password!)
    }
}

extension SignUpViewController: SignUpHandleViewOutput {
    func setLoading(isLoading: Bool) {
        showIndicator(isShow: isLoading)
    }
    
    func fetchedData(email: String) {
    }
    
    func showError(error: Error) {
    }
}

extension SignUpViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
