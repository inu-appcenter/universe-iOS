//
//  request.swift
//  universe
//
//  Created by 은구 on 2021/08/26.
//

import UIKit

struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}
