import Foundation
import UIKit
import SnapKit

class ConvertView: UIView {
    // MARK: - Properties
    var currencies: [String] = []
    var selectedBase: String?
    var selectedSymbol: String?
    
    
    // MARK: - Views
    private lazy var basePicker: UIPickerView = {
       let picker = UIPickerView()
        
        picker.dataSource = self
        picker.delegate = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .green
        
        return picker
    }()
    
    lazy var baseAmountInput: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.placeholder = "1.0"
        
        return textField
    }()
    
    lazy var symbolAmountInput: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.placeholder = "Result"
        
        return textField
    }()
    
    
    lazy var basePickerField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.boldSystemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.inputView = self.basePicker
        
        //TODO: Remove it
        textField.text = "PLN"
        
        return textField
    }()
    
    lazy var symbolPickerField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.boldSystemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.inputView = self.basePicker
        
        //TODO: Remove it
        textField.placeholder = "EUR"
        
        return textField
    }()
    
    lazy var swapButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Swap", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(swapCurrincies), for: .touchUpInside)
        button.backgroundColor = .blue
        
       return button
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
        // basePickerField setup
        addSubview(basePickerField)
        basePickerField.snp.makeConstraints {
            $0.left.equalTo(self.snp_leftMargin)
            $0.bottom.equalTo(self.snp.centerY).offset(-75)
        }
        
        // symbolPickerField setup
        addSubview(symbolPickerField)
        symbolPickerField.snp.makeConstraints {
            $0.left.equalTo(basePickerField.snp.left)
            $0.top.equalTo(self.snp.centerY).offset(65)
        }
        
        // symbolAmountField setup
        addSubview(symbolAmountInput)
        symbolAmountInput.snp.makeConstraints {
            $0.left.equalTo(symbolPickerField.snp.right).offset(8)
            $0.top.equalTo(symbolPickerField)
            $0.width.equalTo(245)
        }
        
        // baseAmountField setup
        addSubview(baseAmountInput)
        baseAmountInput.snp.makeConstraints {
            $0.left.equalTo(basePickerField.snp.right).offset(8)
            $0.bottom.equalTo(basePickerField)
            $0.width.equalTo(245)
        }
        
        // convertButton setup
        addSubview(convertButton)
        convertButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.centerY.equalTo(self.snp.centerY).offset(-6.25)
            $0.centerX.equalTo(self.snp.centerX).offset(55)
        }
        
        // swapButton setup
        addSubview(swapButton)
        swapButton.snp.makeConstraints {
            $0.height.equalTo(convertButton.snp.height)
            $0.centerY.equalTo(convertButton.snp.centerY)
            $0.left.equalTo(self.snp_leftMargin).offset(30)
        }
    }
    
    @objc private func swapCurrincies() {
        
    }
    
    @objc private func convertCurrency() {
        //Fetch exchangeValue
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchRateOnBaseSymbol(basePickerField.text ?? "USD", symbolPickerField.text ?? "USD")) { result in
            switch result {
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
            case .success(let rate):
                let value = rate.rates.first?.value ?? 0
                let convertedValue = (self.baseAmountInput.text! as NSString).doubleValue * value
                self.symbolAmountInput.placeholder = "\(convertedValue)"
            }
        }
    }
    
        
    // MARK: - Helper methods
    func updateCurrencies(with currencyArray: [String]) {
        currencies = currencyArray
        basePicker.reloadAllComponents()
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
        symbolPickerField.text = selectedBase
    }
}
