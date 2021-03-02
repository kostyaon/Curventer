import Foundation
import UIKit

class CurrencyCell: UITableViewCell {
    // MARK: - Views
    let currencyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        let rateColor = UIColor(red: 0, green: 0, blue: 0, alpha: 60)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = rateColor
        label.textAlignment = .left
        
        return label
    }()
    
    
    // MARK: - init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
  
    required init?(coder: NSCoder) {
        fatalError("There are no storyboards!")
    }
    
    
    // MARK: - Private methods
    private func setupViews() {
        addSubview(currencyLabel)
        addSubview(rateLabel)
    }
    
    private func setupConstraints() {
        let margins = self.layoutMarginsGuide
        
        // currencyLabel constraints
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            currencyLabel.widthAnchor.constraint(equalToConstant: 138)
        ])
        
        // rateLabel constraints
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 2),
            rateLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 8)
        ])
    }
    
    
    // MARK: - Helper methods
    func update(for currency: Currency) {
        currencyLabel.text = currency.name
        rateLabel.text = "\(currency.value)"
    }
}

