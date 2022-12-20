//
//  NetworkProvider.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/13.
//

import RxSwift

struct NetworkProvider {
    
    enum URLMethod {
        case GET
        case POST
        case PATCH
        case DELETE
    }
    
    /**
        로그인 로직 수행을 위한 UrlRequest 생성 메서드
     
        - parameters:
            - url: 생성할 request의 EndPoint URL의 String 타입
            - method: Method case (기본 값은 POST)
            - param: 추가할 [String: Any] 타입의 파라미터 (옵셔널이며 기본 값은 nil)
     
        - returns:
            URLRequest 리턴 (실패 시, error 값 전달)
     */
    static func makeUrlRequest(with url: String, method: URLMethod = .POST, param: [String: Any]? = nil) -> Single<URLRequest> {
        
        return .create { observer in
            guard let validURL = URL(string: url) else {
                observer(.failure(RxError.noElements))
                
                return
            }
            
            let urlRequest = URLRequest(url: validURL, method: method)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = JSONEncoder().encode(param) ?? nil
            
            observer(.success(urlRequest))
            
            return Disposables.create()
        }
    }
    
    static func request(with urlRequest: URLRequest) -> Single<NetworkReturnModel> {
        
        return .create { observer in
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let httpRespone = response as? HTTPURLResponse else { return }
                
                if let error {
                    observer(.failure(error))
                    
                    return
                }
                
                guard let data else { return }
                
                observer(.success(.init(data: data, statusCode: httpRespone.statusCode)))
            }
            
            return Disposables.create()
        }
    }
}
