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

class RateAPIManager{
    static let shared = RateAPIManager()
    
    let baseUrl = "https://api.ratesapi.io/api/latest"

    func fetchRateFor(base: String, exchangeFor symbols: String, completion: @escaping RequestComplete){
        let parameters = ["base": base, "symbols": symbols]
        AF.request(baseUrl, parameters: parameters)
            .responseDecodable(of: Rate.self){ response in
                guard let rates = response.value else {return}
                print(rates.rates)
                completion(rates)
        }
    }
    
    func fetchAllRates(base: String, completion: @escaping RequestComplete){
        let parameters = ["base": base]
        AF.request(baseUrl, parameters: parameters)
            .responseDecodable(of: Rate.self){response in
                guard let rates = response.value else{return}
                print("ALL RATES: \(rates.rates)")
                completion(rates)
        }
    }
}
