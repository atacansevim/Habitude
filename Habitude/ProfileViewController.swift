//
//  ProfileViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
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
        static let emailSpacing: CGFloat = 58
        static let nameSpacing: CGFloat = 30
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
        stack.alignment = .center
        return stack
    }()
    
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
        imageView.clipsToBounds = true
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
        viewModel.loadData()
        nameLabel.isHidden = true
        bioLabel.isHidden = true
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
            contentStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: Constants.emailSpacing),
            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.spacing)
        ])
        
        headerImageView.addSubview(profileImageView)
        
        constraints.append(contentsOf: [
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -Constants.profileImageSize / 2)
        ])
        
        contentStackView.addArrangedSubview(emailLabel)
        contentStackView.setCustomSpacing(Constants.nameSpacing, after: emailLabel)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.setCustomSpacing(Constants.smallSpacing, after: bioLabel)
        contentStackView.addArrangedSubview(bioLabel)
        contentStackView.setCustomSpacing(Constants.customLargeSpacing, after: bioLabel)
        contentStackView.addArrangedSubview(actionsStackView)
        
        NSLayoutConstraint.activate(constraints)
        
    }
}


// MARK: -HandleViewOutput

extension ProfileViewController: ProfileViewModelDelegate {
    
    func handleViewOutput(_ output: ProfileViewModelOutput) {
        switch output {
        case .setLoading(let show):
            setActivityIndicator(for: show)
        case .goToEditProfile:
            self.navigationItem.removeBackBarButtonTitle()
            self.show(
                EditProfileViewController(
                    viewModel: EditProfileViewModel(
                        profileManager: ProfileManager(),
                        profile: viewModel.profile,
                        profilePhoto: profileImageView.image
                    )
                ), sender: nil)
        case .setState(let state):
            switch state {
            case .loading:
                break
            case .refreshing:
                break
            case .finished(let outcome):
                switch outcome {
                case .data:
                    setPersonalInformation()
                default:
                    break
                }
            }
        case .setProfilePhoto(let profilePhoto):
            profileImageView.image = profilePhoto
        }
    }
}

extension ProfileViewController {
    
    func setPersonalInformation() {
        let userEmail = String.getUserEmail()
        
        if userEmail != "" {
            emailLabel.text = userEmail
        }
        
        if viewModel.profile?.name != "" || viewModel.profile?.surname != "" {
            nameLabel.text = viewModel.profile?.fullName
            nameLabel.isHidden = false
        }
            
        if viewModel.profile?.bio != "" {
            bioLabel.text = viewModel.profile?.bio
            bioLabel.isHidden = false
        }
    }
}
