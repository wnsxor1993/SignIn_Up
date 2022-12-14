//
//  NetworkProvider.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/13.
//

import RxSwift
import Moya

struct NetworkProvider {
    
    static func request(with endPoint: EndPoint) -> Single<NetworkReturnModel> {
        var urlRequest = URLRequest(url: endPoint.url)
        urlRequest.httpMethod = endPoint.mehtod.rawValue
        urlRequest.setValue(endPoint.headerValue, forHTTPHeaderField: endPoint.headerType)
        urlRequest.httpBody = endPoint.body
        
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
