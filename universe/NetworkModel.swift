//
//  NetworkModel.swift
//  universe
//
//  Created by 은구 on 2021/08/22.
//

import UIKit
import Alamofire

let header: HTTPHeaders = []

let jsonheader: HTTPHeaders = [ "Content-Type": "application/json" ]

class NetworkModel {
    let BASE_URL = "http://ec2-13-124-191-131.ap-northeast-2.compute.amazonaws.com:8080"
    
    func isSuccess(statusCode code: Int) -> Bool {
        switch code {
        case 200:
            return true
        default:
            return false
        }
    }
}
