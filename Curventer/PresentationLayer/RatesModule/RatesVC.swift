import UIKit

class RatesVC: UIViewController {
    // MARK: - View lifecycle methods
    override func loadView() {
        let ratesView = RatesView()
        navigationItem.rightBarButtonItem = ratesView.settingsButton
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
    
    private func fetchRates(for base: String) {
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
    
    @objc func settingMenu() {
        let currencies = (self.view as? ConvertView)?.getCurrencies()
        
        let vc = SettingsVC()
        vc.setCurrencies(with: currencies ?? [])
        
        self.present(vc, animated: true, completion: nil)
    }
}
