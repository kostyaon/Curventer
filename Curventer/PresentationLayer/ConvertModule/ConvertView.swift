import Foundation
import UIKit
import SnapKit

class ConvertView: UIView {
    // MARK: - Properties
    var currencies: [String] = []
    var selectedBase: String?
    var selectedSymbol: String?
    
    
    // MARK: - Views
    private lazy var currencyPicker: UIPickerView = {
       let picker = UIPickerView()
        
        picker.dataSource = self
        picker.delegate = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .green
        
        return picker
    }()
    
    lazy var amountField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .darkText
        textField.textAlignment = .center
        
        textField.backgroundColor = .red
        
        return textField
    }()
    
    lazy var resultField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .darkText
        textField.textAlignment = .center
        
        textField.backgroundColor = .green
        
        return textField
    }()
    
    
    lazy var baseField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.inputView = self.currencyPicker
        
        //TODO: Remove it
        textField.backgroundColor = .red
        textField.text = "USD"
        
        return textField
    }()
    
    lazy var symbolField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.inputView = self.currencyPicker
        
        textField.backgroundColor = .green
        
        return textField
    }()
    
    lazy var convertButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Convert", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(convertCurrency), for: .touchUpInside)
        button.backgroundColor = .blue
        
        return button
    }()
    
    
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
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
            make.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(200)
            make.height.equalTo(25)
            make.width.equalTo(200)
            
        }
        
        // resultField setup
        addSubview(resultField)
        resultField.snp.makeConstraints { make in
            make.top.equalTo(amountField.snp.bottom).offset(30)
            make.left.right.equalTo(amountField)
        }
        
        // baseField setup
        addSubview(baseField)
        baseField.snp.makeConstraints { make in
            make.left.equalTo(amountField.snp.right).offset(15)
            make.top.bottom.equalTo(amountField)
            make.width.equalTo(50)
        }
        
        // symbolField setup
        addSubview(symbolField)
        symbolField.snp.makeConstraints { make in
            make.left.equalTo(resultField.snp.right).offset(15)
            make.top.bottom.equalTo(resultField)
            make.width.equalTo(50)
        }
        
        // convertButton setup
        addSubview(convertButton)
        convertButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(resultField.snp.bottom).offset(70)
            make.left.equalToSuperview().offset(150)
        }
    }
    
    
    @objc private func convertCurrency() {
        //Fetch exchangeValue
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchRateOnBaseSymbol(baseField.text ?? "USD", symbolField.text ?? "USD")) { result in
            switch result {
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            case .success(let rate):
                let value = rate.rates.first?.value ?? 0
                let convertedValue = (self.amountField.text! as NSString).doubleValue * value
                self.resultField.placeholder = "\(convertedValue)"
            }
        }
    }
    
        
    // MARK: - Helper methods
    func updateCurrencies(with currencyArray: [String]) {
        currencies = currencyArray
        currencyPicker.reloadAllComponents()
    }
}


// MARK: - Extensions
extension ConvertView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBase = currencies[row]
        symbolField.text = selectedBase
    }
}
