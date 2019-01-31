//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
import Foundation

let authController = AuthController()
var routes = Routes()

func handler(request: HTTPRequest, response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: "<html><title>Registration</title><body>Registration</body></html>")
	response.completed()
}

routes.add(method: .get, uri: "/registeruser", handler: authController.register)
routes.add(method: .get, uri: "/login", handler: authController.login)

do {
    try HTTPServer.launch(name: "localhost",
                          port: 8181,
                          routes: routes,
                          responseFilters: [
                            (PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])
} catch {
    fatalError("Network error - \(error)")
}

// При ответе с ошибкой
func returnError(errorMessage: String, response: HTTPResponse) -> Void {
    do {
        try response.setBody(json: [
            "result": 0,
            "errorMessage": errorMessage
            ])
            .completed()
    } catch {
        response.completed(status: HTTPResponseStatus.custom(code: 500, message: "Parse data error - \(error)"))
    }
}
