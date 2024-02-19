//
//  KeychainManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 15.02.2024.
//

import KeychainSwift
import Foundation

final class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()

    private init() {}

    func setData<T: Codable>(_ data: T, forKey key: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            keychain.set(encodedData, forKey: key)
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    func getData<T: Codable>(forKey key: String) -> T? {
        if let data = keychain.getData(key) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        return nil
    }
    
    func deleteData(forKey key: String) {
        keychain.delete(key)
    }
}

