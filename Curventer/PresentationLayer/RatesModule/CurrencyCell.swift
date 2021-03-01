import Foundation
import UIKit

class CurrencyCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    // MARK: - Actions
    @IBAction func addToFavourite() {
        
    }
    
    
    // MARK: - Helper methods
    func update(for currency: Currency) {
        currencyLabel.text = currency.name
        rateLabel.text = "\(currency.value)"
    }
}

