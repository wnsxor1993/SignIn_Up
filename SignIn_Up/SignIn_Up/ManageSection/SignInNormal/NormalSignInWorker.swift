//
//  NormalSignInWorker.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift
import Moya

final class NormalSignInWorker {
    
    func signIn(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        
        return NetworkProvider.request(with: endPoint)
    }
}
