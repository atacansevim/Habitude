//
//  HabitView.swift
//  Habitude
//
//  Created by Atacan Sevim on 15.02.2024.
//

import Foundation
import UIKit

final class HabitView: UIView {
   
    // MARK: -Constants
    
    private enum Constants {
        static let height: CGFloat = 120
        static let stackSpacing: CGFloat = 16
        static let iconStackViewSpacing: CGFloat = 10
        static let bottomStackViewSpacing: CGFloat = 5
    }
    
    // MARK: -Properties
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleMedium
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let dayComponets = RemindDayComponent()
    
    private(set) var habit: Habit
    
    //MARK: -init
    
    init(habit: Habit) {
        self.habit = habit
        super.init(frame: .zero)
        layout()
        style()
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

extension HabitView {
    
    private func style() {
        backgroundColor = UIColor.Habitute.secondaryDark
        
        clipsToBounds = true
        layer.cornerRadius = 20
        titleLabel.text = habit.title
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        let daysStack = dayComponets.getDaysStackView(days: habit.days.keys.map({ value in
            Int(value) ?? 0
        }))
        daysStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        addSubview(daysStack)
        NSLayoutConstraint.activate([
            daysStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            daysStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: daysStack.trailingAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: daysStack.bottomAnchor, constant: 10)
        ])
    }
  
}
