//
//  DrawViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.05.2023.
//

protocol DrawViewModelContracts {
    var title: String { get }
    var habitKey: String? { get set }
    var userName: String? { get set }
    var delegate: DrawViewModelDelegate? { get set }
    var appDelegate: AppDelegateViewOutput? { get set }
    
    func goToAddHabit()
    func loadData()
    func saveProgress(isSuccess: Bool, completion: @escaping (Error?) -> Void)
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

