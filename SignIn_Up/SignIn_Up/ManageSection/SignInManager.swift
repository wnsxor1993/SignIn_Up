//
//  SignInManager.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift

open class SignInManager {
    
    let shared = SignInManager()
    private let normalWorker = NormalSignInWorker()
    private let kakaoWorker = KakaoSignInWorker()
    private let appleWorker = AppleSignInWorker()
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        self.kakaoWorker.scene(scene, openURLContexts: URLContexts)
    }
}

extension SignInManager {
    
    func signInNormal(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        return self.normalWorker.signIn(with: endPoint)
    }
    
    func fetchKakaoToken() -> Single<String> {
        return self.kakaoWorker.fetchAccessToken()
    }
    
    func signInKakao(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        return self.kakaoWorker.signIn(with: endPoint)
    }
    
    func fetchAppleToken() -> Single<String> {
        return self.appleWorker.fetchIdentityToken(with: disposeBag)
    }
    
    func signInApple(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        return self.appleWorker.signIn(with: endPoint)
    }
}
