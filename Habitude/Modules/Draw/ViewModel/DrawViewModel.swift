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
    var habitKey: String?
    weak var delegate: DrawViewModelDelegate?
    weak var appDelegate: AppDelegateViewOutput?
    var habitManager: HabitManagerContract
    
    
    // MARK: - init
    
    init(title: String = "Done & Undone", habitManager: HabitManagerContract, habitKey: String? = nil) {
        self.title = title
        self.habitManager = habitManager
        self.habitKey = habitKey
    }
}

extension DrawViewModel {
    
    func goToAddHabit() {
        delegate?.handleViewOutput(.goToAddHabit)
    }
    
    func loadData() {
        delegate?.handleViewOutput(.setState(state: .finished(.empty)))
    }
    
    func saveProgress(isSuccess: Bool, completion: @escaping (Error?) -> Void) {
        guard let habitKey else {
            delegate?.handleViewOutput(.showError(""))
            return
        }
        
        let data = [
            String.currentDate(): isSuccess
        ]
        
        habitManager.saveProgress(data: data, key: habitKey) { error in
            if let error {
                completion(error)
            }
            completion(nil)
        }
    }
}
