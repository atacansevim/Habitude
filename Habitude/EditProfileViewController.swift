//
//  EditProfileViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let headerImageHeight: CGFloat = 260
        static let profileImageSize: CGFloat = 100
        static let borderWidth: CGFloat = 2
        static let smallSpacing: CGFloat = 10
        static let spacing: CGFloat = 12
        static let customSpacing: CGFloat = 12
        static let customLargeSpacing: CGFloat = 41
        static let stackSpacing: CGFloat = 20
    }
    
    // MARK: -Properties
    
    private let addCoverPhotoInfoView = EditProfileViewController.createCoverPhotoInfo()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: Images.shadow.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.Habitute.secondaryLight
        imageView.layer.cornerRadius = Constants.profileImageSize / 2
        imageView.layer.borderColor = UIColor.darkText.cgColor
        imageView.layer.borderWidth = Constants.borderWidth
        
        let icon = UIImageView(
            image:
                Images.plus.image.withTintColor(
                    UIColor.Habitute.primaryLight,
                    renderingMode: .alwaysOriginal
                )
        )
        icon.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        return imageView
    }()
    
    private let profileInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
     
    private let actionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    private let changePasswordButton = HabitudeSharpButton(title: "Change Password", icon: Images.lock.image)
    private let reportBugButton = HabitudeSharpButton(title: "Report a Bug", icon: Images.bug.image)
    
    private let firstNameTextView = HabitudeProfileTextView(placeHolder: "Add First Name")
    private let lastNameTextView = HabitudeProfileTextView(placeHolder: "Add Last Name")
    private let bioTextView = HabitudeProfileTextView(placeHolder: "Add Bio", isInfoShown: true)
    private let emailTextView = HabitudeProfileTextView(placeHolder: "Add Email Address")
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        navigationController?.navigationBar.barTintColor = .clear
        setProfileInfoTextViews()
        setActionsStack()
    }
    
    private func setProfileInfoTextViews() {
        profileInfoStackView.addArrangedSubview(firstNameTextView)
        profileInfoStackView.addArrangedSubview(lastNameTextView)
        profileInfoStackView.addArrangedSubview(bioTextView)
        profileInfoStackView.addArrangedSubview(emailTextView)
    }
    
    private func setActionsStack() {
        actionsStackView.addArrangedSubview(changePasswordButton)
        actionsStackView.addArrangedSubview(reportBugButton)
    }
}

extension EditProfileViewController {
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        title = "Edit Profile"

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
        
        view.addSubview(addCoverPhotoInfoView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: addCoverPhotoInfoView.bottomAnchor, constant: 46),
            addCoverPhotoInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(profileInfoStackView)
        NSLayoutConstraint.activate([
            profileInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileInfoStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Constants.customLargeSpacing)
        ])
        
        view.addSubview(actionsStackView)
        NSLayoutConstraint.activate([
            actionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionsStackView.topAnchor.constraint(equalTo: profileInfoStackView.bottomAnchor, constant: Constants.customLargeSpacing)
        ])
    }
}

fileprivate extension EditProfileViewController {
    static func createCoverPhotoInfo() -> UIView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        
        
        let infoLabel: UILabel = {
            let label = UILabel()
            //TODO: (change dummy email)
            label.text = "Add Cover Photo"
            label.font = UIFont.Habitude.paragraphSmall
            label.textColor = UIColor.Habitute.primaryLight
            return label
        }()
        let image = UIImageView(image: Images.plusWithBorder.image)
        image.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(infoLabel)
        return stack
    }
}

