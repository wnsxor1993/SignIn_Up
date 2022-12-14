//
//  SignUpManager.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift

open class ValidateManager {
    
    let shared = ValidateManager()
    
    private init() { }
    
    /**
        유효성 검사 메서드
     
        - parameters:
            - regex: Validity Case는 디폴트 값을 가지며 사용자가 임의로 수정할 수 있음
            - value: 유효성 검사를 진행할 값
     
        - returns:
            유효성 검사에 따른 Bool 타입의 값을 반환
     */
    func validate(regex: ValidityCase, with value: String) -> Bool {
        
        return regex.casePredicate.evaluate(with: value)
    }
}
