//
//  NetworkProvider.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/13.
//

import RxSwift
import Moya

struct NetworkProvider<T: TargetType> {
    
    typealias Service = T
    
    private let service = MoyaProvider<Service>()
    
    func request(with section: Service) -> Single<NetworkReturnModel> {
        
        return Single<NetworkReturnModel>.create { observer -> Disposable in
            
            self.service.request(section) { result in
                switch result {
                case .success(let response):
                    let model = NetworkReturnModel(data: response.data, statusCode: response.statusCode)
                    observer(.success(model))
                    
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
