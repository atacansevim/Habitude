//
//  HabitudeCornerButton.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import Foundation
import UIKit

class HabitudeCornerButton: UIButton {
    
    private let title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var width: CGFloat?
    
    override var isEnabled: Bool {
          didSet {
              if isEnabled {
                  self.title.textColor = UIColor.Habitute.primaryDark
                  self.backgroundColor = UIColor.Habitute.accent
              } else {
                  self.title.textColor = UIColor.Habitute.primaryLight
                  self.backgroundColor = UIColor.Habitute.secondaryLight
              }
          }
      }
    
    init(title: String, width: CGFloat = 350) {
        super.init(frame: .zero)
        self.title.text = title
        self.width = width
        style()
        layout()
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 50),
            widthAnchor.constraint(equalToConstant: width!)
        ])
    }
    
    private func style() {
        self.titleLabel?.font = UIFont.Habitude.titleSmall
        self.backgroundColor = UIColor.Habitute.accent
        self.layer.cornerRadius = 20
        self.title.font = UIFont.Habitude.titleSmall
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
    
    func setTitle(to title: String) {
        self.title.text = title
    }
}

