//
//  TextInputCell.swift
//  Ashley Furnitures
//
//  Created by Mollick, Md Razib Uddin on 4/28/18.
//  Copyright © 2018 Ascend Inc, CA http://www.ascend-inc.com/. All rights reserved.
//

import UIKit
import TextFieldView

enum InputType {

    case firstName
    case phone
    case email
    case accountEmail
    case confirmEmail
    case password
    case accountPassword
    case confirmPassword
    

    var value: String {
        switch self {
        case .firstName: return "Your Name*"
        case .email: return "Email*"
        case .accountEmail: return "Email*"
        case .confirmEmail: return "Confirm Email*"
        case .password: return "Password*"
        case .accountPassword: return "Password*"
        case .confirmPassword: return "Confirm Password*"
        case .phone: return "Phone"
        }
    }
    var placeHolder: String {
        switch self {
        case .firstName: return "Enter Your Name"
        case .email: return "Enter Email"
        case .accountEmail: return "Enter Email"
        case .confirmEmail: return "Re-Enter Email"
        case .password: return "Enter Password"
        case .accountPassword: return "Re-Enter Password"
        case .confirmPassword: return "Re-Enter Password"
        case .phone: return "Phone Number"
        }
    }
}
class TextViewInputCell: UITableViewCell {

    var type: InputType!
    @IBOutlet weak var textFieldView: TextFieldView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    func setupView(type: InputType, indexpath: IndexPath, icon: UIImage?, couplingTextField: UITextField? = nil, validator: ValidationType, delegate: Movable?) {
        self.type = type
        textFieldView.titleText = type.value
        if let image = icon {
           textFieldView.leftImage = image
        }
        if let textField = couplingTextField {
            textFieldView.couplingTextField = textField
        }
        textFieldView.validationType = validator
        guard let delegate = delegate else { return }
        textFieldView.delegate = delegate
        textFieldView.indexPath = indexpath
    }

}
