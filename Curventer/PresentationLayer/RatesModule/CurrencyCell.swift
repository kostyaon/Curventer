import Foundation
import UIKit
import SnapKit

class CurrencyCell: UITableViewCell {
    // MARK: - Views
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        let rateColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = rateColor
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var favButton: UIButton = {
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
    }
  
    required init?(coder: NSCoder) {
        fatalError("There are no storyboards!")
    }
    
    
    // MARK: - Private methods
    private func setupViews() {
         let margins = self.layoutMarginsGuide
        
        // currencyLabel setup
        addSubview(currencyLabel)
        currencyLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(margins)
            make.width.equalTo(138)
        }
        
        // rateLabel setup
        addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyLabel.snp.bottom).offset(2)
            make.leading.equalTo(margins.snp.leading)
            make.trailing.equalTo(margins.snp.trailing).offset(8)
        }
        
        // favButton setup
        addSubview(favButton)
        favButton.snp.makeConstraints { make in
            make.trailing.equalTo(margins.snp.trailing).offset(-6)
            make.top.equalTo(margins.snp.top).offset(12)
            make.bottom.equalTo(margins.snp.bottom).offset(-12.5)
        }
    }
    
    
    // MARK: - Helper methods
    func update(with currency: Currency) {
        currencyLabel.text = currency.name
        rateLabel.text = String(format: "%.3f", currency.value)
    }
}

