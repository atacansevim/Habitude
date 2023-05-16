//
//  AddHabitViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

final class AddHabitViewController: UIViewController {
    //TODO: (add a scrol View for small scree)
    
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
        static let timeSelectionLabel: String = "Select time for a reminder"
        static let descriptionHeightAnchor: CGFloat = 100
    }
    
    // MARK: -Properties
    
    private let titleTextView = HabitudeTextField(placeHolder: Constants.titlePlaceHolder)
    private let descriptionTextView = HabitudeTextField(
        placeHolder: Constants.descriptionPlaceHolder,
        height: Constants.descriptionHeightAnchor
    )
    private let remindDay: RemindDayComponent = RemindDayComponent()
    
    private let timeSelectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleMedium
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        //TODO: (change dummy name)
        label.text = Constants.timeSelectionLabel
        return label
    }()
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        let loc = Locale(identifier: "en")
        picker.locale = loc
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.setValue(UIColor.Habitute.accent, forKeyPath: "textColor")
        return picker
    }()
    
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
        self.navigationItem.rightBarButtonItem = BackBarButtonItem(title: "clear", style: .done, target: self, action: #selector(backAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        contentStackView.addArrangedSubview(remindDay)
        contentStackView.addArrangedSubview(timeSelectionLabel)
        contentStackView.addArrangedSubview(timePicker)
        contentStackView.addArrangedSubview(addHabitButton)
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
       //TODO: (will implemented)
    }
}


// MARK: -HandleViewOutput
