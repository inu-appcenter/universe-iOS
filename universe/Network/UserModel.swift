//
//  UserModel.swift
//  universe
//
//  Created by 은구 on 2021/08/26.
//

import Foundation

final class UserModel {
    struct UserData: Codable {
        let email: String
        let password: String
        let passwordCheck: String
    }
    
    var users: [UserData] = [
    ]
    
    func createUser(email: String, password: String, passwordCheck: String) {
        var newUser: [UserData] = [
            UserData(email: email, password: password, passwordCheck: passwordCheck)
        ]
        

    }
    
}

