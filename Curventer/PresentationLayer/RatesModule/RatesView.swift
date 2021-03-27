import Foundation
import UIKit
import SnapKit

class RatesView: UIView {
    // MARK: - Properties
    var rates: [Currency] = []
    var favorites: [Currency] = []
    var currencies: [String] {
        var array = rates + favorites
        array.sort {
            $0.name < $1.name
        }
        return array.map {
            $0.name
        }
    }
    var delegate: RatesViewControllerDelegate?
    
    
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 75
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "currencyCell")
        
        return tableView
    }()
    
    lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(settingMenu))
        
        return button
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
    
    private func removeCurrency(from array: inout [Currency], at index: Int) {
        array.remove(at: index)
    }
    
    private func updateFavorite(with rate: Currency) {
        favorites.append(rate)
        favorites.sort {
            $0.name < $1.name
        }
        tableView.reloadData()
    }
    
    private func updateRates(with rate: Currency) {
        rates.append(rate)
        rates.sort {
            $0.name < $1.name
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Helper method
    public func updateTable(with rate: [Currency]) {
        rates = rate
        rates.sort {
            $0.name < $1.name
        }
        tableView.reloadData()
    }
    
    @objc func settingMenu() {
        delegate?.presentSettingsVC(with: currencies)
    }
}


// MARK: - Extensions
extension RatesView: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
       
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
       case 0:
        if favorites.count == 0 {
            return ""
        } else {
           return "Favourite"
        }
       case 1:
           return "Rates"
       default:
           return ""
       }
    }
       
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch section {
       case 0:
           return favorites.count
       case 1:
           return rates.count
       default:
           return 0
       }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
       
       switch indexPath.section {
       case 0:
           let currency = favorites[indexPath.row]
           cell.update(with: currency)
           return cell
       case 1:
           let currency = rates[indexPath.row]
           cell.update(with: currency)
           return cell
       default:
           return cell
       }
   }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Swipe to add to favourite
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        
        // Define actions
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completion) in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.updateFavorite(with: weakSelf.rates[indexPath.row])
            
            weakSelf.removeCurrency(from: &weakSelf.rates, at: indexPath.row)
            weakSelf.tableView.deleteRows(at: [indexPath], with: .top)
            completion(true)
        }
        favoriteAction.backgroundColor = .systemOrange
        favoriteAction.image = UIImage(systemName: "star")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.updateRates(with: weakSelf.favorites[indexPath.row])
            weakSelf.removeCurrency(from: &weakSelf.favorites, at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        deleteAction.backgroundColor = .systemRed
        
        // Setup actions for different sections
        switch indexPath.section {
        case 0:
            actions.append(deleteAction)
        case 1:
            actions.append(favoriteAction)
        default:
            print("OUT OF SECTION!")
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: actions)
        
        return swipeActions
    }
}
