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
    
    private lazy var symbolPicker: UIPickerView = {
        let picker = UIPickerView()
        
        picker.dataSource = self
        picker.delegate = self
       
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .green
       
       return picker
    }()
    
    lazy var itemsButtonToolbar: [UIBarButtonItem] = {
        var items: [UIBarButtonItem] = []
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        
        items.append(spacer)
        items.append(doneButton)
        
        return items
    }()
    
    
    lazy var pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = .magenta
        toolbar.sizeToFit()
        
        toolbar.setItems(itemsButtonToolbar, animated: true)
        
        return toolbar
    }()
    
    lazy var baseAmountInput: UITextField = {
        let textField = UITextField()
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.placeholder = "1.0"
        
        return textField
    }()
    
    lazy var symbolAmountInput: UITextField = {
        let textField = UITextField()
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.placeholder = "Result"
        
        return textField
    }()
    
    
    lazy var basePickerField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.boldSystemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        
        textField.inputView = self.basePicker
        textField.inputAccessoryView = self.pickerToolbar
        
        //TODO: Remove it
        textField.placeholder = "PLN"
        
        return textField
    }()
    
    lazy var symbolPickerField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.boldSystemFont(ofSize: 35)
        textField.textColor = .darkText
        textField.textAlignment = .center
        
        textField.inputView = self.symbolPicker
        textField.inputAccessoryView = self.pickerToolbar
        
        //TODO: Remove it
        textField.placeholder = "EUR"
        
        return textField
    }()
    
    lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(settingMenu))
        
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
    @objc private func donePicker() {
        basePickerField.resignFirstResponder()
        symbolPickerField.resignFirstResponder()
        convertRate(for: basePickerField.text ?? "USD", to: symbolPickerField.text ?? "USD", amount: baseAmountInput.text!, field: symbolAmountInput)
    }
    
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
    }
    
    private func updateConvertionFields(amount: String, value: Double, field: UITextField) {
        let convertedValue = (amount as NSString).doubleValue * value
        field.text = String(format: "%.2f", convertedValue)
    }
    
    private func convertRate(for base: String, to symbol: String, amount: String, field: UITextField) {
        //Fetch exchangeValue
        RateAPIManager.fetch(type: Rate.self, router: RateRouter.fetchRateOnBaseSymbol(base, symbol)) { result in
            switch result {
            case .failure(let error):
                print("ERROR HANDLER: \(error.localizedDescription)")
                self.baseAmountInput.text = "Error"
                self.symbolAmountInput.text = "Error"
            case .success(let rate):
                let value: Double?
                if base == "" || symbol == "" {
                    value = 0
                } else {
                    value = rate.rates.first?.value ?? 0
                }
                self.updateConvertionFields(amount: amount, value: value!, field: field)
            }
        }
    }
    
        
    // MARK: - Helper methods
    func updateCurrencies(with currencyArray: [String]) {
        currencies = currencyArray
        currencies.sort {
            $0 < $1
        }
        basePicker.reloadAllComponents()
    }
    
    @objc func settingMenu() {
        let vc = SettingsVC()
        vc.setCurrencies(with: currencies)
        
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}


// MARK: - Extensions
// UIPickerDelegate
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
        if pickerView == basePicker {
            basePickerField.text = selectedBase
        } else {
            symbolPickerField.text = selectedBase
        }
    }
}

// UITextFieldDelegate
extension ConvertView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == baseAmountInput {
            convertRate(for: basePickerField.text ?? "USD", to: symbolPickerField.text ?? "USD", amount: baseAmountInput.text!, field: symbolAmountInput)
        } else {
            convertRate(for: symbolPickerField.text ?? "USD", to: basePickerField.text ?? "USD", amount: symbolAmountInput.text!, field: baseAmountInput)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
