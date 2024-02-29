//
//  HomeViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

final class HomeViewModel: HomeViewModelContracts {
    
    // MARK: -Constants
    
    private enum Constants {
        static let userNameKeychainKey: String = "userName"
    }
    
    // MARK: -Properties
    
    var title: String = "Home"
    var userName: String?
    private var email: String
    weak var delegate: HomeViewModelDelegate?
    var habits: [Habit] = []
    var habitManager: HabitManagerContract
    
    // MARK: - init
    
    init(title: String, email: String, habitManager: HabitManagerContract) {
        self.title = title
        self.email = email
        self.habitManager = habitManager
        setUserName()
    }
}

extension HomeViewModel {

    func goToAddHabit() {
        delegate?.handleViewOutput(.goToAddHabit)
    }
    
    func goToUpdateHabit(for habit: Habit) {
        delegate?.handleViewOutput(.goToUpdateHabit(habit: habit))
    }
    
    func loadData() {
        delegate?.handleViewOutput(.setLoading(true))
        habitManager.getHabits { [weak self] result in
            guard let self else {
                return
            }
            
            delegate?.handleViewOutput(.setLoading(false))
            switch result {
            case .success(let habits):
                if habits.isEmpty {
                    self.delegate?.handleViewOutput(.setState(state: .finished(.empty)))
                } else {
                    self.habits = habits
                    self.delegate?.handleViewOutput(.setState(state: .finished(.data)))
                }
            case .failure:
                self.delegate?.handleViewOutput(.setState(state: .finished(.failed)))
            }
        }
    }
}

// MARK: -Private Functions

extension HomeViewModel {
    
    private func setUserName() {
        let userName:String? = KeychainManager.shared.getData(forKey: Constants.userNameKeychainKey)
        if let userName {
            self.userName = "Hi \(userName)"
        }
    }
}
