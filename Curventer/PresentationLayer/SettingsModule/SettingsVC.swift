import Foundation
import UIKit

class SettingsVC: UIViewController {
    // MARK: - Properties
    var currencies: [String] = []
    
    // MARK: - View lifecycle method's
    override func loadView() {
        let settingsView = SettingsView()
        settingsView.updateCurrencies(with: currencies)
        
        self.view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Helper methods
    public func setCurrencies(with data: [String]) {
        currencies = data
    }
}
