//
//  LogoutRequest.swift
//  PerfectTemplate
//
//  Created by Алексей Сигай on 28/01/2019.
//

import Foundation

struct LogoutRequest {
    var id_user: Int = 0
    
    init(_ json: [String: AnyObject]) {
        if let id_user = json["id_user"] as? Int {
            self.id_user = id_user
        }
    }
}
