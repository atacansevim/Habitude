//
//  LoginTypeEnum .swift
//  Habitude
//
//  Created by Atacan Sevim on 19.05.2023.
//

import UIKit

enum LoginTypeEnum {
    
    private var signUpInfoText: String {
        return "By continuing you agree to the Habitude Term of Service and Privacy Policy"
    }
    
    var title: String {
        switch self {
        case .SIGNUP:
            return "Sing Up"
        case .SIGNIN:
            return "Sign In"
        }
    }
    
    var bottomInfoText: String {
        switch self {
        case .SIGNUP:
            return "Sing In"
        case .SIGNIN:
            return "Sign Up"
        }
    }
    
    var leftBottomInfoText: String {
        switch self {
        case .SIGNUP:
            return "Already have a account?"
        case .SIGNIN:
            return "New to Habitude?"
        }
    }
    
    var infoText: NSAttributedString {
        switch self {
        case .SIGNUP:
            let attributedText = NSMutableAttributedString(
                string: signUpInfoText,
                attributes: [
                    NSAttributedString.Key.font : UIFont.Habitude.paragraphExtraSmall!,
                    NSAttributedString.Key.foregroundColor: UIColor.Habitute.primaryLight
                ]
            )
            attributedText.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.Habitute.accent,
                range: NSRange(location: signUpInfoText.indexInt(of: "T")!, length: "Term of Service".count)
            )
            attributedText.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.Habitute.accent,
                range: NSRange(location: signUpInfoText.indexInt(of: "P")!, length: "Privacy Policy".count)
            )
            return attributedText
        case .SIGNIN:
            return NSMutableAttributedString(
                string: "Forget Password?",
                attributes: [
                    NSAttributedString.Key.font : UIFont.Habitude.paragraphExtraSmall!,
                    NSAttributedString.Key.foregroundColor: UIColor.Habitute.accent
                ]
            )
            
        }
    }
    case SIGNUP, SIGNIN
}
