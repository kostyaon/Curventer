//
//  RateRouter.swift
//  Curventer
//
//  Created by Konstantin on 3/1/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//

import Foundation
import Alamofire

enum RateRouter{
    case fetchLatestRatesOnBase(String)
    case fetchRatesOnDateOnBase(String, String)
}


// MARK: - Extensions
extension RateRouter: EndpointType {
    var baseURL: String {
        switch self {
           default:
            return "https://api.ratesapi.io/api"
        }
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    var path: String {
        switch self {
        case .fetchRatesOnDateOnBase(let date, _):
            return "/\(date)"
        default:
            return "/latest"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .fetchLatestRatesOnBase(let base):
            return ["base": base]
        case .fetchRatesOnDateOnBase(_, let base):
            return ["base": base]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
}

