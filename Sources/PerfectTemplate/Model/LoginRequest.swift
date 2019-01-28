//
//  LoginRequest.swift
//  COpenSSL
//
//  Created by Алексей Сигай on 28/01/2019.
//

import Foundation

struct LoginRequest {
    var login: String = ""
    var password: String = ""
    
    init(_ json: [String: AnyObject]) {
        if let login = json["login"] as? String {
            self.login = login
        }
        if let password = json["password"] as? String {
            self.password = password
        }
    }
}
