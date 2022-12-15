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
    
    /**
        openURLContexts 메서드
     
        SceneDelegate의 scene 메서드에서 호출
     */
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        self.kakaoWorker.scene(scene, openURLContexts: URLContexts)
    }
    
    /**
        카카오 SDK 초기화 메서드
     
        - parameters:
            - appKey: String 타입의 네이티브 앱 키
     */
    func initKakaoSDK(with appKey: String) {
        self.kakaoWorker.initSDK(with: appKey)
    }
}

extension SignInManager {
    
    /**
        로그인 로직 수행 메서드
     
        - parameters:
            - urlRequest: 서버와의 로그인 관련 API 전달 (헤더에 Bearer \(token) 필수!!)
            - signCase: 로그인을 수행할 수단
     
        - returns:
            statusCode와 Data 값을 지닌 Struct 리턴 (실패 시, error 값 전달)
     */
    func signIn(with urlRequest: URLRequest, which signCase: SignInCase) -> Single<NetworkReturnModel> {
        switch signCase {
        case .normal:
            return self.normalWorker.signIn(with: urlRequest)
            
        case .kakao:
            return self.kakaoWorker.signIn(with: urlRequest)
            
        case .apple:
            return self.appleWorker.signIn(with: urlRequest)
        }
    }
    
    /**
        소셜 로그인 토큰 요청 메서드
     
        - parameters:
            - signCase: 토큰을 요청할 소셜 구분 (normal일 경우 .never() 리턴)
     
        - returns:
            토큰 값 리턴 (실패 시, error 값 전달)
     */
    func fetchToken(which signCase: SignInCase) -> Single<String> {
        switch signCase {
        case .normal:
            return .never()
            
        case .kakao:
            return self.kakaoWorker.fetchAccessToken()
            
        case .apple:
            return self.appleWorker.fetchIdentityToken(with: disposeBag)
        }
    }
}
