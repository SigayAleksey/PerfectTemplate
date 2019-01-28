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

func handler(request: HTTPRequest, response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: "<html><title>Registration</title><body>Registration</body></html>")
	response.completed()
}
let server = HTTPServer()
let authController = AuthController()
var routes = Routes()

routes.add(method: .post, uri: "/register", handler: authController.register)
routes.add(method: .get, uri: "/login", handler: authController.login)

server.addRoutes(routes)
server.serverPort = 8080

do {
    try server.start()
} catch {
    fatalError("Network error - \(error)")
}


//routes.add(method: .get, uri: "/", handler: handler)
//routes.add(method: .get, uri: "/**",
//           handler: StaticFileHandler(documentRoot: "./webroot", allowResponseFilters: true).handleRequest)
//try HTTPServer.launch(name: "localhost",
//                      port: 8181,
//                      routes: routes,
//                      responseFilters: [
//                        (PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)])

