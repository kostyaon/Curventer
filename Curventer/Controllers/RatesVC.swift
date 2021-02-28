//
//  ViewController.swift
//  Curventer
//
//  Created by Konstantin on 2/25/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//
import UIKit

class RatesVC: UITableViewController {
    // MARK: - Properties
    var allRates: Rate?
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        RateAPIManager.shared.fetchRateFor(base: "USD", exchangeFor: "EUR"){rates in
            print(rates.rates["CAD"] ?? "NO CAD")
        }
        
        RateAPIManager.shared.fetchAllRates(base: "USD"){rates in
            print(rates.rates["RUR"] ?? "NO RUR")
            self.allRates = rates
        }
    }
    
    // MARK: - Helper methods
}

// MARK: - TableViewDelegates
extension RatesVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRates?.rates.count ?? 1
    }
    

}
