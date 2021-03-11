import Foundation
import UIKit
import SnapKit

class RatesView: UIView {
    // MARK: - Properties
    var rates: [Currency] = []
    
    
    // MARK: - Views
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
        // Setup tableView
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func removeCurrency(at index: Int) {
        rates.remove(at: index)
    }
    
    
    // MARK: - Helper method
    public func updateTable(with rate: [Currency]) {
        rates = rate
        tableView.reloadData()
    }
}


// MARK: - Extensions
extension RatesView: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeCurrency(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
