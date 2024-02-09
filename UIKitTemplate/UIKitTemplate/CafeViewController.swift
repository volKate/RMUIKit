// CafeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cafe View
class CafeViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var reservationSettings: [UISwitch]!

    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.forEach { $0.delegate = self }
    }

    @IBAction func switchChangedValue(_ sender: UISwitch) {
        let allOn = reservationSettings.allSatisfy(\.isOn)
        print(allOn)
        if allOn {
            reservationSettings.filter { $0 != sender }.randomElement()?.setOn(false, animated: true)
        }
    }

    @IBAction func checkoutTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Выставить счет?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let checkoutAction = UIAlertAction(title: "Чек", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(checkoutAction)
        alert.preferredAction = checkoutAction

        present(alert, animated: true)
    }
}

extension CafeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
