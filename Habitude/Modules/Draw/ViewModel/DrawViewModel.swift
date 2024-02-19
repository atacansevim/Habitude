//
//  DrawViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 17.05.2023.
//

final class DrawViewModel: DrawViewModelContracts {
    // MARK: -Properties
    
    var title: String
    var userName: String = "Beka"
    weak var delegate: DrawViewModelDelegate?
    
    // MARK: - init
    
    init(title: String = "Done & Undone") {
        self.title = title
    }
}

extension DrawViewModel {

    func goToAddHabit() {
        delegate?.handleViewOutput(.goToAddHabit)
    }
    
    func loadData() {
        delegate?.handleViewOutput(.setState(state: .finished(.empty)))
    }
}
