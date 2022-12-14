//
//  EndPoint.swift
//  SignIn_Up
//
//  Created by Zeto on 2022/12/14.
//

import Foundation

public struct EndPoint {

    let mehtod: HTTPMethod
    let headerType: String = "Content-Type"
    let headerValue: String = "application/json"
    let body: Data?
    let urlConfigure: URLConfigure

    init(urlConfigure: URLConfigure, method: HTTPMethod, body: Data? = nil) {
        self.urlConfigure = urlConfigure
        self.mehtod = method
        self.body = body
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = urlConfigure.scheme
        components.host = urlConfigure.host
        components.path = urlConfigure.path ?? ""
        components.queryItems = urlConfigure.queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
        )}
        
        return url
    }
}
