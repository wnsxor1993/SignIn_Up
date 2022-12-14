//
//  ValidityCase.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import Foundation

/**
 유효성 검사를 위한 조건문 관리 Enum
  
 Cases'  default condition:
 - idValidity  = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$"
 - emailValidity  = "^[A-Z0-9a-z]+@[A-Za-z0-9]+\\.[A-Za-z]{2,64}"
 - passwordValidity = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$"
 - phoneNumberValidity = "^01[0-1, 7][0-9]{7,8}$"
 - koreanNameValidity = "^[가-힣]{2,6}"
 - nickNameValidity = "^[가-힣A-Za-z0-9]{2,15}"
 */
enum ValidityCase {
    
    case idValidity(String = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$")
    case emailValidity(String = "^[A-Z0-9a-z]+@[A-Za-z0-9]+\\.[A-Za-z]{2,64}")
    case passwordValidity(String = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$")
    case phoneNumberValidity(String = "^01[0-1, 7][0-9]{7,8}$")
    case koreanNameValidity(String = "^[가-힣]{2,6}")
    case nickNameValidity(String = "^[가-힣A-Za-z0-9]{2,15}")
}

extension ValidityCase {
    
    private var validityRegex: String {
        switch self {
        case .idValidity(let string):
            return string
            
        case .emailValidity(let string):
            return string
            
        case .passwordValidity(let string):
            return string
            
        case .phoneNumberValidity(let string):
            return string
            
        case .koreanNameValidity(let string):
            return string
            
        case .nickNameValidity(let string):
            return string
        }
    }
    
    var casePredicate: NSPredicate {
        
        return NSPredicate(format: "SELF MATCHES %@", self.validityRegex)
    }
}
