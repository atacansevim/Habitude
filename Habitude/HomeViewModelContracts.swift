//
//  HomeViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

protocol HomeViewModelContracts {
    var title: String { get }
    var delegate: HomeViewModelDelegate? { get set }
    
    func goToAddHabit()
    func loadData()
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: HomeViewModelOutput)
}

enum HomeViewModelOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case goToAddHabit
}

enum ListState: Equatable {
    case loading, refreshing, finished(Outcome)
}

enum Outcome: Equatable {
    case data, empty, failed
}
