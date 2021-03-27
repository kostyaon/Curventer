import Foundation
import UIKit

class ConvertVC: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - View lifecycle methods
    override func loadView() {
        let convertView = ConvertView()
        navigationItem.rightBarButtonItem = convertView.settingsButton
        
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
    
    @objc func settingMenu() {
        let currencies = (self.view as? ConvertView)?.getCurrencies()
        
        let vc = SettingsVC()
        vc.setCurrencies(with: currencies ?? [])
        
        self.present(vc, animated: true, completion: nil)
    }
}
