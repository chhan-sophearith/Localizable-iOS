//
//  ViewController.swift
//  Localizable-iOS
//
//  Created by Chhan Sophearith on 10/3/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFiled: UITextField!
    let pickerView = UIPickerView()
    let data = [PickerModel(code: "en", name: "English"), PickerModel(code: "km", name: "Khmer"), PickerModel(code: "vi", name: "Vietnam")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupView() {
        textFiled.text = "Tap to choose language"
        textFiled.inputView = pickerView
        textFiled.tintColor = .clear
        textFiled.textAlignment = .center
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    func changeLanguage(lang: String) {
        textFiled.text = "i_am_a_ios_developer".localizeString(string: lang)
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = data[row].name
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let code = data[row].code
        self.changeLanguage(lang: code)
    }
}

extension String {
    func localizeString(string: String) -> String {
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
