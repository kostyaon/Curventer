import Foundation
import UIKit

class RatesDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    var rates: [Currency] = []
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        
        let currency = rates[indexPath.row]
        cell.update(with: currency)
        
        return cell
    }
}
