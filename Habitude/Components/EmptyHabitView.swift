//
//  EmptyHabitView.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//

import Foundation
import UIKit

final class EmptyHabitView: UIView {
   
    // MARK: -Constants
    
    private enum Constants {
        static let title = "Add your first habit"
        static let description = "Click on create habit button!"
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
        label.text = Constants.title
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphExtraSmall
        label.textColor = UIColor.Habitute.primaryLightHalfAlpha
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.description
        label.textAlignment = .left
        return label
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

// MARK: - Setup Methods

extension EmptyHabitView {
    
    private func style() {
        backgroundColor = UIColor.Habitute.secondaryDark
        
        clipsToBounds = true
        layer.cornerRadius = 20
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
        ])
    }
  
}
