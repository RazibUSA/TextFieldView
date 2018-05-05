//
//  SignInCell.swift
//  Ashley Furnitures
//
//  Created by Mollick, Md Razib Uddin on 4/28/18.
//  Copyright © 2018 Ascend Inc, CA http://www.ascend-inc.com/. All rights reserved.
//

import UIKit

protocol SignUpDelegate: class {
    func forgotPassword()
    func signUp()
}
class SignInCell: UITableViewCell {
    weak var delegate: SignUpDelegate?

    @IBOutlet weak var signupBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.3)
    }

    @IBAction func signUpClicked(_ sender: Any) {
        self.delegate?.signUp()
    }
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.delegate?.forgotPassword()
    }

}
