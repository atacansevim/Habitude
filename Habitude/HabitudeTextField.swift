//
//  HabitudeTextField.swift
//  Habitude
//
//  Created by Atacan Sevim on 7.05.2023.
//

import Foundation
import UIKit

class HabitudeTextField: UITextView {
    
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
    
    private var height: CGFloat = 60
    
    weak var handleViewOutput: HabitudeTextFieldDelegate?
    
    init(placeHolder: String, height: CGFloat = 60) {
        super.init(frame: .zero, textContainer: nil)
        self.placeHolder.text = placeHolder
        self.height = height
        backgroundColor = .clear
        delegate = self
        layout()
        style()
    }

    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: 350)
        ])
        
        addSubview(placeHolder)
        NSLayoutConstraint.activate([
            placeHolder.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeHolder.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
    }
    
    private func style() {
        font = UIFont.Habitude.paragraphSmall
        textColor = UIColor.Habitute.primaryLight
        layer.borderWidth = 2
        layer.borderColor = UIColor.Habitute.secondaryLight.cgColor
        layer.cornerRadius = 5
        textContainer.maximumNumberOfLines = 1
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

extension HabitudeTextField: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolder.isHidden = true
    }
    
    private func textViewShouldBeginEditing(_ textView: UITextView) {
        placeHolder.isHidden = true
    }
    
    private func textFieldShouldEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeHolder.isHidden = false
        } else {
            placeHolder.isHidden = true
        }
        
        if placeHolder.text == "Email" {
            handleViewOutput?.sendEmail(email: textView.text)
        } else if placeHolder.text == "Password" {
            handleViewOutput?.sendPassword(password: textView.text)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeHolder.isHidden = false
        } else {
            placeHolder.isHidden = true
        }
        
        if placeHolder.text == "Email" {
            handleViewOutput?.sendEmail(email: textView.text)
        } else if placeHolder.text == "Password" {
            handleViewOutput?.sendPassword(password: textView.text)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if placeHolder.text == "Email" {
            handleViewOutput?.sendEmail(email: textView.text)
        } else if placeHolder.text == "Password" {
            handleViewOutput?.sendPassword(password: textView.text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
