//
//  Validator.swift
//  License under MIT
//
//  Created by Mollick, Md Razib Uddin on 4/28/18.
//  Copyright © 2018 Rio. All rights reserved.
//

import Foundation

protocol InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool
}

public enum ValidationType {
    case passwordValidation
    case emailValidation
    case normalValidation
    case matchInputValidation
    
    var instance: InputValidator {
        switch self {
        case .passwordValidation: return PasswordInputValidator()
        case .emailValidation: return EmailInputValidator()
        case .normalValidation: return NormalInputValidator()
        case .matchInputValidation: return MatchInputValidator()
        }
    }
}

struct NormalInputValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        if text.isEmpty {
            message = ValidationMessage.emptyField.rawValue
            return false
        }
        message = ValidationMessage.correct.rawValue
        return true
    }
}

struct PasswordInputValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        var lowerCaseLetter: Bool = false
        var upperCaseLetter: Bool = false
        var digit: Bool = false
        var specialCharacter: Bool = false
        
        if text.count  >= 8 {
            for char in text.unicodeScalars {
                if !lowerCaseLetter {
                    lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
                }
                if !upperCaseLetter {
                    upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
                }
                if !digit {
                    digit = CharacterSet.decimalDigits.contains(char)
                }
                if !specialCharacter {
                    specialCharacter = CharacterSet.punctuationCharacters.contains(char)
                }
            }
            
            let checkList = [digit, upperCaseLetter, specialCharacter, lowerCaseLetter]
            if let index = checkList.firstIndex(where: { !$0 }) {
                print("\(index) is false")
                switch index {
                case 0:
                     message = ValidationMessage.noDigitFound.rawValue
                case 1:
                    message = ValidationMessage.atleastOneUpperCaseLetter.rawValue
                case 2:
                    message = ValidationMessage.atleastOneSpecialCaseLetter.rawValue
                case 3:
                    message = ValidationMessage.atleastOneLowerCaseLetter.rawValue
                default:
                    message = ValidationMessage.correct.rawValue
                }
                return false
            } else {
                 message = ValidationMessage.correct.rawValue
                 return true
            }
        } else {
            message = ValidationMessage.invalidPassword.rawValue
            return false
        }
    }
}

struct EmailInputValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        
        guard  let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive) else {
            message = ValidationMessage.invalidEmail.rawValue
            return false
        }
        if regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) != nil {
            message = ValidationMessage.correct.rawValue
            return true
        } else {
            message = ValidationMessage.invalidEmail.rawValue
            return false
        }
    }
}

struct MatchInputValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        if text.isEmpty {
            message = ValidationMessage.emptyField.rawValue
            return false
        }
        message = ValidationMessage.correct.rawValue
        return true
    }
}

struct ZipCodeValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        
        message = ValidationMessage.correct.rawValue
        let postalcodeRegex = "^[0-9]{5}(-[0-9]{4})?$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: text) as Bool
        if !bool {
            message = ValidationMessage.notAValidInput.rawValue
        }
        return bool
    }
}

struct PhoneNumberValidator: InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        message = ValidationMessage.correct.rawValue
        let phonecodeRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", phonecodeRegex)
        let bool = pinPredicate.evaluate(with: text) as Bool
        if !bool {
            message = ValidationMessage.notAValidInput.rawValue
        }
        return bool
    }
}

enum ValidationMessage: String {
    case emptyField = "Field can't be empty"
    case invalidEmail = "Invalid email addresses"
    case atleastEightChars = "Atleast 8 Characters Length"
    case atleastOneUpperCaseLetter = "Atleast 1 uppercase letter"
    case atleastOneLowerCaseLetter = "Atleast 1 lowercase letter"
    case atleastOneSpecialCaseLetter = "Atleast 1 special character[Valid: !@#$%^&*]"
    case invalidPassword = "Must be 8 Characters. including 1 upper, lower, digit & special symbol"
    case noDigitFound = "Must have 1 digit"
    case correct = "Accepted"
    case notMatched = "Does not Match"
    case passwordRule = "Must be 8 Ch"
    case notAValidInput = "Not a Valid Input"
}
