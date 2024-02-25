//
//  HabitManagerContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 13.02.2024.
//

protocol HabitManagerContract: AnyObject {
    func addHabit(documentId: String, data: [String: Any], key: String?, completion: @escaping (Error?) -> Void)
    func getHabits(completion: @escaping (Result<[Habit], Error>) -> Void)
    func deleteHabit(documentId: String, key: String, completion: @escaping (Error?) -> Void)
}
