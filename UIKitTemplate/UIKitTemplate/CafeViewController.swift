// CafeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC запрашивающий у юзера информацию о пронировании
class CafeViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet private var reservationSettings: [UISwitch]!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods/@IBAction

    private func setupView() {
        textFields.forEach { $0.delegate = self }
    }

    @IBAction private func switchChangedValue(_ sender: UISwitch) {
        let allOn = reservationSettings.allSatisfy(\.isOn)
        print(allOn)
        if allOn {
            reservationSettings.filter { $0 != sender }.randomElement()?.setOn(false, animated: true)
        }
    }

    @IBAction private func checkoutTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Выставить счет?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let checkoutAction = UIAlertAction(title: "Чек", style: .default) { [unowned self] _ in
            performSegue(withIdentifier: "checkoutSegue", sender: self)
        }
        alert.addAction(cancelAction)
        alert.addAction(checkoutAction)
        alert.preferredAction = checkoutAction

        present(alert, animated: true)
    }
}

extension CafeViewController: UITextFieldDelegate {
    // MARK: - Public Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
