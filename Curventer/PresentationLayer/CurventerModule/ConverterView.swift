import Foundation
import UIKit
import SnapKit

class ConverterView: UIView {
    // MARK: - Properties
    var rates: [Currency] = []
    
    
    // MARK: - Views
    lazy var amountField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.textColor = .black
        textField.textAlignment = .left
        
        textField.text = "TYPING"
        textField.backgroundColor = .green
        
        return textField
    }()
    
    lazy var baseLabel: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.textAlignment = .left
        
        label.backgroundColor = .red
        label.text = "USD"
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 75
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "currencyCell")
        
        return tableView
    }()
    
    
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("There are no storyboards!")
    }
    
    
    // MARK: - Private methods
    private func setupViews() {
        // amountField setup
        addSubview(amountField)
        amountField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(70)
        }
        
        // baseLabel setup
        addSubview(baseLabel)
        baseLabel.snp.makeConstraints { make in
            make.leading.equalTo(amountField.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(amountField.snp.height)
        }
        
        // tableView setup
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(amountField.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: - Helper methods
    func updateTable(with rate: [Currency]) {
        rates = rate
        tableView.reloadData()
    }
    
}


// MARK: - UITableViewDelegate
extension ConverterView: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
               
        let currency = rates[indexPath.row]
        cell.update(with: currency)
               
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
