// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC отображающий экран входа в приложение
final class AuthViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var eyeButton: UIButton!

    // MARK: - Private Properties

    private var email: String = ""
    private var password: String = ""

    private var isEnabled: Bool {
        email == "login@mail.ru" && password == "password"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loginButton.isEnabled = false
    }

    private func updateLoginButton() {
        if loginButton.isEnabled != isEnabled {
            loginButton.isEnabled = isEnabled
        }
    }

    // MARK: - Private Methods/@IBAction

    private func setupView() {
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction private func loginButtonTouched(_ sender: UIButton) {
        if isEnabled {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    @IBAction private func eyeButtonTouched(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let eyeImage = UIImage(
            systemName: passwordField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)
        )
        eyeButton.setImage(eyeImage, for: .normal)
    }
}

extension AuthViewController: UITextFieldDelegate {
    // MARK: - Public Delegate Methods

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
