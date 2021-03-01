//
//  RatesAPIManager.swift
//  Curventer
//
//  Created by Konstantin on 2/28/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//

import Foundation
import Alamofire
        
typealias RequestComplete = (Rate)->Void

struct RateAPIManager{
    static let shared = RateAPIManager()

    /*func fetchRateFor(base: String, exchangeFor symbols: String, completion: @escaping RequestComplete){
        let parameters = ["base": base, "symbols": symbols]
        AF.request(Constants.baseURL, parameters: parameters)
            .responseDecodable(of: Rate.self){ response in
                guard let rates = response.value else {return}
                print(rates.rates)
                completion(rates)
        }
    }*/
    
    func fetchRates(type: EndpointType, completion: @escaping RequestComplete){
        AF.request(type.fullURL, method: type.httpMethod, parameters: type.parameters)
            .responseDecodable(of: Rate.self){response in
                guard let rates = response.value else{return}
                print("ALL RATES: \(rates.rates)")
                completion(rates)
        }
    }
}
