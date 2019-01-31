//
//  AuthController.swift
//  PerfectTemplate
//
//  Created by Алексей Сигай on 28/01/2019.
//

import Foundation
import PerfectHTTP

class AuthController {
    
//    let register: (HTTPRequest, HTTPResponse) -> () =  { request, response in
//        guard let str = request.postBodyString, let data = str.data(using: .utf8) else {
//            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Wrong user data"))
//            return
//        }
//
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
//            let registerRequest = RegisterRequest(json)
//            print("Request - \(registerRequest)")
//
//            try response.setBody(json: ["result": 1, "userMessage": "Регистрация прошла успешно!"])
//            response.completed()
//        } catch {
//            response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
//        }
//    }
    
    let register: (HTTPRequest, HTTPResponse) -> () =  { request, response in
        guard let userId = request.param(name: "id_user") else {
            returnError(errorMessage: "There is no user id in the request", response: response)
            return
        }
        guard Int(userId) != nil else {
            returnError(errorMessage: "Invalid user id", response: response)
            return
        }
        if request.param(name: "username") != nil && request.param(name: "password") != nil && request.param(name: "email") != nil && request.param(name: "gender") != nil && request.param(name: "credit_card") != nil && request.param(name: "bio") != nil {
            do {
                try response.setBody(json: [
                    "result": 1,
                    "userMessage": "Registration was successful"
                    ])
                    .completed()
            } catch {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
            }
        } else {
            returnError(errorMessage: "There are blank fields in the request", response: response)
        }
    }
    
    
    let login: (HTTPRequest, HTTPResponse) -> () =  { request, response in
        if request.param(name: "username") == "Ledmond" && request.param(name: "password") == "Pa$$w0rd" {
            do {
                try response.setBody(json: [
                    "result": 1,
                    "user": [
                        "id_user": 1,
                        "user_login": "Ledmond",
                        "user_name": "Aleksey",
                        "user_lastname": "Sigay"
                    ]
                    ])
                    .completed()
            } catch {
                response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
            }
        } else {
            returnError(errorMessage: "Invalid login or password", response: response)
        }
    }
}
