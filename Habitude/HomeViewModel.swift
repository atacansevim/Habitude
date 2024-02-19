//
//  HomeViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

final class HomeViewModel: HomeViewModelContracts {
    // MARK: -Properties
    
    var title: String = "Home"
    private var email: String
    weak var delegate: HomeViewModelDelegate?
    var habits: [Habit] = []
    
    // MARK: - init
    
    init(title: String, email: String) {
        self.title = title
        self.email = email
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
        HabitManager.shared.getHabits { [weak self] result in
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
