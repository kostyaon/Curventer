//
//  EndpointType.swift
//  Curventer
//
//  Created by Konstantin on 3/1/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//

import Foundation
import Alamofire

protocol EndpointType {
    var baseURL: String{get}
    var path: String{get}
    var headers: HTTPHeader?{get}
    var parameters: [String: String]?{get}
    var httpMethod: HTTPMethod{get}
    var fullURL: URL{get}
}

