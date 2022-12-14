//
//  KakaoSignInWorker.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoSignInWorker {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = AuthController.handleOpenUrl(url: url)
        }
    }
    
    func fetchAccessToken() -> Single<String> {
        
        return Single.just(UserApi.isKakaoTalkLoginAvailable())
            .flatMap { [weak self] isAppLoginAvailable in
                guard let self else { return .never() }
                
                return isAppLoginAvailable ? self.signInWithKakaoApp() : self.signInWithKakaoAccount()
            }
    }
    
    func signIn(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        
        return NetworkProvider.request(with: endPoint)
    }
}

private extension KakaoSignInWorker {
    
    func signInWithKakaoApp() -> Single<String> {
        
        return .create { observer in
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                guard let oauthToken = oauthToken else {
                    NSLog("KakaoTalk Login error: \(String(describing: error))")
                    observer(.failure(error ?? RxError.noElements))
                    
                    return
                }
                
                observer(.success(oauthToken.accessToken))
            }
            
            return Disposables.create()
        }
    }
    
    func signInWithKakaoAccount() -> Single<String> {
        
        return .create { observer in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                guard let oauthToken = oauthToken else {
                    NSLog("KakaoTalk Login error: \(String(describing: error))")
                    observer(.failure(error ?? RxError.noElements))
                    
                    return
                }
                
                observer(.success(oauthToken.accessToken))
            }
            
            return Disposables.create()
        }
    }
}
