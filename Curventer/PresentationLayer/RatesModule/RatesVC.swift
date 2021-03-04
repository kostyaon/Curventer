import UIKit

class RatesVC: UIViewController {
    // MARK: - Properties
    let ratesView = RatesView()
    let dataSource = RatesDataSource()
    
    // MARK: - View lifecycle methods
    override func loadView() {
        ratesView.tableView.dataSource = dataSource
        ratesView.tableView.delegate = self
        self.view = ratesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRates(for: "USD")
    }
    
    
    // MARK: - Helper methods
    private func prepareForDisplay(from rates: [String: Double]) -> [Currency] {
        return rates.map { (key, value) in
            Currency(name: key, value: value)
        }
    }
    
    private func removeCurrency(at index: Int) {
        dataSource.rates.remove(at: index)
    }
    
    private func fetchRates(for base: String) {
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchLatestRatesOnBase(base)) { result in
            switch result {
            case .success(let rate):
                self.dataSource.rates = self.prepareForDisplay(from: rate.rates)
                self.ratesView.updateTable()
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - TableViewDelegates
extension RatesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeCurrency(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
