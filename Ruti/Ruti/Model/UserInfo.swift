//
//  UserInfo.swift
//  Ruti
//
//  Created by leeyeon2 on 5/22/24.
//

import Foundation

struct UserInfo {
    static var memberId: Int = UserDefaults.standard.integer(forKey: "memberId")
    static var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    static var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    static var token: String = String(UserDefaults.standard.string(forKey: "token") ?? "")
    
    init() {
        UserInfo.memberId = 0
        UserInfo.email = ""
        UserInfo.name = ""
        UserInfo.token = ""
    }
}

struct Account: Codable {
    var email: String
    var name: String
}
