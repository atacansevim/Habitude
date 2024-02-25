//
//  HabitManagerContract.swift
//  Habitude
//
//  Created by Atacan Sevim on 13.02.2024.
//

protocol HabitManagerContract: AnyObject {
    func addHabit(data: [String: Any], key: String, completion: @escaping (Error?) -> Void)
    func getHabits(completion: @escaping (Result<[Habit], Error>) -> Void)
    func deleteHabit(key: String, completion: @escaping (Error?) -> Void)
    func saveProgress(data: [String: Any], key: String, completion: @escaping (Error?) -> Void)
}
