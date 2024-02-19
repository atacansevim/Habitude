//
//  HabitudeTextField.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

import Foundation
import UIKit

final class HabitudeTextField: UIView {
    
    private let placeHolder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Habitude.paragraphSmall
        label.textColor = UIColor.Habitute.primaryLightHalfAlpha
       return label
    }()
    
    private let border : UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.layer.cornerRadius = 10
        border.layer.borderWidth = 2
        border.layer.borderColor = UIColor.Habitute.secondaryLight.cgColor
        return border
     }()
    
    private let textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.Habitude.paragraphSmall
        textField.textColor = UIColor.Habitute.primaryLight
        textField.autocapitalizationType = .none
        textField.backgroundColor = .clear
        return textField
     }()
    
    var text: String {
        textField.text ?? ""
    }
    
    private var holderFont: UIFont?
    private var height: CGFloat = 60
    private var isPlaceHolderUp: Bool?
    private var placeHolderColor: UIColor?
    
    weak var handleViewOutput: HabitudeTextFieldDelegate?
    
    init(
        placeHolder: String,
        height: CGFloat = 60,
        holderFont: UIFont? = nil,
        isPlaceHolderUp: Bool? = nil,
        placeHolderColor: UIColor = UIColor.Habitute.primaryLightHalfAlpha
    ) {
        super.init(frame: .zero)
        self.placeHolder.text = placeHolder
        self.height = height
        self.holderFont = holderFont
        self.isPlaceHolderUp = isPlaceHolderUp
        self.placeHolderColor = placeHolderColor
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        layout()
        style()
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: 350)
        ])
        
        addSubview(border)
        addSubview(placeHolder)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: topAnchor),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.bottomAnchor.constraint(equalTo: bottomAnchor),
            border.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        if let isPlaceHolderUp = isPlaceHolderUp {
            NSLayoutConstraint.activate([
                placeHolder.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
                placeHolder.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
            ])
        } else {
            NSLayoutConstraint.activate([
                placeHolder.centerYAnchor.constraint(equalTo: centerYAnchor),
                placeHolder.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
            ])
        }
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
        ])
        
        textField.layer.zPosition = 1
    }
    
    private func style() {
        if let holderFont = holderFont {
            placeHolder.font = holderFont
        }
        if let placeHolderColor = placeHolderColor {
            placeHolder.textColor = placeHolderColor
        }
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

extension HabitudeTextField: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        placeHolder.isHidden = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeHolder.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text  {
            placeHolder.isHidden = (text.isEmpty && !textField.isFirstResponder) ? false : true
        } else {
            placeHolder.isHidden = false
        }
        
        handleViewOutput?.sendText(text: text, placeHolder: placeHolder.text ?? "")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text  {
            placeHolder.isHidden = (text.isEmpty && !textField.isFirstResponder) ? false : true
        } else {
            placeHolder.isHidden = false
        }
        
        handleViewOutput?.sendText(text: text, placeHolder: placeHolder.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}

// MARK: - Helper Functions

extension HabitudeTextField {
    
    func setKeyboard(with type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func isSecureKeyboard(_ isSecure: Bool) {
        textField.isSecureTextEntry = isSecure
    }
    
    func setText(_ text: String) {
        textField.text = text
        placeHolder.isHidden = true
    }
}
