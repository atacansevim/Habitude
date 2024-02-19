//
//  AddHabitViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import Foundation

typealias CompletionHandler = (Bool) -> Void

protocol AddHabitViewModelContracts {
    
    var title: String { get }
    var habitTitle: String { get set }
    var habitDescription: String? { get set }
    var habitHour: String { get set }
    var habitMinute: String { get set }
    var habitDays: [Int] { get set }
    var isButtonEnabled: Bool { get }
    var habit:Habit? { get set }
    
    var delegate: AddHabitViewModelDelegate? { get set }

    func splitTime(_ timeString: String)
    func setHabitDays(_ habitDays: [Int])
    func addHabit()
    func updateHabit()
    func setHabitForUpdate()
}

protocol AddHabitViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: AddHabitViewModelOutput)
}

enum AddHabitViewModelOutput: Equatable {
    case setLoading(Bool)
    case setState(state: ListState)
    case setButtonEnabled(Bool)
    case backToHomePage
    case showError(String)
}
