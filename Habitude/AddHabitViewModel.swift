//
//  AddHabitViewModel.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import Foundation

// MARK: -Constants

private enum Constants {
    static let titleForAdd = "Add a Habit"
    static let titleForUpdate = "Edit the Habit"
}

final class AddHabitViewModel: AddHabitViewModelContracts {
    
    // MARK: -Properties
    
    var habitDescription: String?
    var habitHour: String = ""
    var habitMinute: String = ""
    var habitDays: [Int] = []
    var title: String
    var habitTitle: String = ""{
        didSet {
            delegate?.handleViewOutput(.setButtonEnabled(isButtonEnabled))
        }
    }
    var habit: Habit? {
        didSet {
            guard let habit else {
                return
            }
            habitIds = habit.days.values.map({ id in
                String(id)
            })
        }
    }
    
    private var habitIds:[String] = []
    
    var habitManager: HabitManagerContract
    weak var delegate: AddHabitViewModelDelegate?
    
    // MARK: -ComputedProperties
    
    var isButtonEnabled: Bool {
        return !habitTitle.isEmpty && !habitHour.isEmpty && !habitMinute.isEmpty && !habitDays.isEmpty
    }
    
    var habitKey: String? {
        habit?.createdDate.toString()
    }
    
    // MARK: -init
    
    init(habit: Habit? = nil, habitManager: HabitManagerContract) {
        self.habit = habit
        self.habitManager = habitManager
        title = habit == nil ? Constants.titleForAdd : Constants.titleForUpdate
    }
}

// MARK: -Helper Functions

extension AddHabitViewModel {
    
    func splitTime(_ timeString: String) {
        let components = timeString.components(separatedBy: ":")
        habitHour = components[0]
        habitMinute = components[1]
        delegate?.handleViewOutput(.setButtonEnabled(isButtonEnabled))
    }
    
    func setHabitDays(_ habitDays: [Int]) {
        self.habitDays = habitDays
        delegate?.handleViewOutput(.setButtonEnabled(isButtonEnabled))
    }
    
    func setHabitForUpdate() {
        guard let habit else {
            return
        }
        habitTitle = habit.title
        habitDescription = habit.description
        habitHour = String(habit.hour)
        habitMinute = String(habit.minute)
        habitDays = habit.days.keys.map({ hour in
            Int(hour) ?? 0
        })
        delegate?.handleViewOutput(.setState(state: .finished(.data)))
    }
}

// MARK: -Network Functions

extension AddHabitViewModel {
    
    func addHabit() {
        delegate?.handleViewOutput(.setLoading(true))
        NotificationManager.shared.scheduleMultipleNotifications(
            notificationDetails: NotificationDetails(
                title: habitTitle,
                description: habitDescription,
                hour: habitHour,
                minute: habitMinute,
                days: habitDays
            )
        ) { [weak self] result in
            
            guard let self else {
                return
            }
            
            switch result {
            case .success(let ids):
                habitManager.addHabit(
                    documentId: self.getUserEmail(),
                    data: self.createHabitMap(ids: ids),
                    key: habitKey
                ) { [weak self] error in
                    self?.delegate?.handleViewOutput(.setLoading(false))
                    
                    if let error {
                        self?.delegate?.handleViewOutput(.showError(error.localizedDescription))
                    } else {
                        self?.delegate?.handleViewOutput(.backToHomePage)
                    }
                }
            case .failure(let failure):
                self.delegate?.handleViewOutput(.setLoading(false))
                self.delegate?.handleViewOutput(.showError(failure.localizedDescription))
            }
        }
    }
    
    func updateHabit() {
        delegate?.handleViewOutput(.setLoading(true))
        NotificationManager.shared.cancelNotification(identifier: habitIds)
        habitManager.addHabit(
            documentId: self.getUserEmail(),
            data: self.createHabitMap(ids: [:]),
            key: habitKey
        ) { [weak self] error in
            guard let self else {
                return
            }
            self.delegate?.handleViewOutput(.setLoading(false))
            if let error {
                self.delegate?.handleViewOutput(.showError(error.localizedDescription))
            } else {
                self.addHabit()
            }
        }
    }
}

// MARK: -Private Functions

extension AddHabitViewModel {
    
    private func createHabitMap(ids: [String: String]) -> [String: Any] {
        var habitMap:[String:Any] = [:]
        habitMap["hour"] = habitHour
        habitMap["minute"] = habitMinute
        habitMap["title"] = habitTitle
        habitMap["description"] = habitDescription
        habitMap["days"] = ids
        return habitMap
    }
    
    private func getUserEmail() -> String {
        let email:String? = KeychainManager.shared.getData(forKey: "userEmail")
        
        if let email {
            return email
        } else {
            return ""
        }
    }
}
