//
//  AddHabitViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

final class AddHabitViewController: UIViewController {
    // MARK: -Constants
    
    private enum Constants {
        static let smallSpacing: CGFloat = 5
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 32
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
        static let addButtonTitle: String = "Add a habit"
        static let titlePlaceHolder: String = "Title"
        static let descriptionPlaceHolder: String = "Description"
        static let timeSelectionLabel: String = "Select time for a reminder"
        static let descriptionHeightAnchor: CGFloat = 100
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
    
    private let titleTextView = HabitudeTextField(
        placeHolder: Constants.titlePlaceHolder,
        holderFont: UIFont.Habitude.titleMedium,
        placeHolderColor: UIColor.Habitute.primaryLight
    )
    
    private let descriptionTextView = HabitudeTextField(
        placeHolder: Constants.descriptionPlaceHolder,
        height: Constants.descriptionHeightAnchor,
        holderFont: UIFont.Habitude.paragraphSmall,
        isPlaceHolderUp: true,
        placeHolderColor: UIColor.Habitute.primaryLight
    )
    
    private let remindDay: RemindDayComponent = RemindDayComponent()
    
    private let timeSelectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleMedium
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.timeSelectionLabel
        return label
    }()
    
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.setValue(UIColor.Habitute.accent, forKeyPath: "textColor")
        return picker
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
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
        scrollView.contentInsetAdjustmentBehavior = .never
        var constraints: [NSLayoutConstraint] = []
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        constraints.append(contentsOf: [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        
        contentView.addSubview(contentStackView)
        constraints.append(contentsOf: [
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            contentView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: Constants.spacing),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.spacing)
        ])
        
        contentStackView.addArrangedSubview(titleTextView)
        contentStackView.addArrangedSubview(descriptionTextView)
        contentStackView.addArrangedSubview(remindDay)
        contentStackView.addArrangedSubview(timeSelectionLabel)
        contentStackView.addArrangedSubview(timePicker)
        contentStackView.addArrangedSubview(addHabitButton)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
       //TODO: (will implemented)
    }
}


// MARK: -HandleViewOutput
