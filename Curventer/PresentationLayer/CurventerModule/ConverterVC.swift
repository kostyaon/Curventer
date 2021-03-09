import Foundation
import UIKit

class ConverterVC: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - View lifecycle methods
    override func loadView() {
        let converterView = ConverterView()
        self.view = converterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRates(for: "USD")
    }
    
    func convert(from rates: [String: Double], amount: Double) -> [Currency] {
        return rates.map { (key, value) in
            let convertValue = value * amount
            return Currency(name: key, value: convertValue)
        }
            
    }
    
    
    func fetchRates(for base: String) {
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchLatestRatesOnBase(base)) { result in
            switch result {
            case .success(let rate):
                let rates = self.convert(from: rate.rates, amount: 20)
                (self.view as? ConverterView)?.updateTable(with: rates)
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            }
        }
    }
}
