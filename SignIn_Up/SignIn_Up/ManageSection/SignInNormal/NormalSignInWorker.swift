//
//  NormalSignInWorker.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift

final class NormalSignInWorker {
    
    func signIn(with urlRequest: URLRequest) -> Single<NetworkReturnModel> {
        
        return NetworkProvider.request(with: urlRequest)
    }
}
