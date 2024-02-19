//
//  RemindDayComponent.swift
//  Habitude
//
//  Created by Atacan Sevim on 16.05.2023.
//

import Foundation
import UIKit

protocol RemindDayComponentDelegate: AnyObject {
    func selectedDates(selectedDays: [Int])
}

final class RemindDayComponent: UIView {
    
    // MARK: -Constants
    
    private enum Constants {
        static let title = "Remind me every day"
        static let description = "Click on create habit button!"
        static let height: CGFloat = 120
        static let stackSpacing: CGFloat = 10
        static let spacing: CGFloat = 20
        static let topSpacing: CGFloat = 15
        static let iconStackViewSpacing: CGFloat = 10
        static let bottomStackViewSpacing: CGFloat = 5
        static let divideHalf: Double = 0.5
        static let buttonWidth: CGFloat = 36
    }
    
    // MARK: -Properties
    
    weak var delegate: RemindDayComponentDelegate?
    private var isEnabled = [Bool](repeatElement(false, count: 7))
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        //TODO: (change dummy email)
        label.text = Constants.title
        label.font = UIFont.Habitude.paragraphSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let switchButton: UISwitch = {
        let button = UISwitch()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isOn = false
        button.tintColor = UIColor.Habitute.accent
        return button
    }()
    
    private let dayButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let mondayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.MONDAY.description, for: .normal)
        button.tag = Days.MONDAY.rawValue
        return button
    }()
    
    private let tuesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.TUESDAY.description, for: .normal)
        button.tag = Days.TUESDAY.rawValue
        return button
    }()
    
    private let wednesdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.WEDNESDAY.description, for: .normal)
        button.tag = Days.WEDNESDAY.rawValue
        return button
    }()
    
    private let thursdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.THURSDAY.description, for: .normal)
        button.tag = Days.THURSDAY.rawValue
        return button
    }()
    
    private let fridayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.FRIDAY.description, for: .normal)
        button.tag = Days.FRIDAY.rawValue
        return button
    }()
    
    private let saturdayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.SATURDAY.description, for: .normal)
        button.tag = Days.SATURDAY.rawValue
        return button
    }()
    
    private let sundayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.divideHalf * Constants.buttonWidth
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.Habitude.paragraphMedium
        button.backgroundColor = UIColor.Habitute.secondaryLight
        button.setTitle(Days.SUNDAY.description, for: .normal)
        button.tag = Days.SUNDAY.rawValue
        return button
    }()
    
    
    //MARK: -init
    
    init() {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

// MARK: -Setup Functions

extension RemindDayComponent {
    
    private func style() {
        backgroundColor = UIColor.Habitute.secondaryDark
        
        clipsToBounds = true
        layer.cornerRadius = 20
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topSpacing)
        ])
        
        addSubview(switchButton)
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: switchButton.trailingAnchor, constant: Constants.spacing),
            switchButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topSpacing)
        ])
        
        addSubview(dayButtonStack)
        dayButtonStack.addArrangedSubview(mondayButton)
        dayButtonStack.addArrangedSubview(tuesdayButton)
        dayButtonStack.addArrangedSubview(wednesdayButton)
        dayButtonStack.addArrangedSubview(thursdayButton)
        dayButtonStack.addArrangedSubview(fridayButton)
        dayButtonStack.addArrangedSubview(saturdayButton)
        dayButtonStack.addArrangedSubview(sundayButton)
        
        NSLayoutConstraint.activate([
            dayButtonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            trailingAnchor.constraint(equalTo: dayButtonStack.trailingAnchor, constant: Constants.spacing),
            bottomAnchor.constraint(equalTo: dayButtonStack.bottomAnchor, constant: Constants.spacing)
        ])
        
        mondayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        tuesdayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        wednesdayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        thursdayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        fridayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        saturdayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        sundayButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(switchAction), for: .allEvents)
    }
}

// MARK: -Helper Functions

extension RemindDayComponent {
    
    func getDaysStackView(days: [Int]) -> UIStackView {
        switchButton.isHidden = true
        titleLabel.isHidden = true
        backgroundColor = .clear
        
        for day in days {
            switch (day+1) {
            case 1:
                mondayButton.backgroundColor = UIColor.Habitute.accent
                mondayButton.isEnabled = false
            case 2:
                tuesdayButton.backgroundColor = UIColor.Habitute.accent
                tuesdayButton.isEnabled = false
            case 3:
                wednesdayButton.backgroundColor = UIColor.Habitute.accent
                wednesdayButton.isEnabled = false
            case 4:
                thursdayButton.backgroundColor = UIColor.Habitute.accent
                thursdayButton.isEnabled = false
            case 5:
                fridayButton.backgroundColor = UIColor.Habitute.accent
                fridayButton.isEnabled = false
            case 6:
                saturdayButton.backgroundColor = UIColor.Habitute.accent
                saturdayButton.isEnabled = false
            case 7:
                sundayButton.backgroundColor = UIColor.Habitute.accent
                sundayButton.isEnabled = false
            default:
                break
            }
        }
        
       return dayButtonStack
    }
    
    func setForUpdate(days: [Int]) {
        if days.count == 7 {
            switchButton.isOn = true
            setAllButton(for: true)
        } else {
            for day in days {
                isEnabled[day] = true
                switch (day) {
                case 0:
                    mondayButton.backgroundColor = UIColor.Habitute.accent
                case 1:
                    tuesdayButton.backgroundColor = UIColor.Habitute.accent
                case 2:
                    wednesdayButton.backgroundColor = UIColor.Habitute.accent
                case 3:
                    thursdayButton.backgroundColor = UIColor.Habitute.accent
                case 4:
                    fridayButton.backgroundColor = UIColor.Habitute.accent
                case 5:
                    saturdayButton.backgroundColor = UIColor.Habitute.accent
                case 6:
                    sundayButton.backgroundColor = UIColor.Habitute.accent
                default:
                    break
                }
            }
        }
    }
}

// MARK: -Actions

extension RemindDayComponent {
    
    @objc private func clickAction(_ sender: UIButton!) {
        if isEnabled[sender.tag] {
            sender.backgroundColor = UIColor.Habitute.secondaryLight
            isEnabled[sender.tag] = false
        } else {
            sender.backgroundColor = UIColor.Habitute.accent
            isEnabled[sender.tag] = true
        }
        delegate?.selectedDates(selectedDays: getDays(isEnabled))
    }
    
    @objc private func switchAction(_ sender: UISwitch!) {
        if sender.isOn {
            setAllButton(for: true)
        } else {
            setAllButton(for: false)
        }
        delegate?.selectedDates(selectedDays: getDays(isEnabled))
    }
}

// MARK: -Private Functions

extension RemindDayComponent {
    
    private func setAllButton(for value: Bool) {
        if !value {
            mondayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            tuesdayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            wednesdayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            thursdayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            fridayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            saturdayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            sundayButton.backgroundColor =  UIColor.Habitute.secondaryLight
            isEnabled = [Bool](repeatElement(false, count: 7))
        } else {
            mondayButton.backgroundColor = UIColor.Habitute.accent
            tuesdayButton.backgroundColor = UIColor.Habitute.accent
            wednesdayButton.backgroundColor = UIColor.Habitute.accent
            thursdayButton.backgroundColor = UIColor.Habitute.accent
            fridayButton.backgroundColor = UIColor.Habitute.accent
            saturdayButton.backgroundColor = UIColor.Habitute.accent
            sundayButton.backgroundColor = UIColor.Habitute.accent
            isEnabled = [Bool](repeatElement(true, count: 7))
        }
    }
    
    private func getDays(_ isEnabled: [Bool]) -> [Int] {
        var result: [Int] = []
        for (index, element) in isEnabled.enumerated() {
            if element {
                result.append(index)
            }
        }
        return result
    }
}
