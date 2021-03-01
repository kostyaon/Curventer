//
//  ViewController.swift
//  Curventer
//
//  Created by Konstantin on 2/25/21.
//  Copyright © 2021 Konstantin. All rights reserved.
//
import UIKit

class RatesVC: UITableViewController {
    // Add constant struct
    // MARK: - Properties
    var allRates: [Currency] = []
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
 
        RateAPIManager.shared.fetchRates(type: RateRouter.fetchRatesOnDateOnBase("2020-08-08", "PLN")){rates in
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
    
    private func removeCurrency(at index: Int){
        allRates.remove(at: index)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeCurrency(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
