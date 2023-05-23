//
//  SignUpViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 25.04.2023.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    
    // MARK: -Constants
    
    private enum Constants {
        static let illustrationName = "LoginScreenIllustration"
        static let illustrationImageHeight: CGFloat = 422
        static let smallSpacing: CGFloat = 5
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 32
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
    }
    
    // MARK: -Properties
    private let scrollView = UIScrollView()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
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
        indicator.isHidden = true
        indicator.style = .medium
        indicator.color = UIColor.Habitute.accent
        return indicator
    }()
    
    private var email: String?
    private var password: String?
    
    private var viewModel: SignUpViewModelContract!
    
    // MARK: -init
    
    convenience init(viewModel: SignUpViewModelContract){
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        viewModel.delegate = self
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
        setTypeOfScreen()
        scrollView.contentInsetAdjustmentBehavior = .never
        var constraints: [NSLayoutConstraint] = []
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        constraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        constraints.append(contentsOf: [
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        constraints.last?.priority = .defaultLow
        
        NSLayoutConstraint.activate(constraints)
        contentView.addSubview(illustrationImageView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: illustrationImageView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: illustrationImageView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: illustrationImageView.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: Constants.illustrationImageHeight)
        ])
        
        contentView.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
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
        activityIndicator.isHidden = !isShow
    }
    
    private func setTypeOfScreen() {
        switch viewModel.typeOfLogin! {
        case .SIGNUP:
            break
        case .SIGNIN:
            loginView.setInfoText(for: viewModel.typeOfLogin!.infoText)
            loginView.setBottomInfoText(for: viewModel.typeOfLogin!.bottomInfoText)
            loginView.setTitleText(for: viewModel.typeOfLogin!.title)
        }
    }

}

extension SignUpViewController: LoginBottomViewDelegate {
    
    func tapBottomButton() {
        viewModel.changeTheLoginType()
    }
    
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
        switch viewModel.typeOfLogin! {
        case .SIGNUP:
            viewModel.signUp(email: email!, password: password!)
        case .SIGNIN:
            viewModel.signIn(email: email!, password: password!)
        }
    }
    
}

extension SignUpViewController: SignUpHandleViewOutput {
    func setLoading(isLoading: Bool) {
        showIndicator(isShow: isLoading)
    }
    
    func fetchedData(email: String) {
        
    }
    
    func showError(error: Error) {
        showErrorDialog(for: error.localizedDescription.lowercased())
    }
    
    func changeTheLoginType() {
        switch viewModel.typeOfLogin! {
        case .SIGNUP:
            loginView.setTitleText(for: LoginTypeEnum.SIGNIN.title)
            loginView.setInfoText(for: LoginTypeEnum.SIGNIN.infoText)
            loginView.setBottomInfoText(for: LoginTypeEnum.SIGNIN.bottomInfoText)
            loginView.setBottomLeftInfoText(for: LoginTypeEnum.SIGNIN.leftBottomInfoText)
            viewModel.typeOfLogin = LoginTypeEnum.SIGNIN
        case .SIGNIN:
            loginView.setTitleText(for: LoginTypeEnum.SIGNUP.title)
            loginView.setInfoText(for: LoginTypeEnum.SIGNUP.infoText)
            loginView.setBottomInfoText(for: LoginTypeEnum.SIGNUP.bottomInfoText)
            loginView.setBottomLeftInfoText(for: LoginTypeEnum.SIGNUP.leftBottomInfoText)
            viewModel.typeOfLogin = LoginTypeEnum.SIGNUP
        }
            
    }
}
