//
//  HabituteSharpButton.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import Foundation
import UIKit

class HabitudeSharpButton: UIButton {
    
    // MARK: - Properties
    
    private let title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView(image: Images.profileUnselected.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView(image: Images.arrow.image)
         imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
     }()
    
    override var isEnabled: Bool {
          didSet {
              if isEnabled {
                  self.title.textColor = UIColor.Habitute.primaryDark
                  self.backgroundColor = UIColor.Habitute.accent
                  self.leftImageView.image?.withTintColor(UIColor.Habitute.accent)
                  self.rightImageView.image?.withTintColor(UIColor.Habitute.accent, renderingMode: .alwaysTemplate)
              } else {
                  self.title.textColor = UIColor.Habitute.primaryLight
                  self.backgroundColor = UIColor.Habitute.secondaryDark
                  self.leftImageView.image?.withTintColor(UIColor.Habitute.primaryLight)
                  self.rightImageView.image?.withTintColor(UIColor.Habitute.primaryLight, renderingMode: .alwaysTemplate)
              }
          }
      }
    
    // MARK: - init
    
    init(title: String, icon: UIImage = Images.profileUnselected.image) {
        super.init(frame: .zero)
        self.title.text = title
        self.leftImageView.image = icon
        style()
        layout()
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

// MARK: -  Setup Methods

extension HabitudeSharpButton {
    
    private func layout() {
        addSubview(title)
        addSubview(leftImageView)
        addSubview(rightImageView)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 60),
            widthAnchor.constraint(equalToConstant: 350),
        ])
        
        leftImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 14),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: rightImageView.trailingAnchor, constant: 20),
            rightImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    private func style() {
        self.titleLabel?.font = UIFont.Habitude.titleSmall
        self.backgroundColor = UIColor.Habitute.accent
        self.layer.cornerRadius = 5
        self.title.font = UIFont.Habitude.paragraphRegular
    }
}

