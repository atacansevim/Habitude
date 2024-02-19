//
//  HomeViewController.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import UIKit

final class HomeViewController: BaseViewController {
    
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
        return stack
    }()
    
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
        stack.spacing = Constants.spacing
        return stack
    }()
    
    private let addHabitButton = HabitudeCornerButton(title: Constants.addButtonTitle)
    private var viewModel: HomeViewModelContracts!
    
    // MARK: -init
    
    convenience init(viewModel: HomeViewModelContracts){
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
        addHabitButton.addTarget(self, action: #selector(addHabitAction), for: .touchUpInside)
        emptyHabitView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(addHabitAction))
        )
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        viewModel.loadData()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}

// MARK: -Setup Functions

extension HomeViewController {
    
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
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: Constants.spacing)
        ])
    
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.setCustomSpacing(Constants.smallSpacing, after: nameLabel)
        contentStackView.addArrangedSubview(welcomingLabel)
        contentStackView.setCustomSpacing(Constants.customSpacing, after: welcomingLabel)
        contentStackView.addArrangedSubview(habitsStackView)
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: -Helper Functions

extension HomeViewController {
    
    private func setActionsStack(for outcome: Outcome) {
        switch outcome {
        case .data:
            for (index, habit) in viewModel.habits.enumerated() {
                let habitView = HabitView(habit: habit)
                habitView.tag = index
                habitView.addGestureRecognizer(
                    UITapGestureRecognizer(target: self, action: #selector(updateHabitAction))
                )
                habitsStackView.addArrangedSubview(habitView)
            }
            habitsStackView.addArrangedSubview(addHabitButton)
        case .empty:
            habitsStackView.addArrangedSubview(emptyHabitView)
            habitsStackView.setCustomSpacing(Constants.customSpacing, after: emptyHabitView)
            habitsStackView.addArrangedSubview(addHabitButton)
        case .failed:
            break
        }
    }
    
    private func removeHabitStackViewSubViews() {
        for subView in habitsStackView.arrangedSubviews {
            habitsStackView.removeArrangedSubview(subView)
        }
    }
}

// MARK: -Actions

extension HomeViewController {
    
    @objc private func addHabitAction(sender: UITapGestureRecognizer) {
        viewModel.goToAddHabit()
    }
    
    @objc private func updateHabitAction(sender: UITapGestureRecognizer) {
        if let tappedView = sender.view as? HabitView {
            viewModel.goToUpdateHabit(for: tappedView.habit)
        }
    }
}

// MARK: -HandleViewOutput

extension HomeViewController: HomeViewModelDelegate {
    
    func handleViewOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .setLoading(let flag):
            setActivityIndicator(for: flag)
        case .goToAddHabit:
            self.navigationItem.removeBackBarButtonTitle()
            self.show(AddHabitViewController(
                viewModel: AddHabitViewModel(
                    habitManager: HabitManager()
                )
            ), sender: nil)
        case .setState(state: let state):
            switch state {
            case .loading:
                break
            case .refreshing:
                break
            case .finished(let outcome):
                setActionsStack(for: outcome)
            }
        case .goToUpdateHabit(let habit):
            self.navigationItem.removeBackBarButtonTitle()
            self.show(AddHabitViewController(
                viewModel: AddHabitViewModel(
                    habit: habit,
                    habitManager: HabitManager()
                )
            ), sender: nil)
        }
    }
}

