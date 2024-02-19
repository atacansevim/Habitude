//
//  HabitudeProfileTextField.swift
//  Habitude
//
//  Created by Atacan Sevim on 4.05.2023.
//

import Foundation
import UIKit

protocol HabitudeProfileTextFieldDelegate: AnyObject {
    func sendText(text: String, placeHolder: String)
}

final class HabitudeProfileTextField: UITextField {
    
    private let placeHolder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Habitude.paragraphRegular
        label.textColor = UIColor.Habitute.primaryLightHalfAlpha
       return label
    }()
    
    private let underLine = UIView.separator(width: 400, color: UIColor.Habitute.secondaryLight)
    weak var handleViewOutput: HabitudeProfileTextFieldDelegate?
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        self.placeHolder.text = placeHolder
        self.backgroundColor = .clear
        delegate = self
        layout()
        style()
    }

    private func layout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            widthAnchor.constraint(lessThanOrEqualToConstant: 350)
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
        textAlignment = .center
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
    
    func setText(_ text: String?) {
        self.text = text
        placeHolder.isHidden = true
    }
}


//MARK: -Delegates

extension HabitudeProfileTextField: UITextFieldDelegate {
    
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
        
        handleViewOutput?.sendText(text: text ?? "", placeHolder: placeHolder.text ?? "")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text  {
            placeHolder.isHidden = (text.isEmpty && !textField.isFirstResponder) ? false : true
        } else {
            placeHolder.isHidden = false
        }
        
        handleViewOutput?.sendText(text: text ?? "", placeHolder: placeHolder.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
