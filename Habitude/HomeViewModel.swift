//
//  HomeViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

final class HomeViewModel: HomeViewModelContracts {

    // MARK: -Properties
    
    var title: String = "Home"
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - init
    
    init(title: String) {
        self.title = title
    }
}

extension HomeViewModel {

    func goToAddHabit() {
        delegate?.handleViewOutput(.goToAddHabit)
    }
    
    func loadData() {
        delegate?.handleViewOutput(.setState(state: .finished(.empty)))
    }
}
