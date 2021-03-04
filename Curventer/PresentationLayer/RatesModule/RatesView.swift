import Foundation
import UIKit
import SnapKit

class RatesView: UIView {
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()

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
    
    
    // MARK: - Helper method
    public func updateTable() {
        tableView.reloadData()
    }
}
