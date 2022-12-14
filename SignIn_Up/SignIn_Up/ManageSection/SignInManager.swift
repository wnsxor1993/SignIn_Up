//
//  SignInManager.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift
import Moya

open class SignInManager {
    
    let shared = SignInManager()
    let normalWorker = NormalSignInWorker()
    
    private init() { }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        self.kakaoManager.scene(scene, openURLContexts: URLContexts)
    }
}

extension SignInManager {
    
    func signInNormal(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        return self.normalWorker.signIn(with: endPoint)
    }
}
