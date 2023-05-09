//
//  HomeViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: -Constants
    
    private enum Constants {
        static let smallSpacing: CGFloat = 5
        static let spacing: CGFloat = 20
        static let customSpacing: CGFloat = 30
        static let customLargeSpacing: CGFloat = 60
        static let stackSpacing: CGFloat = 20
        static let addButtonTitle: String = "Add a habit"
        static let welcomText: String = "Welcome!"
    }
    
    // MARK: -Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphRegular
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        //TODO: (change dummy name)
        label.text = "Hi Beka"
        return label
    }()
    
    private let welcomingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleLarge
        label.textColor = UIColor.Habitute.primaryLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.welcomText
        return label
    }()
    
    private let emptyHabitView: EmptyHabitView = {
        let emptyView = EmptyHabitView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    private let habitsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let addHabitButton = HabitudeCornerButton(title: Constants.addButtonTitle)
    
    private var viewModel: HomeViewModelContracts!
    
    convenience init(viewModel: HomeViewModelContracts){
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
        addHabitButton.addTarget(self, action: #selector(addHabitAction), for: .touchUpInside)
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        viewModel.loadData()
        navigationController?.navigationBar.barTintColor = .clear
    }
    
    private func setActionsStack(for outcome: Outcome) {
        switch outcome {
        case .data:
            break
        case .empty:
            habitsStackView.addArrangedSubview(emptyHabitView)
            habitsStackView.setCustomSpacing(Constants.customSpacing, after: emptyHabitView)
            habitsStackView.addArrangedSubview(addHabitButton)
        case .failed:
            break
        }
    }
}

extension HomeViewController {
    func style() {
        //TODO: (could be unneccesary)
        view.backgroundColor = UIColor.Habitute.primaryDark
        title = viewModel.title
    }
    
    func layout(for outcome: Outcome) {
        
        switch outcome {
        case .data:
            break
        case .empty:
            view.addSubview(nameLabel)
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
                nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
                nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            view.addSubview(welcomingLabel)
            NSLayoutConstraint.activate([
                welcomingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
                welcomingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.smallSpacing),
                welcomingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            view.addSubview(habitsStackView)
            NSLayoutConstraint.activate([
                habitsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
                view.trailingAnchor.constraint(equalTo: habitsStackView.trailingAnchor, constant:  Constants.spacing),
                habitsStackView.topAnchor.constraint(equalTo: welcomingLabel.bottomAnchor, constant: Constants.customSpacing)
            ])
        case .failed:
            break
        }
    }
    
    @objc private func addHabitAction(sender: UIButton!) {
        viewModel.goToAddHabit()
    }
}


// MARK: -HandleViewOutput

extension HomeViewController: HomeViewModelDelegate {
    func handleViewOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .setLoading(_): break
        case .goToAddHabit:
            self.navigationItem.removeBackBarButtonTitle()
            self.show(AddHabitViewController(viewModel: HomeViewModel(title: "Habit Details")), sender: nil)
        case .setState(state: let state):
            switch state {
            case .loading:
                break
            case .refreshing:
                break
            case .finished(let outcome):
                layout(for: outcome)
                setActionsStack(for: outcome)
            }
        }
    }
}

