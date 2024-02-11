// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Auth screen for signing in
final class AuthViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: .logo)
        image.frame = CGRect(x: 125, y: 70, width: 125, height: 125)
        return image
    }()

    private lazy var appNameLabel: UILabel = {
        let label = BaseLabel(size: 18, bold: true)
        label.frame = CGRect(x: 100, y: 200, width: 175, height: 44)
        label.numberOfLines = 0
        label.textColor = .purpleMain
        label.text = "Birthday\nReminder"
        label.textAlignment = .center
        return label
    }()

    private lazy var signInLabel: UILabel = {
        let label = BaseLabel(size: 26, bold: true)
        label.frame = CGRect(x: 20, y: 266, width: 175, height: 31)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Email")
        label.frame = CGRect(x: 20, y: 318, width: 175, height: 19)
        return label
    }()

    private lazy var passwordLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Password")
        label.frame = CGRect(x: 20, y: 393, width: 175, height: 19)
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let field = UnderlinedTextField()
        field.placeholder = "Typing email"
        field.frame = CGRect(x: 20, y: 347, width: 335, height: 17)
        field.textContentType = .emailAddress
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        return field
    }()

    private lazy var passwordTextField: UITextField = {
        let field = UnderlinedTextField()
        field.placeholder = "Typing password"
        field.frame = CGRect(x: 20, y: 422, width: 335, height: 17)
        field.isSecureTextEntry = true
        field.textContentType = .password
        return field
    }()

    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .grayDarker
        button.frame = CGRect(x: 332, y: 419, width: 22, height: 19)
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.attributedTitle = AttributedString(
            "Login",
            attributes: AttributeContainer([
                .font: UIFont(name: "Verdana-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
            ])
        )
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .redMain
        button.configuration = config
        button.frame = CGRect(x: 20, y: 671, width: 335, height: 44)
        return button
    }()

    private lazy var useFaceIdLabel: UILabel = {
        let label = BaseLabel(size: 16, bold: true)
        label.text = "Use FaceID"
        label.frame = CGRect(x: 86, y: 544, width: 150, height: 35)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private lazy var useFaceIdSwitch: UISwitch = {
        let faceIdSwitch = UISwitch()
        faceIdSwitch.isOn = true
        faceIdSwitch.frame = CGRect(x: 248, y: 544, width: 54, height: 35)
        faceIdSwitch.isHidden = true
        return faceIdSwitch
    }()

    // MARK: - Private Properties

    private var email: String = "" {
        didSet {
            updateUI()
        }
    }

    private var password: String = "" {
        didSet {
            updateUI()
        }
    }

    private var isValidCredentials: Bool {
        email == "example@mail.ru" && password == "Qwerty1234"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setupViews()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.addSubview(logoImage)
        view.addSubview(appNameLabel)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
        view.addSubview(loginButton)
        view.addSubview(useFaceIdLabel)
        view.addSubview(useFaceIdSwitch)

        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(updateCredentials(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateCredentials(_:)), for: .editingChanged)

        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    private func updateUI() {
        loginButton.isEnabled = isValidCredentials
        useFaceIdLabel.isHidden = !isValidCredentials
        useFaceIdSwitch.isHidden = !isValidCredentials
    }

    @objc private func updateCredentials(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            email = emailTextField.text ?? ""
        case passwordTextField:
            password = passwordTextField.text ?? ""
        default:
            break
        }
    }

    @objc private func login() {
        let birthdaysVC = BirthdaysViewController()
        navigationController?.pushViewController(birthdaysVC, animated: true)
    }

    // factories
    private func makeTextFieldLabel(text: String) -> UILabel {
        let label = BaseLabel(size: 16, bold: true)
        label.text = text
        label.textColor = .redMain
        return label
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
