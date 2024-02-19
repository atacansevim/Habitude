//
//  DrawViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.05.2023.
//

protocol DrawViewModelContracts {
    var title: String { get }
    var userName: String { get }
    var delegate: DrawViewModelDelegate? { get set }
    
    func goToAddHabit()
    func loadData()
}

protocol DrawViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: DrawViewModelOutput)
}

enum DrawViewModelOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case goToAddHabit
    case showError(String)
}

