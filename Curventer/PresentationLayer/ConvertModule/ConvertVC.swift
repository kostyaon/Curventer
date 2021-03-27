import Foundation
import UIKit

// MARK: - Protocols
protocol ConvertViewControllerDelegate {
    func presentingSettingsVC(with currencies: [String])
}


class ConvertVC: UIViewController {
    // MARK: - Properties
    
    
    
    // MARK: - View lifecycle methods
    override func loadView() {
        let convertView = ConvertView()
        navigationItem.rightBarButtonItem = convertView.settingsButton
        
        self.view = convertView
        convertView.delegate = self
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

// MARK: - Extensions
extension ConvertVC: ConvertViewControllerDelegate {
    func presentingSettingsVC(with currencies: [String]) {
        let vc = SettingsVC()
        vc.setCurrencies(with: currencies)
        vc.delegate = RatesVC()
        
        self.present(vc, animated: true, completion: nil)
    }
}
