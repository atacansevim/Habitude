//
//  EditProfileViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import UIKit

final class EditProfileViewController: BaseViewController {
    
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
        static let namePlaceHolder: String = "Add First Name"
        static let surnamePlaceHolder: String = "Add Surname"
        static let bioPlaceHolder: String = "Add Bio"
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
        imageView.clipsToBounds = true
        
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
        stack.spacing = Constants.stackSpacing * 2
        return stack
    }()
    
    private let firstNameTextField = HabitudeProfileTextField(placeHolder: Constants.namePlaceHolder)
    private let lastNameTextField = HabitudeProfileTextField(placeHolder: Constants.surnamePlaceHolder)
    private let bioTextField = HabitudeProfileTextField(placeHolder: Constants.bioPlaceHolder)

    private let imagePicker = UIImagePickerController()
    private var viewModel: EditProfileViewModelContract!
    
    // MARK: -init
    
    convenience init(viewModel: EditProfileViewModelContract) {
        self.init()
        self.viewModel = viewModel
        viewModel.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let profilePhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        profileImageView.addGestureRecognizer(profilePhotoTapGesture)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.zPosition = 1
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        navigationController?.navigationBar.barTintColor = .clear
        setProfileInfoTextViews()
        setDelegates()
        viewModel.setProfileData()
    }
}

// MARK: -Setup Fucntions

extension EditProfileViewController {
    
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.rightBarButtonItem = BackBarButtonItem(title: "Done", style: .done, target: self, action: #selector(uploadData))
        title = "Edit Profile"
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
        contentView.addSubview(profileImageView)
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
            contentStackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 140),
            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.spacing)
        ])
        
        constraints.append(contentsOf: [
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageSize),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -Constants.profileImageSize / 2)
        ])
        
        contentStackView.addArrangedSubview(profileInfoStackView)
        
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: -Functions

extension EditProfileViewController {
    
    func setDelegates() {
        firstNameTextField.handleViewOutput = self
        lastNameTextField.handleViewOutput = self
        bioTextField.handleViewOutput = self
    }
    
    private func setProfileInfoTextViews() {
        profileInfoStackView.addArrangedSubview(firstNameTextField)
        profileInfoStackView.addArrangedSubview(lastNameTextField)
        profileInfoStackView.addArrangedSubview(bioTextField)
    }
    
    func setPersonalInformation() {
        if viewModel.name.safelyUnwrapped() != "" {
            firstNameTextField.setText(viewModel.name)
        }
        
        if viewModel.surname.safelyUnwrapped() != "" {
            lastNameTextField.setText(viewModel.surname)
        }
            
        if viewModel.bio.safelyUnwrapped() != "" {
            bioTextField.setText(viewModel.bio)
        }
    }
}

//MARK: -ImagePickerDelegates

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            viewModel.uploadProfilePhoto(pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: -Image Select Functions

extension EditProfileViewController {
    
    @objc private func selectPhoto() {
        let alert = UIAlertController(title: "Choose Profile Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: -TextFieldDelegate

extension EditProfileViewController: HabitudeProfileTextFieldDelegate {
    
    func sendText(text: String, placeHolder: String) {
        if placeHolder == Constants.namePlaceHolder {
            viewModel.name = text
        } else if placeHolder == Constants.surnamePlaceHolder {
            viewModel.surname = text
        } else if placeHolder == Constants.bioPlaceHolder {
            viewModel.bio = text
        }
    }
}

// MARK: -HandleViewOutput

extension EditProfileViewController: EditProfileViewModelDelegate {
    
    func handleViewOutput(_ output: EditProfileViewModelOutput) {
        switch output {
        case .setLoading(let show):
            setActivityIndicator(for: show)
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
                case .empty:
                    break
                case .failed:
                    break
                }
            }
        case .setProfilePhoto(let image):
            profileImageView.subviews.first?.isHidden = true
            profileImageView.image = image
        case .backToProfile:
            navigationController?.popViewController(animated: true)
        case .setProfileData:
            setPersonalInformation()
        case .showAlert:
            showAlert()
        }
    }
}

// MARK: -Actions

extension EditProfileViewController {
    
    @objc func uploadData() {
        viewModel.uploadData()
    }
}

