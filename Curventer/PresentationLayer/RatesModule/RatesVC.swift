import UIKit

// MARK: - Protocols
protocol RatesViewControllerDelegate {
    func fetchRates(for base: String)
    func presentSettingsVC(with currencies: [String])
}


class RatesVC: UIViewController, RatesViewControllerDelegate {
    // MARK: - View lifecycle methods
    override func loadView() {
        let ratesView = RatesView()
        navigationItem.rightBarButtonItem = ratesView.settingsButton
        
        self.view = ratesView
        ratesView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRates(for: "USD")
    }
    
    
    // MARK: - Private methods
    private func prepareForDisplay(from rates: [String: Double]) -> [Currency] {
        return rates.map { (key, value) in
            Currency(name: key, value: value)
        }
    }
    
    
    // MARK: - Helper methods
    public func fetchRates(for base: String) {
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchLatestRatesOnBase(base)) { result in
            switch result {
            case .success(let rate):
                let rates = self.prepareForDisplay(from: rate.rates)
                (self.view as? RatesView)?.updateTable(with: rates)
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            }
        }
    }
    
    public func presentSettingsVC(with currencies: [String]) {
        let vc = SettingsVC()
        vc.setCurrencies(with: currencies)
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
}
