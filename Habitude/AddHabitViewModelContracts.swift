//
//  AddHabitViewModelContracts.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

protocol AddHabitViewModelContracts {
    var title: String { get }
    var delegate: AddHabitViewModelDelegate? { get set }
    var notificationManager: NotificationManager { get set }
    
    func setNotification(title: String, body:String?, day: Int, hour: Int, minute: Int)
}

protocol AddHabitViewModelDelegate: AnyObject {
    func handleViewOutput(_ output: AddHabitViewModelOutput)
}

enum AddHabitViewModelOutput: Equatable {
    static func == (lhs: AddHabitViewModelOutput, rhs: AddHabitViewModelOutput) -> Bool {
        return true
    }
    case setLoading(Bool)
    case goToHabitList(String, String?)
    case showError(Error?)
}
