// AddReminderViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the new reminder creation form
final class AddReminderViewController: UIViewController {
    // MARK: - Visual Components

    private lazy var avatarPickerView: UIImageView = {
        let image = UIImageView(image: .avatarPlaceholder)
        image.frame = CGRect(x: 125, y: 66, width: 125, height: 125)
        return image
    }()

    private lazy var choosePhotoButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("Change photo", attributes: AttributeContainer([
            .font: UIFont(name: "Verdana", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .textEffect: NSTextAlignment.center
        ]))
        let button = UIButton(configuration: config)
        button.frame = CGRect(x: 0, y: 199, width: view.bounds.width, height: 20)
        return button
    }()

    private lazy var nameTextFieldLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Name Surname")
        label.frame = CGRect(x: 20, y: 239, width: 335, height: 19)
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let field = UnderlinedTextField()
        field.placeholder = "Typing Name Surname"
        field.frame = CGRect(x: 20, y: 268, width: 335, height: 17)
        field.delegate = self
        field.addTarget(self, action: #selector(updateFullName), for: .editingChanged)
        return field
    }()

    private lazy var birthdayTextFieldLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Birthday")
        label.frame = CGRect(x: 20, y: 314, width: 335, height: 19)
        return label
    }()

    private lazy var birthdayPickerTextField: UITextField = {
        let field = UnderlinedTextField()
        field.placeholder = "Typing Date of Birth"
        field.frame = CGRect(x: 20, y: 343, width: 335, height: 19)

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(updateBirthDate(_:)), for: .valueChanged)

        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let okButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(finishPicking))
        toolbar.setItems([okButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        field.inputView = datePicker
        field.inputAccessoryView = toolbar

        return field
    }()

    private lazy var ageTextFieldLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Age")
        label.frame = CGRect(x: 20, y: 389, width: 335, height: 19)
        return label
    }()

    private lazy var genderTextFieldLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Gender")
        label.frame = CGRect(x: 20, y: 462, width: 335, height: 19)
        return label
    }()

    private lazy var telegramTextFieldLabel: UILabel = {
        let label = makeTextFieldLabel(text: "Telegram")
        label.frame = CGRect(x: 20, y: 537, width: 335, height: 19)
        return label
    }()

    private lazy var telegramAlert: UIAlertController = {
        let alert = UIAlertController(title: "Please enter Telegram", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Typing Telegram " }
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            if let telegramText = alert.textFields?.first?.text {
                self?.telegram = telegramText
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(okAction)
        alert.preferredAction = okAction
        return alert
    }()

    private lazy var telegramPickerTextField: UITextField = {
        let field = UnderlinedTextField()
        field.placeholder = "Typing Date of Birth"
        field.frame = CGRect(x: 20, y: 566, width: 335, height: 19)
        field.addTarget(self, action: #selector(editTelegram), for: .editingDidBegin)
        return field
    }()

    private lazy var agePickerView = UIPickerView()
    private lazy var agePickerTextField: UITextField = {
        let field = makePickerTextField(placeholder: "Typing age", picker: agePickerView)
        field.frame = CGRect(x: 20, y: 418, width: 335, height: 19)
        return field
    }()

    private lazy var genderPickerView = UIPickerView()
    private lazy var genderPickerTextField: UITextField = {
        let field = makePickerTextField(placeholder: "Indicate Gender", picker: genderPickerView)
        field.frame = CGRect(x: 20, y: 491, width: 335, height: 19)
        return field
    }()

    // MARK: - Public Properties

    var handleAdd: ((ReminderFormData) -> ())?

    // MARK: - Private Properties

    private var fullName: String = ""
    private var age = 1 {
        didSet {
            agePickerTextField.text = "\(age)"
        }
    }

    private var gender = "Male" {
        didSet {
            genderPickerTextField.text = gender
        }
    }

    private var birthDate = Date.now {
        didSet {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            birthdayPickerTextField.text = formatter.string(from: birthDate)
        }
    }

    private var telegram = "" {
        didSet {
            telegramPickerTextField.text = telegram
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupViews()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .white
        [
            avatarPickerView,
            choosePhotoButton,
            nameTextFieldLabel,
            birthdayTextFieldLabel,
            ageTextFieldLabel,
            genderTextFieldLabel,
            telegramTextFieldLabel,
            agePickerTextField,
            nameTextField, genderPickerTextField, birthdayPickerTextField, telegramPickerTextField
        ].forEach { view.addSubview($0) }
    }

    private func setupNav() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(submitForm))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissForm))
        navigationItem.setRightBarButton(addButton, animated: false)
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }

    // factories
    private func makeTextFieldLabel(text: String) -> UILabel {
        let label = BaseLabel(size: 16, bold: true)
        label.text = text
        return label
    }

    private func makePickerTextField(placeholder: String, picker: UIPickerView) -> UITextField {
        let field = UnderlinedTextField()
        field.placeholder = placeholder
        picker.delegate = self
        picker.dataSource = self
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let okButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(finishPicking))
        toolbar.setItems([okButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        field.inputView = picker
        field.inputAccessoryView = toolbar
        return field
    }

    @objc private func dismissForm() {
        dismiss(animated: true)
    }

    @objc private func finishPicking() {
        [agePickerTextField, genderPickerTextField, birthdayPickerTextField].forEach { $0.resignFirstResponder() }
    }

    @objc private func updateFullName(_ textField: UITextField) {
        fullName = textField.text ?? ""
    }

    @objc private func updateBirthDate(_ datePicker: UIDatePicker) {
        print(datePicker.date)
        birthDate = datePicker.date
    }

    @objc private func editTelegram() {
        present(telegramAlert, animated: true)
    }

    @objc private func submitForm() {
        handleAdd?(ReminderFormData(fullName: fullName, birthday: birthDate, age: age))
        dismissForm()
    }
}

extension AddReminderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddReminderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case agePickerView:
            return 100
        case genderPickerView:
            return 2
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case agePickerView:
            return "\(row + 1)"
        case genderPickerView:
            return row == 0 ? "Male" : "Female"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case agePickerView:
            age = row + 1
        case genderPickerView:
            gender = row == 0 ? "Male" : "Female"
        default:
            break
        }
    }
}
