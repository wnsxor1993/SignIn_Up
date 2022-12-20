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
    
    static func makeUrlRequest(with url: String, method: URLMethod = .POST) -> Single<URLRequest> {
        
        return .create { observer in
            guard let validURL = URL(string: url) else {
                observer(.failure(RxError.noElements))
                
                return
            }
            
            let urlRequest = URLRequest(url: validURL, method: method)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
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
