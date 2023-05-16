//
//  HabitudeProfileTextView.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import Foundation
import UIKit

final class HabitudeProfileTextView: UITextView {
    
    private let placeHolder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Habitude.paragraphRegular
        label.textColor = UIColor.Habitute.primaryLightHalfAlpha
       return label
    }()
    
    private let underLine = UIView.separator(width: 350, color: UIColor.Habitute.secondaryLight)
    
    init(placeHolder: String, isInfoShown: Bool = false) {
        super.init(frame: .zero, textContainer: nil)
        self.placeHolder.text = placeHolder
        self.backgroundColor = .clear
        layout()
        style()
    }

    private func layout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            widthAnchor.constraint(equalToConstant: 350)
        ])
        
        addSubview(placeHolder)
        NSLayoutConstraint.activate([
            placeHolder.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeHolder.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        addSubview(underLine)
        NSLayoutConstraint.activate([
            underLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLine.topAnchor.constraint(equalToSystemSpacingBelow: placeHolder.bottomAnchor, multiplier: 1)
        ])
    }
    
    private func style() {
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}
