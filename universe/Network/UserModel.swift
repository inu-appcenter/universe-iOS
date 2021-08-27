//
//  UserModel.swift
//  universe
//
//  Created by 은구 on 2021/08/26.
//

import UIKit

struct UserData: Codable {
    var email: String
    var password: String
    var passwordCheck: String
    
    init(email: String, password: String, passwordCheck: String) {
        self.email = email
        self.password = password
        self.passwordCheck = passwordCheck
    }
    
    mutating func changeData(email: String, password: String, passwordCheck: String) {
        self.email = email
        self.password = password
        self.passwordCheck = passwordCheck
    }
}

var userData = UserData.init(email: "", password: "", passwordCheck: "")

