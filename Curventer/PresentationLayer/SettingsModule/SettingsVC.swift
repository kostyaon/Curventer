import Foundation
import UIKit

class SettingsVC: UIViewController {
    // MARK: - Properties
    var currencies: [String] = []
    
    // MARK: - View lifecycle method's
    override func loadView() {
        let settingsView = SettingsView()
        self.view = settingsView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.view as? SettingsView)?.updateCurrencies(with: currencies)
    }
    
    // MARK: - Helper methods
}
