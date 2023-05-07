//
//  LoginBottomView.swift
//  Habitude
//
//  Created by Atacan Sevim on 25.04.2023.
//

import Foundation
import UIKit

final class LoginBottomView: UIView {
   
    // MARK: -Constants
    
    private enum Constants {
        static let illustrationName = "LoginScreenIllustration"
        static let height: CGFloat = 488
        static let infoText = "By continuing you agree to the Habitude Term of Service and Privacy Policy"
        static let stackSpacing: CGFloat = 16
        static let iconStackViewSpacing: CGFloat = 10
        static let bottomStackViewSpacing: CGFloat = 5
    }
    
    // MARK: -Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.titleMedium
        label.textColor = UIColor.Habitute.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textBoxStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
   private let emailTextView = HabitudeTextField(placeHolder: "Email")
    
   private let passwordTextView = HabitudeTextField(placeHolder: "Password")
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        var attributedText = NSMutableAttributedString(
            string: Constants.infoText,
            attributes: [
                NSAttributedString.Key.font : UIFont.Habitude.paragraphExtraSmall!,
                NSAttributedString.Key.foregroundColor: UIColor.Habitute.primaryLight
            ]
        )
        attributedText.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.Habitute.accent,
            range: NSRange(location: Constants.infoText.indexInt(of: "T")!, length: "Term of Service".count)
        )
        attributedText.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.Habitute.accent,
            range: NSRange(location: Constants.infoText.indexInt(of: "P")!, length: "Privacy Policy".count)
        )
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let contiuneButton = HabitudeCornerButton(title: "Continue")
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = UIFont.Habitude.paragraphSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leftSeparator = UIView.separator(width: 75)
    private let rightSeparator = UIView.separator(width: 75)
    
    private let iconStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.iconStackViewSpacing
        stack.alignment = .center
        stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return stack
    }()
    
    private let bottomInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have a account?"
        label.font = UIFont.Habitude.paragraphExtraSmall
        label.textColor = UIColor.Habitute.primaryLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Habitude.paragraphSmall
        label.textColor = UIColor.Habitute.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomActionStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stack.spacing = Constants.bottomStackViewSpacing
        return stack
    }()
    
    weak var delegate: LoginBottomViewDelegate?
    
    //MARK: -init
    
    init(titleText: String, actionLabelText: String) {
        super.init(frame: .zero)
        titleLabel.text = titleText
        actionLabel.text = actionLabelText
        emailTextView.handleViewOutput = self
        passwordTextView.handleViewOutput = self
        style()
        layout()
        contiuneButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder){
        fatalError("")
    }
}

extension LoginBottomView {
    
    private func style() {
        backgroundColor = UIColor.Habitute.secondaryDark
        
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func layout() {
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        addSubview(textBoxStack)
        NSLayoutConstraint.activate([
            textBoxStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textBoxStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: textBoxStack.trailingAnchor, constant: 20)
        ])
        
        textBoxStack.addArrangedSubview(emailTextView)
        textBoxStack.addArrangedSubview(passwordTextView)
        textBoxStack.addArrangedSubview(infoLabel)
        textBoxStack.addArrangedSubview(contiuneButton)
        
        addSubview(separatorLabel)
        addSubview(leftSeparator)
        addSubview(rightSeparator)
        
        NSLayoutConstraint.activate([
            separatorLabel.topAnchor.constraint(equalTo: textBoxStack.bottomAnchor, constant: 20),
            separatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            leftSeparator.trailingAnchor.constraint(equalTo: separatorLabel.leadingAnchor, constant: -5),
            separatorLabel.trailingAnchor.constraint(equalTo: rightSeparator.leadingAnchor, constant: -5),
            leftSeparator.centerYAnchor.constraint(equalTo: separatorLabel.centerYAnchor),
            rightSeparator.centerYAnchor.constraint(equalTo: separatorLabel.centerYAnchor),
        ])
        
        addSubview(iconStack)
        NSLayoutConstraint.activate([
            iconStack.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor, constant: 20),
            iconStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        contiuneButton.isEnabled = false
        iconStack.addArrangedSubview(UIImageView(image: UIImage(named: "facebook")))
        iconStack.addArrangedSubview(UIImageView(image: UIImage(named: "google")))
        
        addSubview(bottomActionStack)
        bottomActionStack.addArrangedSubview(bottomInfoLabel)
        bottomActionStack.addArrangedSubview(actionLabel)
        
        NSLayoutConstraint.activate([
            bottomActionStack.topAnchor.constraint(equalTo: iconStack.bottomAnchor, constant: 20),
            bottomActionStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func isButtonEnabled() {
        contiuneButton.isEnabled = !self.emailTextView.text.isEmpty && !self.passwordTextView.text.isEmpty
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        delegate?.tapContiuneButton()
    }

}

// MARK: - Actions

extension LoginBottomView: HabitudeTextFieldDelegate {
    
    func sendEmail(email: String) {
        isButtonEnabled()
        delegate?.sendEmail(email: email)
    }
    
    func sendPassword(password: String) {
        isButtonEnabled()
        delegate?.sendPassword(password: password)
    }
}
