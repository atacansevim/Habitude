//
//  AddHabitViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

final class AddHabitViewModel: AddHabitViewModelContracts {
  
    // MARK: -Properties
    var title = "Habit Details"
    weak var delegate: AddHabitViewModelDelegate?
    var notificationManager = NotificationManager()
    private var titleOfHabit: String?
    private var descripition: String?
    
    // MARK: - init
    
    init(title: String) {
        self.title = title
        notificationManager.delegate = self
    }
}

extension AddHabitViewModel {
    
    func setNotification(title: String, body:String? = nil, day: Int, hour: Int, minute: Int) {
        self.titleOfHabit = title
        self.descripition = body
        notificationManager.createPush(title: title,body: body, day: day, hour: hour, minute: minute)
    }
}

extension AddHabitViewModel: NotificationManagerDelegate {
    func result(error: Error?) {
        guard let error = error else {
            delegate?.handleViewOutput(.goToHabitList(self.titleOfHabit ?? "", self.descripition ?? ""))
            return
        }
        
        delegate?.handleViewOutput(.showError(error))
    }
}

