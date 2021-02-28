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
 
        RateAPIManager.shared.fetchAllRates(base: "USD"){rates in
            print("RATES: \(rates)")
            self.allRates = rates
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helper methods
}

// MARK: - TableViewDelegates
extension RatesVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRates?.rates.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
      
        return cell
    }
}
