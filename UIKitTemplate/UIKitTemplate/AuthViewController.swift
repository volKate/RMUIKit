// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// AuthViewController
class AuthViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var eyeButton: UIButton!

    private var email: String = ""
    private var password: String = ""

    private var isEnabled: Bool {
        email == "login@mail.ru" && password == "password"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loginButton.isEnabled = false
    }

    func updateLoginButton() {
        if loginButton.isEnabled != isEnabled {
            loginButton.isEnabled = isEnabled
        }
    }

    @IBAction func loginButtonTouched(_ sender: UIButton) {
        if isEnabled {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    @IBAction func eyeButtonTouched(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let eyeImage = UIImage(
            systemName: passwordField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)
        )
        eyeButton.setImage(eyeImage, for: .normal)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailField:
            email = emailField.text ?? ""
        case passwordField:
            password = passwordField.text ?? ""
        default:
            break
        }
        updateLoginButton()
    }
}
