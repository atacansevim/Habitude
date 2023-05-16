//
//  ProfileViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let headerImageHeight: CGFloat = 260
        static let profileImageSize: CGFloat = 100
        static let borderWidth: CGFloat = 2
        static let smallSpacing: CGFloat = 10
        static let spacing: CGFloat = 12
        static let customSpacing: CGFloat = 12
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
    }
    
    // MARK: -Properties
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: Images.profileHeader.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.profileImageSize / 2
        imageView.layer.borderColor = UIColor.Habitute.accent.cgColor
        imageView.layer.borderWidth = Constants.borderWidth
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        //TODO: (change dummy email)
        label.text = "william@gmail.com"
        label.font = UIFont.Habitude.paragraphExtraSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        //TODO: (change dummy email)
        label.text = "William Kate"
        label.font = UIFont.Habitude.titleLarge
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        //TODO: (change dummy email)
        label.text = "Digital Nomad & Optimistic Solo Traveller"
        label.font = UIFont.Habitude.paragraphSmall
        label.textColor = UIColor.Habitute.primaryLightHalfAlpha
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    private let editProfileButton = HabitudeSharpButton(title: "Edit Profile")
    private let changePasswordButton = HabitudeSharpButton(title: "Change Password", icon: Images.lock.image)
    private let reportBugButton = HabitudeSharpButton(title: "Report a Bug", icon: Images.bug.image)
    
    private var viewModel: ProfileViewModelContracts!
    
    convenience init(viewModel: ProfileViewModelContracts){
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
        editProfileButton.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        navigationController?.navigationBar.barTintColor = .clear
        setActionsStack()
    }
    
    private func setActionsStack() {
        actionsStackView.addArrangedSubview(editProfileButton)
        actionsStackView.addArrangedSubview(changePasswordButton)
        actionsStackView.addArrangedSubview(reportBugButton)
    }
    
    @objc private func editProfileAction(sender: UIButton!) {
        viewModel.goEditProfile()
    }
}

extension ProfileViewController {
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        title = viewModel.title
        
        editProfileButton.isEnabled = true
        changePasswordButton.isEnabled = false
        reportBugButton.isEnabled = false
    }
    
    func layout() {
        view.addSubview(headerImageView)
        NSLayoutConstraint.activate([
            headerImageView.heightAnchor.constraint(equalToConstant: Constants.headerImageHeight),
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -Constants.profileImageSize / 2)
        ])
        
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Constants.spacing)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Constants.customSpacing)
        ])
        
        view.addSubview(bioLabel)
        NSLayoutConstraint.activate([
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.smallSpacing)
        ])
        
        view.addSubview(actionsStackView)
        NSLayoutConstraint.activate([
            actionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionsStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: Constants.customLargeSpacing)
        ])
    }
}


// MARK: -HandleViewOutput

extension ProfileViewController: ProfileViewModelDelegate {
    func handleViewOutput(_ output: ProfileViewModelOutput) {
        switch output {
        case .setLoading(_): break
        case .goToEditProfile:
            self.navigationItem.removeBackBarButtonTitle()
            self.show(EditProfileViewController(), sender: nil)
        }
    }
}
