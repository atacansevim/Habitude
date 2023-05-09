//
//  AddHabitViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let smallSpacing: CGFloat = 5
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 32
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
        static let addButtonTitle: String = "Add a habit"
        static let titlePlaceHolder: String = "name"
        static let descriptionPlaceHolder: String = "description"
        static let descriptionHeightAnchor: CGFloat = 100
    }
    
    // MARK: -Properties
    
    private let titleTextView = HabitudeTextField(placeHolder: Constants.titlePlaceHolder)
    private let descriptionTextView = HabitudeTextField(
        placeHolder: Constants.descriptionPlaceHolder,
        height: Constants.descriptionHeightAnchor
    )
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    private let addHabitButton = HabitudeCornerButton(title: Constants.addButtonTitle)
    
    private var viewModel: HomeViewModelContracts!
    
    convenience init(viewModel: HomeViewModelContracts){
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        navigationController?.navigationBar.barTintColor = .clear
    }

}

extension AddHabitViewController {
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        title = viewModel.title
    }
    
    func layout() {
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            view.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: Constants.spacing),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.customSpacing),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.customSpacing)
        ])
        
        contentStackView.addArrangedSubview(titleTextView)
        contentStackView.addArrangedSubview(descriptionTextView)
    }
}


// MARK: -HandleViewOutput
