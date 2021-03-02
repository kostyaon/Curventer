import UIKit

class RatesVC: UITableViewController {
    // MARK: - Properties
    var allRates: [Currency] = []
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig()
        fetchRates(for: "USD")
    }
    
    
    // MARK: - Helper methods
    private func prepareForDisplay(from rates: [String: Double]) -> [Currency] {
        return rates.map { (key, value) in
            Currency(name: key, value: value)
        }
    }
    
    private func removeCurrency(at index: Int) {
        allRates.remove(at: index)
    }
    
    private func tableViewConfig() {
        tableView.rowHeight = 75
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "currencyCell")
    }
    
    private func fetchRates(for base: String) {
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchLatestRatesOnBase(base)) { result in
            switch result {
            case .success(let rate):
                self.allRates = self.prepareForDisplay(from: rate.rates)
                self.tableView.reloadData()
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - TableViewDelegates
extension RatesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        
        let currency = allRates[indexPath.row]
        cell.update(for: currency)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeCurrency(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
