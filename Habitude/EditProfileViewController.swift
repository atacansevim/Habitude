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
    
    private let scrollView = UIScrollView()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addCoverPhotoInfoView = EditProfileViewController.createCoverPhotoInfo()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: Images.profileHeader.image)
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
        scrollView.contentInsetAdjustmentBehavior = .never
        var constraints: [NSLayoutConstraint] = []
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        constraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        contentView.addSubview(headerImageView)
        constraints.append(contentsOf: [
            headerImageView.heightAnchor.constraint(equalToConstant: Constants.headerImageHeight),
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.addSubview(contentStackView)
        constraints.append(contentsOf: [
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            contentView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: Constants.spacing),
            contentStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 70),
            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.spacing)
        ])
        
        headerImageView.addSubview(profileImageView)
        headerImageView.addSubview(addCoverPhotoInfoView)
        
        constraints.append(contentsOf: [
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -Constants.profileImageSize / 2)
        ])
        
        constraints.append(contentsOf: [
            profileImageView.topAnchor.constraint(equalTo: addCoverPhotoInfoView.bottomAnchor, constant: 46),
            addCoverPhotoInfoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        contentStackView.addArrangedSubview(profileInfoStackView)
        contentStackView.setCustomSpacing(43, after: profileInfoStackView)
        contentStackView.addArrangedSubview(actionsStackView)
        
        NSLayoutConstraint.activate(constraints)
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
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(infoLabel)
        return stack
    }
}

