import Foundation
import UIKit

// MARK: - Protocols
protocol SettingsViewControllerDelegate {
     func dismissController(with currency: String)
}

class SettingsVC: UIViewController {
    // MARK: - Properties
    var currencies: [String] = []
    var delegate: RatesViewControllerDelegate?
    
    
    // MARK: - View lifecycle method's
    override func loadView() {
        let settingsView = SettingsView()
        settingsView.updateCurrencies(with: currencies)
        
        self.view = settingsView
        settingsView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    // MARK: - Helper methods
    public func setCurrencies(with data: [String]) {
        currencies = data
    }
}

// MARK: - Extensions
extension SettingsVC: SettingsViewControllerDelegate {
    func dismissController(with currency: String) {
        dismiss(animated: true, completion: {
            self.delegate?.fetchRates(for: currency)
        })
    }
}
