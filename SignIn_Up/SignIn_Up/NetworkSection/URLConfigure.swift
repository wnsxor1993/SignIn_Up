//
//  URLConfigure.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import Foundation

public struct URLConfigure {
    
    let scheme = "https"
    let host: String
    let path: String?
    let queryItems: [URLQueryItem]?
    
    init(host: String, path: String?, queryItems: [URLQueryItem]?) {
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}
