//
//  TextFieldViewStyle.swift
//  License under MIT
//
//  Created by Mollick, Md Razib Uddin on 4/28/18.
//  Copyright © 2018 Rio. All rights reserved.
//

import Foundation
import UIKit

public enum StyleType {
    case box, rounded, line
}

public struct ColorSet {
    public var titleColor: UIColor
    public var leftViewColor: UIColor
    public var leftImgTintColor: UIColor
    public var placeholderTextColor: UIColor
    public var errorTextColor: UIColor
    public var borderColor: UIColor
    public var textfieldColor: UIColor
    
    public init(titleColor: UIColor, leftViewColor: UIColor, leftImgTintColor: UIColor, placeholderTextColor: UIColor, errorTextColor: UIColor, borderColor: UIColor, textfieldColor: UIColor) {
        self.titleColor = titleColor
        self.leftViewColor = leftViewColor
        self.leftImgTintColor = leftImgTintColor
        self.placeholderTextColor = placeholderTextColor
        self.errorTextColor = errorTextColor
        self.borderColor = borderColor
        self.textfieldColor = textfieldColor
    }
}

public enum SystemIcon {
    case user, email, lock, payment, call
    
    public var icon: UIImage {
        switch self {
        case .user:
            return UIImage(named: "ic_perm_identity", in: Bundle(for: TextFieldView.self), compatibleWith: nil)!
        case .email:
            return UIImage(named: "ic_mail_outline", in: Bundle(for: TextFieldView.self), compatibleWith: nil)!
        case .lock:
            return UIImage(named: "ic_lock_open", in: Bundle(for: TextFieldView.self), compatibleWith: nil)!
        case .payment:
            return UIImage(named: "ic_payment", in: Bundle(for: TextFieldView.self), compatibleWith: nil)!
        case .call:
            return UIImage(named: "ic_call_end", in: Bundle(for: TextFieldView.self), compatibleWith: nil)!
        }
    }
}
