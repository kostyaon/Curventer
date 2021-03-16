import Foundation
import UIKit

class ConvertVC: UIViewController {
    // MARK: - View lifecycle methods
    override func loadView() {
        let convertView = ConvertView()
        self.view = convertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrencies()
    }
    
    
    // MARK: - Helper methods
    private func convertToCurrinciesArray(from rates: [String: Double]) -> [String] {
        let currincies: [String]
        currincies = rates.keys.map { key in
            key
        }
        print(currincies)
        return currincies
    }
    
    private func fetchCurrencies() {
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchLatestRatesOnBase("USD")) { result in
            switch result {
            case .success(let rate):
                let currencies: [String]
                currencies = self.convertToCurrinciesArray(from: rate.rates)
                (self.view as? ConvertView)?.updateCurrencies(with: currencies)
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            }
        }
    }
    
}
