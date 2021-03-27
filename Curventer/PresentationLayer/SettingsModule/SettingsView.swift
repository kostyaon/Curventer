import Foundation
import UIKit
import SnapKit

class SettingsView: UIView {
    // MARK: - Properties
    var currencies: [String] = []
    var delegate: SettingsViewControllerDelegate?
    
    
    // MARK: - Views
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        
        picker.dataSource = self
        picker.delegate = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .systemRed
        
        return picker
    }()
    
    private lazy var toolbarItems: [UIBarButtonItem] = {
        var items: [UIBarButtonItem] = []
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(performDone))
        
        items.append(spacer)
        items.append(doneButton)
        
        return items
    }()
    
    private lazy var pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        
        
        toolbar.barStyle = .default
        toolbar.tintColor = .magenta
        toolbar.sizeToFit()
        toolbar.setItems(self.toolbarItems, animated: true)
        
        return toolbar
    }()
    
    lazy var baseLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose base:"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .left
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .black
        label.shadowColor = .systemGray
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var baseField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.textColor = .black
        
        textField.inputView = self.picker
        textField.inputAccessoryView = self.pickerToolbar
        
        // TODO: Remove it
        textField.placeholder = "USD"
        
        return textField
    }()
    
    
    // MARK: - init mehotd's
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("There are no storyboards!")
    }
    
    // MARK: - Private methods
    @objc private func performDone() {
        baseField.resignFirstResponder()
        delegate?.dismissController(with: baseField.text ?? "USD")
    }
    
    private func setupViews() {
        // setup settingsLabel
        addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints {
            $0.leftMargin.equalToSuperview().offset(7)
            $0.top.equalToSuperview().offset(30)
        }
        
        // setup baseLabel
        addSubview(baseLabel)
        baseLabel.snp.makeConstraints {
            $0.leftMargin.equalToSuperview().offset(7)
            $0.centerY.equalTo(self.snp.centerY)
            $0.height.equalTo(40)
            $0.width.equalTo(200)
        }
        
        // setup baseField
        addSubview(baseField)
        baseField.snp.makeConstraints {
            $0.centerY.equalTo(baseLabel.snp.centerY)
            $0.left.equalTo(baseLabel.snp.right).offset(5)
        }
    }
    
    
    // MARK: - Helper methods
    public func updateCurrencies(with currenciesArray: [String]) {
        currencies = currenciesArray
        
        picker.reloadAllComponents()
    }
}

// MARK: - Extensions
extension SettingsView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        baseField.text = currencies[row]
    }
}
