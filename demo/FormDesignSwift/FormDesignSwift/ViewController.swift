//
//  ViewController.swift
//  FormDesignSwift
//
//  Created by Mollick, Md Razib Uddin on 4/24/18.
//  Copyright © 2018 Ascend Inc, CA http://www.ascend-inc.com/. All rights reserved.
//

import UIKit
import TextFieldView

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var colorSegment: UISegmentedControl!
    @IBOutlet weak var styleSegment: UISegmentedControl!
    @IBOutlet weak var backgoundIV: UIImageView!
    
    var styleType: StyleType = .box
    
    struct ColorController {
        var barColor: UIColor
        var barTextColor: UIColor
        var backgroundImage: UIImage
        var segmentBorderColor: UIColor
        var segmentSelectionColor: UIColor
        var segmentTextColor: UIColor
        var buttonColor: UIColor
    }
    
    var defaultController: ColorController?
    var buttonColor: UIColor?
    var themeColor: ColorSet = ColorSet(titleColor: UIColor.white, leftViewColor: UIColor.purple, leftImgTintColor: UIColor.white, placeholderTextColor: UIColor.purple, errorTextColor: UIColor.red, borderColor: UIColor.white, textfieldColor: UIColor.lightText)
    
    private enum NewAccountConfig {
        
        case name
        case phone
        case email
        case password
        case createAccount
        
        var value: String {
            switch self {
            case .name: return "TextViewInputCell"
            case .phone: return "TextViewInputCell"
            case .email: return "TextViewInputCell"
            case .password: return "TextViewInputCell"
            case .createAccount: return "SignInCell"
            }
        }
        
        static func allObjectStrings() -> [String] {
            return [
                self.name.value,
                self.phone.value,
                self.email.value,
                self.password.value,
                self.createAccount.value
            ]
        }
    }
    
    enum Textfields: Int {
        case firstName = 0, lastName, email, confirmEmail, password, confirmPassword
    }
    private var cells: [NewAccountConfig] = []
    var cellViews: [TextFieldView] = []
    
    var currentTextFieldPosition: CGFloat = 0
    var isViewDownable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCells()
        cells = [
            .name,
            .phone,
            .email,
            .password,
            .createAccount
        ]
         getDefaultController()
        tableview.allowsSelection = false
        tableview.reloadData()
        self.registerKeyboardNotification()
        tableview.layer.borderWidth = 1.0
        tableview.layer.borderColor = UIColor.white.cgColor
        self.tableview.sizeToFit()
    }
    
    func getDefaultController() {
        
        if defaultController == nil {
            
          defaultController = ColorController(barColor: UIColor.purple,
                                              barTextColor: UIColor.white,
                                              backgroundImage: UIImage(named: "purple")!, segmentBorderColor: UIColor.white, segmentSelectionColor: UIColor.purple, segmentTextColor: UIColor.white, buttonColor: UIColor.purple)
            
        }
        
        if let colorCtl = defaultController {
            self.decorateVC(with: colorCtl)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.unregisterKeyboardNotification()
    }
    
    private func setupCells() {
        NewAccountConfig.allObjectStrings().forEach({
            tableview.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        })
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func colorSegmentClicked(_ sender: Any) {

        switch colorSegment.selectedSegmentIndex
        {
        case 0:
            getDefaultController()
           
             themeColor = ColorSet(titleColor: UIColor.white, leftViewColor: UIColor.purple, leftImgTintColor: UIColor.white, placeholderTextColor: UIColor.purple, errorTextColor: UIColor.red, borderColor: UIColor.white, textfieldColor: UIColor.lightText)
        case 1:
            let color = UIColor(red:0.31, green:0.77, blue:0.21, alpha:1.0)
            let  cController = ColorController(barColor: color,
                                                barTextColor: UIColor.white,
                                                backgroundImage: UIImage(named: "lemon")!, segmentBorderColor: color, segmentSelectionColor: color,
                                                segmentTextColor: UIColor.white,
                                                buttonColor: color
                                                )
        //    colorSegment.subviews[1].backgroundColor = color
            themeColor = ColorSet(titleColor: color, leftViewColor: color, leftImgTintColor: UIColor.white, placeholderTextColor: color, errorTextColor: UIColor.red, borderColor: UIColor.white, textfieldColor: UIColor.lightText)
            decorateVC(with: cController)
        case 2:
            let color = UIColor.blue
            let  cController = ColorController(barColor: color,
                                               barTextColor: UIColor.white,
                                               backgroundImage: UIImage(named: "blue")!, segmentBorderColor: UIColor.white, segmentSelectionColor: color,
                                               segmentTextColor: UIColor.white,
                                               buttonColor: color
                                               )
            themeColor = ColorSet(titleColor: UIColor.white, leftViewColor: color, leftImgTintColor: UIColor.white, placeholderTextColor: color, errorTextColor: UIColor.red, borderColor: UIColor.white, textfieldColor: UIColor.lightText)
            decorateVC(with: cController)
        default:
            break
        }
        tableview.reloadData()
    }
    
    func decorateVC(with colorController: ColorController ) {
        
        self.view.backgroundColor = colorController.barColor
        self.backgoundIV.image = colorController.backgroundImage
        self.colorSegment.tintColor = colorController.segmentBorderColor
        self.styleSegment.tintColor = colorController.segmentBorderColor
        
        buttonColor = colorController.buttonColor
    }
    
    @IBAction func styleSegmentClicked(_ sender: Any) {
        switch styleSegment.selectedSegmentIndex
        {
        case 0:
         styleType = .box
        case 1:
             styleType = .rounded
        case 2:
             styleType = .line
        default:
            break
        }
        tableview.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellConfig = cells[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfig.value, for: indexPath)
        switch cellConfig {
        case .name:
            guard let cell = cell as? TextViewInputCell else { break }
            cell.setupView(type: .firstName, indexpath: indexPath, icon: SystemIcon.user.icon, validator: ValidationType.normalValidation, delegate: self)
            cell.textFieldView.applyTheme(with: themeColor)
            cell.textFieldView.applyStyle(with: styleType)
            cellViews.append(cell.textFieldView)
            return cell
        case .phone:
            guard let cell = cell as? TextViewInputCell else { break }
            cell.setupView(type: .phone, indexpath: indexPath, icon: SystemIcon.call.icon, validator: ValidationType.normalValidation, delegate: self)
            cell.textFieldView.applyTheme(with: themeColor)
            cell.textFieldView.applyStyle(with: styleType)
            cellViews.append(cell.textFieldView)
            return cell
        case .email:
            guard let cell = cell as? TextViewInputCell else { break }
            cell.setupView(type: .email, indexpath: indexPath, icon: SystemIcon.email.icon, validator: ValidationType.emailValidation, delegate: self)
            cell.textFieldView.applyTheme(with: themeColor)
            cell.textFieldView.applyStyle(with: styleType)
            cellViews.append(cell.textFieldView)
            return cell
     
        case .password:
            guard let cell = cell as? TextViewInputCell else { break }
            cell.setupView(type: .password, indexpath: indexPath, icon: SystemIcon.lock.icon, validator: ValidationType.passwordValidation, delegate: self)
            cell.textFieldView.applyTheme(with: themeColor)
            cell.textFieldView.applyStyle(with: styleType)
            cellViews.append(cell.textFieldView)
            return cell
 
        case .createAccount:
            guard let cell = cell as? SignInCell else { break }
            cell.signupBtn.backgroundColor = buttonColor
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableview.estimatedRowHeight = 100
        self.tableview.sizeToFit()
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


extension ViewController: Movable {
    
    func moveUp(indexPath: IndexPath) {
        let cellRect = tableview.rectForRow(at: indexPath)
        let rectWithSuperView = tableview.convert(cellRect, to: tableview.superview)
        currentTextFieldPosition = (rectWithSuperView.origin.y) + (rectWithSuperView.size.height)
    }
    
    func registerKeyboardNotification() {
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }
        guard let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        if currentTextFieldPosition > (self.view.bounds.size.height - keyboardHeight - 90.0), !isViewDownable {
            
            UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut, animations: {
                self.view.frame = CGRect(x: 0, y: (self.view.frame.origin.y - keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
            
            isViewDownable = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let info = notification.userInfo else {
            return
        }
        guard let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        if isViewDownable {
            UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut, animations: {
                self.view.frame = CGRect(x: 0, y: (self.view.frame.origin.y + keyboardHeight), width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
            
            isViewDownable = false
        }
    }
}
