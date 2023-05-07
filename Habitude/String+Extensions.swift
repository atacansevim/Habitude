//
//  String+Extensions.swift
//  Habitude
//
//  Created by Atacan Sevim on 26.04.2023.
//

import Foundation

public extension String {
    
  func indexInt(of char: Character) -> Int? {
    return firstIndex(of: char)?.utf16Offset(in: self)
  }
}
