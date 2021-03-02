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
        let rateColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = rateColor
        label.textAlignment = .left
        
        return label
    }()
    
    let favButton: UIButton = {
        let button = UIButton(type: .system)
        let starImage = UIImage(systemName: "star")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(starImage, for: .normal)
        button.tintColor = .systemOrange
        
        return button
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
        addSubview(favButton)
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
        
        // favButton constraints
        NSLayoutConstraint.activate([
            favButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -6),
            favButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 12),
            favButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -12.5)
        ])
    }
    
    
    // MARK: - Helper methods
    func update(for currency: Currency) {
        currencyLabel.text = currency.name
        rateLabel.text = "\(currency.value)"
    }
}

