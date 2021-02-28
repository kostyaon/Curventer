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
    var allRates: [Currency] = []
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
 
        RateAPIManager.shared.fetchAllRates(base: "USD"){rates in
            self.allRates = self.convertToCurrency(from: rates.rates)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helper methods
    private func convertToCurrency(from rates: [String: Double]) -> [Currency]{
        var items: [Currency] = []
        for (key, value) in rates{
            items.append(Currency(name: key, value: value))
        }
        return items
    }
    
}

// MARK: - TableViewDelegates
extension RatesVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        let currency = allRates[indexPath.row]
        cell.currencyLabel.text = currency.name
        cell.rateLabel.text = "\(currency.value)"
        return cell
    }
}
