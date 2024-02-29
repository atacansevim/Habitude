//
//  HomeViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

protocol HomeViewModelContracts {
    var title: String { get }
    var userName: String? { get set }
    var delegate: HomeViewModelDelegate? { get set }
    var habits: [Habit] { get set }
    var habitManager: HabitManagerContract { get set }
    
    func goToAddHabit()
    func goToUpdateHabit(for habit: Habit)
    func loadData()
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: HomeViewModelOutput)
}

enum HomeViewModelOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case goToAddHabit
    case goToUpdateHabit(habit: Habit)
}

enum ListState: Equatable {
    case loading, refreshing, finished(Outcome)
}

enum Outcome: Equatable {
    case data, empty, failed
}
