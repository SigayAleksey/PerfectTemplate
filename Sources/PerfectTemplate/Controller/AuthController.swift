//
//  AuthController.swift
//  PerfectTemplate
//
//  Created by Алексей Сигай on 28/01/2019.
//

import Foundation
import PerfectHTTP

class AuthController {
    
    let register: (HTTPRequest, HTTPResponse) -> () =  { request, response in
        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            let registerRequest = RegisterRequest(json)
            print("Request - \(registerRequest)")
            
            try response.setBody(json: ["result": 1, "userMessage": "Регистрация прошла успешно!"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
    
    let login: (HTTPRequest, HTTPResponse) -> () =  { request, response in
        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            let registerRequest = LoginRequest(json)
            print("Request - \(registerRequest)")
            
            try response.setBody(json: [
                "result": 1,
                "user": [
                    "id_user": 1,
                    "user_login": "Ledmond",
                    "user_name": "Aleksey",
                    "user_lastname": "Sigay"
                ]
            ])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
        }
    }
}
