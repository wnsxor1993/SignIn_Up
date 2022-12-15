//
//  AppleSignInWorker.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import RxSwift
import RxRelay
import AuthenticationServices

final class AppleSignInWorker: NSObject {
    
    private let identityTokenRelay = PublishRelay<String>()
    
    func fetchIdentityToken(with disposeBag: DisposeBag) -> Single<String> {
        defer {
            self.performRequestASAuthorization()
        }
        
        return .create { [weak self] observer in
            self?.identityTokenRelay
                .subscribe { token in
                    observer(.success(token))
                } onError: { error in
                    observer(.failure(error))
                }
                .disposed(by: disposeBag)
            
            return Disposables.create()
        }
    }
    
    func signIn(with urlRequest: URLRequest) -> Single<NetworkReturnModel> {
        
        return NetworkProvider.request(with: urlRequest)
    }
}

extension AppleSignInWorker: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let identityCode = appleIDCredential.identityToken, let authString = String(data: identityCode, encoding: .utf8) else { return }
            
            self.identityTokenRelay.accept(authString)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}

private extension AppleSignInWorker {
    
    func performRequestASAuthorization() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}
