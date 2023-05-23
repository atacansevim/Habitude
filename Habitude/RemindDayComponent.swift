//
//  RemindDayComponent.swift
//  Habitude
//
//  Created by Atacan Sevim on 16.05.2023.
//

import Foundation
import UIKit

protocol RemindDayDelegate: AnyObject {
    func stateChange()
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
    
    weak var delegate: RemindDayDelegate?
    
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
    
    public func getEnabeledIndexs() -> [Int] {
        var indexArray = [Int]()
        for (index, element) in isEnabled.enumerated() {
            if element {
                indexArray.append(index)
            }
        }
        return indexArray
    }
}

//MARK: -Actions

extension RemindDayComponent {
    
    @objc private func clickAction(_ sender: UIButton!) {
       if isEnabled[sender.tag] {
            sender.backgroundColor = UIColor.Habitute.secondaryLight
            isEnabled[sender.tag] = false
        } else {
            sender.backgroundColor = UIColor.Habitute.accent
            isEnabled[sender.tag] = true
        }
        delegate?.stateChange()
    }
    
    @objc private func switchAction(_ sender: UISwitch!) {
        if sender.isOn {
            setAllButton(for: true)
        } else {
            setAllButton(for: false)
        }
        delegate?.stateChange()
    }
    
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
}
