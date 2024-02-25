//
//  AddHabitViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

protocol AddHabitViewControllerDelegate: AnyObject {
    func dismiss(habits: [Habit])
}

final class AddHabitViewController: BaseViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let smallSpacing: CGFloat = 5
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 32
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
        static let addButtonTitle: String = "Add a habit"
        static let editTitleForButton: String = "Save"
        static let titlePlaceHolder: String = "Title"
        static let descriptionPlaceHolder: String = "Description"
        static let timeSelectionLabel: String = "Select time for a reminder"
        static let descriptionHeightAnchor: CGFloat = 100
        static let timeFormat: String = "HH:mm"
        static let deleteButtonTitle: String = "Delete"
        static let deleteMessage: String = "Are you sure?"
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
    
    private let titleTextField = HabitudeTextField(
        placeHolder: Constants.titlePlaceHolder,
        holderFont: UIFont.Habitude.titleMedium,
        placeHolderColor: UIColor.Habitute.primaryLight
    )
    
    private let descriptionTextField = HabitudeTextField(
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
        picker.preferredDatePickerStyle = .wheels
        picker.setValue(UIColor.Habitute.accent, forKeyPath: "textColor")
        return picker
    }()
    
    private let addHabitButton = HabitudeCornerButton(title: Constants.addButtonTitle)
    private var viewModel: AddHabitViewModelContracts!
    weak var delegate: AddHabitViewControllerDelegate?
    
    // MARK: -init
    
    convenience init(viewModel: AddHabitViewModelContracts){
        self.init()
        self.viewModel = viewModel
        remindDay.delegate = self
        self.viewModel.delegate = self
        titleTextField.handleViewOutput = self
        descriptionTextField.handleViewOutput = self
        timePicker.addTarget(
            self,
            action: #selector(datePickerValueChanged(_:)),
            for: .valueChanged
        )
        addHabitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
        if viewModel.isDeleteButtonEnabled {
            self.navigationItem.rightBarButtonItem = BackBarButtonItem(
                title: Constants.deleteButtonTitle,
                style: .done,
                target: self,
                action: #selector(deleteAction)
            )
        }
        viewModel.setHabitForUpdate()
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

// MARK: -Setup Functions

extension AddHabitViewController {
    
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        title = viewModel.title
        addHabitButton.isEnabled = false
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
        
        contentStackView.addArrangedSubview(titleTextField)
        contentStackView.addArrangedSubview(descriptionTextField)
        contentStackView.addArrangedSubview(remindDay)
        contentStackView.addArrangedSubview(timeSelectionLabel)
        contentStackView.addArrangedSubview(timePicker)
        contentStackView.addArrangedSubview(addHabitButton)
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: -PrivateFunctions

extension AddHabitViewController {
    
    private func setForUpdate() {
        titleTextField.setText(viewModel.habitTitle)
        if let description = viewModel.habitDescription {
            descriptionTextField.setText(description)
        }
        remindDay.setForUpdate(days: viewModel.habitDays)
        setTimeForDatePicker()
        addHabitButton.setTitle(to: Constants.editTitleForButton)
    }
    
    private func setTimeForDatePicker() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = Int(viewModel.habitHour)
        dateComponents.minute = Int(viewModel.habitMinute)

        if let selectedDate = calendar.date(from: dateComponents) {
            timePicker.setDate(selectedDate, animated: true)
        }
    }
}

// MARK: -Delegates

extension AddHabitViewController: RemindDayComponentDelegate {
    
    func selectedDates(selectedDays: [Int]) {
        viewModel.setHabitDays(selectedDays)
    }
}

extension AddHabitViewController: HabitudeTextFieldDelegate {
    
    func sendText(text: String, placeHolder: String) {
        if placeHolder == Constants.titlePlaceHolder {
            if viewModel.habitTitle != text {
                viewModel.habitTitle = text
            }
        } else if placeHolder == Constants.descriptionPlaceHolder {
            viewModel.habitDescription = text
        }
    }
}

// MARK: -HandleViewOutput

extension AddHabitViewController: AddHabitViewModelDelegate {
    
    func handleViewOutput(_ output: AddHabitViewModelOutput) {
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
                case .empty:
                    addHabitButton.isEnabled = false
                case .data:
                    setForUpdate()
                default:
                    break
                }
            }
        case .setButtonEnabled(let isEnabled):
            addHabitButton.isEnabled = isEnabled
        case .backToHomePage(let habits):
            self.delegate?.dismiss(habits: habits)
            navigationController?.popViewController(animated: true)
        case .showError(let errorMessage):
            showAlert(message: errorMessage)
        }
    }
}

// MARK: -Actions

extension AddHabitViewController {
    
    @objc private func deleteAction(sender: UIBarButtonItem) {
        showAlert(
            title: Constants.deleteButtonTitle,
            message: Constants.deleteMessage,
            positiveAlertMessage: Constants.deleteButtonTitle,
            positiveAlertAction: { [weak self] _ in
                self?.viewModel.deleteHabit()
            },
            negativeAlertAction: { _ in }
        )
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.timeFormat
        let time = formatter.string(from: sender.date)
        viewModel.splitTime(time)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        if viewModel.habit != nil {
            viewModel.updateHabit()
        } else {
            viewModel.addHabit()
        }
    }
}
