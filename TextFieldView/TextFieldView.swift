//
//  TextFieldView.swift
//  License under MIT
//
//  Created by Mollick, Md Razib Uddin on 4/28/18.
//  Copyright © 2018 Rio. All rights reserved.
//

import UIKit

public protocol Movable: class {
    func moveUp(indexPath: IndexPath)
}

@IBDesignable
open class TextFieldView: UIView {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLbl: UILabel!
    
    public weak var delegate: Movable?
    public var indexPath: IndexPath?
    public var couplingTextField: UITextField?
    public var defaultTheme: ColorSet?
    private var imageView: UIImageView?
    private var border: CALayer?
    private var validator: InputValidator?
    private var isValidationPassed = false
    
    public var validationType: ValidationType? {
        didSet {
            validator = validationType?.instance
        }
    }
    
    @IBInspectable
    public var titleText: String? {
        get {
            return titleLbl.text
        }
        set(text) {
            titleLbl.text = text
        }
    }
    
    @IBInspectable
    public var  titleColor: UIColor = UIColor.black {
        didSet {
            titleLbl.textColor = titleColor
        }
    }
    
    @IBInspectable
    public var leftImage: UIImage? {
        didSet {
            if let image = leftImage {
                textField.leftViewMode = .always
                let tintedImage = image.withRenderingMode(.alwaysTemplate)
                let height = textField.bounds.height
                imageView = UIImageView(frame: CGRect(x: (height - 20)/2, y: (height - 20)/2, width: 20, height: 20))
                if let imgView = imageView {
                    imgView.image = tintedImage
                    imgView.tintColor = leftImageColor
                    imgView.backgroundColor = leftViewColor
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: height, height: height))
                    view.addSubview(imgView)
                    textField.leftView = view
                    textField.leftView?.backgroundColor = leftViewColor
                }
               } else {
                textField.leftViewMode = .never
            }
        }
    }
    
    @IBInspectable
    public var textfieldColor: UIColor = UIColor.lightText {
        didSet {
            self.textField.backgroundColor = textfieldColor
        }
    }
    
    @IBInspectable
    public var leftImageColor: UIColor = UIColor.lightGray {
        didSet {
            if let imgView = imageView {
                imgView.tintColor = leftImageColor
            }
        }
    }
    
    @IBInspectable
    public var leftViewColor: UIColor = UIColor.clear {
        didSet {
            if let imgView = imageView {
                imgView.backgroundColor = leftViewColor
            }
        }
    }
    
    @IBInspectable
    public var placeholderText: String? {
        get {
            return textField.placeholder
        }
        set(text) {
            if var str = text {
                str = " " + str
                  textField.placeholder = str
            } else {
                 textField.placeholder = text
            }
           
        }
    }
    
    @IBInspectable
    public var placeholderColor: UIColor = UIColor.darkGray {
        didSet {
            if let rawString = textField.attributedPlaceholder?.string {
                let str = NSAttributedString(string: rawString, attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
                textField.attributedPlaceholder = str
            }
        }
    }

    @IBInspectable
    public var textFieldText: String? {
        get {
            return textField.text
        } set(text) {
            textField.text = text
        }
    }
    
    @IBInspectable
    public var messageText: String {
        get {
            return messageLbl.text ?? ""
        }
        set(text) {
            messageLbl.text = text
        }
    }
    
    @IBInspectable
    public var messageTextColor: UIColor = UIColor.red {
        didSet {
            self.messageLbl.textColor = messageTextColor
        }
    }
    
    @IBInspectable
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            self.textField.keyboardType = keyboardType
        }
    }
    
    @IBInspectable
    public var tfCornerRadius: CGFloat = 0.0 {
        didSet {
            self.textField.layer.cornerRadius = self.tfCornerRadius
        }
    }
    
    @IBInspectable
    public var tfBorderWidth: CGFloat = 0.0 {
        didSet {
            self.textField.layer.borderWidth = self.tfBorderWidth
        }
    }
    
    @IBInspectable
    public var tfBorderColor: UIColor = UIColor.gray {
        didSet {
            self.textField.layer.borderColor = self.tfBorderColor.cgColor
        }
    }
    
    @IBInspectable
    public var semiTransparent: Bool = false {
        didSet {
           // self.backgroundColor = UIColor.clear
            self.backgroundColor = UIColor(white: 1, alpha: 0.3)
        }
    }
    
    private var rightImage: UIImage? {
        didSet {
            if let image = rightImage {
                textField.rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 2, y: 0, width: 20, height: 20))
                imageView.image = image
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 20))
                view.addSubview(imageView)
                textField.rightView = view
            } else {
                textField.rightViewMode = .never
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TextFieldView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        self.addSubview(view)
        self.textField.delegate = self
    }
    
    @objc func textFieldDidChange() {
        
        guard let text = textFieldText, let validator = validator else {
            return
        }
        
        if  validator.validateInput(with: text, message: &messageText) {
            switch validationType {
            case .matchInputValidation?:
                if let text = couplingTextField?.text {
                    if !(text == textField.text) {
                        messageText = ValidationMessage.notMatched.rawValue
                        self.decorateInvalidUI()
                        return
                    }
                }
            default:
                break
            }
            isValidationPassed = true
            messageLbl.text = ""
             messageLbl.backgroundColor = UIColor.clear
            let bundle = Bundle(for: type(of: self))
            if let image = UIImage.init(named: "accepted", in: bundle, compatibleWith: nil)  {
                self.rightImage = image
            }
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            self.decorateInvalidUI()
        }
    }

    private func decorateInvalidUI() {
        messageLbl.textColor = UIColor.red
        messageLbl.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.rightImage = nil
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    public func isValidationPass() -> Bool {
        if !isValidationPassed {
            if (textField.text?.isEmpty) == true {
                 messageLbl.text = ValidationMessage.emptyField.rawValue
                 self.decorateInvalidUI()
            }
            shakeTextField(textfield: textField)
        }
        switch validationType {
        case .matchInputValidation?:
            if let text = couplingTextField?.text {
                if !(text == textField.text) {
                    messageText = ValidationMessage.notMatched.rawValue
                    self.decorateInvalidUI()
                    isValidationPassed = false
                    shakeTextField(textfield: textField)
                    return isValidationPassed
                }
            }
        default:
            break
        }
        
        return isValidationPassed
    }
}

extension TextFieldView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let path = self.indexPath else {
            return
        }
        delegate?.moveUp(indexPath: path)
    }
    
    public func shakeTextField(textfield: UITextField) {
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint: CGPoint = CGPoint(x: textfield.center.x - 5, y: textfield.center.y)
        let fromValue: NSValue = NSValue(cgPoint: fromPoint)
        
        let toPoint: CGPoint = CGPoint(x: textfield.center.x + 5, y: textfield.center.y)
        let toValue: NSValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        textfield.layer.add(shake, forKey: "position")
    }
    
    private func underlined(borderColor: UIColor) {
        
        if border == nil {
            border = CALayer()
            let width = CGFloat(1.0)
            border?.borderColor = borderColor.cgColor
            border?.frame = CGRect(x: 0, y: self.textField.frame.size.height - width, width:  self.textField.frame.size.width, height: self.textField.frame.size.height)
            border?.borderWidth = width
            if let line = border {
                self.textField.layer.addSublayer(line)
                self.textField.layer.masksToBounds = true
            }
        } else {
            border?.isHidden = false
        }
    }
    
    private func hideUnderline() {
        if let line = border {
            line.isHidden = true
        }
    }
    
}

extension TextFieldView {
    
   public func applyTheme(with colorSet: ColorSet?) {
        if let newColorSet = colorSet {
            decorateUI(colorSet: newColorSet)
        }
    }
    
    private func decorateUI(colorSet: ColorSet!) {
        titleColor = colorSet.titleColor
        leftImageColor = colorSet.leftImgTintColor
        placeholderColor = colorSet.placeholderTextColor
        messageTextColor = colorSet.errorTextColor
        leftViewColor = colorSet.leftViewColor
        textField.leftView?.backgroundColor = colorSet.leftViewColor
        textfieldColor = colorSet.textfieldColor
    }
    
   public func applyStyle(with style: StyleType) {
        self.textField.layer.masksToBounds = true
        switch style {
        case .box:
            self.tfBorderWidth = 2.0
            self.tfCornerRadius = 0.0
            self.hideUnderline()
        case .rounded:
             self.tfBorderWidth = 2.0
            self.tfCornerRadius = 12.0
            self.hideUnderline()
        case .line:
            self.tfBorderWidth = 0.0
            self.tfCornerRadius = 0.0
            self.underlined(borderColor: self.tfBorderColor)
            leftViewColor = UIColor.clear
            textField.leftView?.backgroundColor = UIColor.clear
            textfieldColor = UIColor.clear
        }
    }
}

