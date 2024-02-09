// MathAppViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MathApp main screen
final class MathAppViewController: UIViewController {
    private let calculator = Calculator()
    private var operands = (first: 0, second: 0)
    private var guessNum = 0

    // SafeArea
    private var safeAreaInsents: UIEdgeInsets {
        if #available(iOS 15.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if let insets = scene?.windows.first?.safeAreaInsets {
                return insets
            }
        }
        return .zero
    }

    private lazy var bg: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg"))
        image.frame = view.bounds
        return image
    }()

    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Приветствую, "
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.frame = CGRect(x: 0, y: safeAreaInsents.top, width: view.bounds.width, height: 82)
        label.backgroundColor = UIColor(named: "blueNeuteral")
        label.layer.borderColor = CGColor(gray: 1, alpha: 0.8)
        label.layer.borderWidth = 3.0
        return label
    }()

    // Buttons
    private lazy var guessNumButton: UIButton = makeButton(
        title: Constants.Button.GuessNum.label,
        color: Constants.Button.GuessNum.color,
        borderColor: Constants.Button.GuessNum.borderColor
    )

    private lazy var calcButton: UIButton = makeButton(
        title: Constants.Button.Calc.label,
        color: Constants.Button.Calc.color,
        borderColor: Constants.Button.Calc.borderColor
    )

    // Alerts
    private lazy var greetingAlert: UIAlertController = {
        var alert = makeAlert(title: Constants.Alert.Greeting.title)
        alert.addTextField { $0.placeholder = Constants.Alert.Greeting.TextField.name.rawValue }

        alert.addAction(UIAlertAction(
            title: Constants.Alert.Greeting.Action.done.rawValue,
            style: .default
        ) { [unowned self] _ in
            greetingLabel.text = "Приветствую, \(alert.textFields?.first?.text ?? "User")!"
            view.addSubview(greetingLabel)
            bg.frame = CGRect(
                x: 0,
                y: greetingLabel.frame.minY,
                width: view.bounds.width,
                height: view.bounds.height - greetingLabel.frame.minY
            )
        })
        return alert
    }()

    private lazy var calcInputAlert: UIAlertController = {
        var alert = makeAlert(title: Constants.Alert.Calc.inputTitle)
        alert.addTextField { $0.placeholder = Constants.Alert.Calc.TextField.firstOperand.rawValue }
        alert.addTextField { $0.placeholder = Constants.Alert.Calc.TextField.secondOperand.rawValue }

        let chooseOprationAction = UIAlertAction(
            title: Constants.Alert.Calc.InputAction.chooseOperation.rawValue,
            style: .default
        ) { [unowned self] _ in
            if let fields = alert.textFields, fields.count == 2 {
                if let firstOperand = Int(fields.first?.text ?? ""), let secondOperand = Int(fields.last?.text ?? "") {
                    operands = (firstOperand, secondOperand)
                    present(operationAlert, animated: true)
                    return
                }
            }

            resetOperands()
            runCalculator()
        }
        let cancelAction = makeCancelAction { [unowned self] _ in resetOperands() }
        alert.addAction(chooseOprationAction)
        alert.addAction(cancelAction)
        alert.preferredAction = chooseOprationAction
        return alert
    }()

    private lazy var operationAlert: UIAlertController = {
        var alert = makeAlert(title: Constants.Alert.Calc.operationTitle)
        for operationCase in Constants.Alert.Calc.OperationAction.allCases {
            let action = UIAlertAction(
                title: operationCase.rawValue,
                style: .default
            ) { [unowned self] action in
                if let operationCase = Constants.Alert.Calc.OperationAction(rawValue: action.title ?? "") {
                    let result: String
                    switch operationCase {
                    case .sum:
                        result = String(calculator.sum(operands.first, operands.second))
                    case .substract:
                        result = String(calculator.substract(operands.first, operands.second))
                    case .multiply:
                        result = String(calculator.multiply(operands.first, by: operands.second))
                    case .divide:
                        result = String(format: "%.2f", calculator.divide(operands.first, by: operands.second))
                    }

                    calcResultAlert.message = result
                    present(calcResultAlert, animated: true)
                }
            }
            alert.addAction(action)
        }
        let cancelAction = makeCancelAction { [unowned self] _ in resetOperands() }
        alert.addAction(cancelAction)
        alert.preferredAction = cancelAction
        return alert
    }()

    private lazy var calcResultAlert: UIAlertController = {
        var alert = makeAlert(title: Constants.Alert.Calc.resultTitle)
        let cancelAction = makeCancelAction { [unowned self] _ in resetOperands() }
        let okAction = makeOkAction { [unowned self] _ in resetOperands() }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        return alert
    }()

    private lazy var guessInputAlert: UIAlertController = makeGuessAlert(title: Constants.Alert.Guess.inputTitle)
    private lazy var guessIsLessAlert: UIAlertController = makeGuessAlert(
        title: Constants.Alert.Guess.tryArainTitle,
        message: Constants.Alert.Guess.isLessMessage
    )
    private lazy var guessIsGraterAlert: UIAlertController = makeGuessAlert(
        title: Constants.Alert.Guess.tryArainTitle,
        message: Constants.Alert.Guess.isGraterMessage
    )
    private lazy var guessCongratsAlert: UIAlertController = {
        var alert = makeAlert(
            title: Constants.Alert.Guess.congratsTitle,
            message: Constants.Alert.Guess.congratsMessage
        )
        let okAction = makeOkAction { [unowned self] _ in resetOperands() }
        alert.addAction(okAction)
        alert.preferredAction = okAction
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bg)
        prepareButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(greetingAlert, animated: true)
    }

    private func prepareButtons() {
        view.addSubview(guessNumButton)
        view.addSubview(calcButton)

        guessNumButton.frame = CGRect(origin: .zero, size: Constants.Button.GuessNum.size)
        calcButton.frame = CGRect(origin: .zero, size: Constants.Button.Calc.size)
        guessNumButton.center = CGPoint(
            x: view.center.x - Constants.Button.GuessNum.offset.x,
            y: view.center.y - Constants.Button.GuessNum.offset.y
        )
        calcButton.center = CGPoint(
            x: view.center.x - Constants.Button.Calc.offset.x,
            y: view.center.y - Constants.Button.Calc.offset.y
        )

        calcButton.addTarget(self, action: #selector(runCalculator), for: .touchUpInside)
        guessNumButton.addTarget(self, action: #selector(runGuessGame), for: .touchUpInside)
    }

    @objc private func runCalculator() {
        present(calcInputAlert, animated: true)
    }

    @objc private func runGuessGame() {
        resetGuessInput()
        guessNum = Int.random(in: 1 ... 10)
        present(guessInputAlert, animated: true)
    }

    private func checkGuessNum(_ num: Int) {
        if num < 1 || num > 10 {
            runGuessGame()
        } else if num == guessNum {
            present(guessCongratsAlert, animated: true)
        } else if num < guessNum {
            present(guessIsLessAlert, animated: true)
        } else {
            present(guessIsGraterAlert, animated: true)
        }
    }

    private func resetOperands() {
        operands = (0, 0)
        calcInputAlert.textFields?.forEach { $0.text = "" }
    }

    private func resetGuessInput() {
        guessInputAlert.textFields?.forEach { $0.text = "" }
    }

    // Factories
    private func makeAlert(title: String, message: String? = nil) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    private func makeButton(title: String, color: UIColor, borderColor: UIColor) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = Constants.Button.textColor
        config.background.backgroundColor = color
        config.background.strokeWidth = Constants.Button.borderWidth
        config.background.strokeColor = borderColor
        config.cornerStyle = .medium
        var attributedTitle = AttributedString(title)
        attributedTitle.foregroundColor = .white
        attributedTitle.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        config.attributedTitle = attributedTitle
        let button = UIButton(configuration: config)
        return button
    }

    private func makeGuessAlert(title: String, message: String? = nil) -> UIAlertController {
        let alert = makeAlert(title: title, message: message)
        alert.addAction(makeCancelAction { [unowned self] _ in
            resetGuessInput()
        })
        alert.addAction(makeOkAction { [unowned self, unowned alert] _ in
            if let num = Int(alert.textFields?.first?.text ?? "") {
                checkGuessNum(num)
            }
        })
        alert.addTextField { $0.placeholder = Constants.Alert.Guess.textFieldPlaceholder }
        return alert
    }

    private func makeCancelAction(_ completionHandler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        UIAlertAction(title: Constants.Alert.cancelTitle, style: .default, handler: completionHandler)
    }

    private func makeOkAction(_ completionHandler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        UIAlertAction(title: Constants.Alert.okTitle, style: .default, handler: completionHandler)
    }

    // MARK: - Constants

    private enum Constants {
        enum Alert {
            static let cancelTitle = "Отмена"
            static let okTitle = "Ок"

            enum Greeting {
                static let title = "Пожалуйста, представьтесь"
                enum Action: String, CaseIterable {
                    case done = "Готово"
                }

                enum TextField: String {
                    case name = "Введите ваше имя"
                }
            }

            enum Calc {
                static let inputTitle = "Введите ваши числа"
                static let operationTitle = "Выберите математическую операцию"
                static let resultTitle = "Ваш результат"
                enum InputAction: String {
                    case chooseOperation = "Выбрать операцию"
                }

                enum OperationAction: String, CaseIterable {
                    case sum = "Сложить"
                    case substract = "Вычесть"
                    case multiply = "Умножить"
                    case divide = "Разделить"
                }

                enum TextField: String {
                    case firstOperand = "Число 1"
                    case secondOperand = "Число 2"
                }
            }

            enum Guess {
                static let inputTitle = "Угадай число от 1 до 10"
                static let textFieldPlaceholder = "Введите число"
                static let tryArainTitle = "Попробуйте еще раз"
                static let isLessMessage = "Вы ввели слишком маленькое число"
                static let isGraterMessage = "Вы ввели слишком большое число"
                static let congratsTitle = "Поздравляю!"
                static let congratsMessage = "Вы угадали"
            }
        }

        enum Button {
            static let borderWidth = 3.0
            static let textColor = UIColor.white
            enum GuessNum {
                static let label = "Угадай число"
                static let color = UIColor(red: 155.0 / 255, green: 127.0 / 255, blue: 181.0 / 255, alpha: 1)
                static let borderColor = UIColor(red: 76.0 / 255, green: 36.0 / 255, blue: 115.0 / 255, alpha: 1)
                static let size = CGSize(width: 150.0, height: 150.0)
                static let offset = (x: 30.0, y: 55.0)
            }

            enum Calc {
                static let label = "Калькулятор"
                static let color = UIColor(red: 100.0 / 255, green: 181.0 / 255, blue: 130.0 / 255, alpha: 1)
                static let borderColor = UIColor(red: 59.0 / 255, green: 105.0 / 255, blue: 76.0 / 255, alpha: 1)
                static let size = CGSize(width: 200.0, height: 200.0)
                static let offset = (x: -44.0, y: -180.0)
            }
        }
    }
}
