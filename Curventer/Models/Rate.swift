//
//  Rate.swift
//  Curventer
//
//  Created by Konstantin on 2/28/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//

import Foundation

struct Rate: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}
