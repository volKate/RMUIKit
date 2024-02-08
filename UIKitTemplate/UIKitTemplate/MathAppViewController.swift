// MathAppViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MathApp main screen
final class MathAppViewController: UIViewController {
    private let calculator = Calculator()
    private var operands = (first: 0, second: 0)

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

    private lazy var greetingAlert: UIAlertController = makeAlert(title: Constants.Alert.Greeting.title)
    private lazy var calcInputAlert: UIAlertController = makeAlert(title: Constants.Alert.Calc.inputTitle)
    private lazy var operationAlert: UIAlertController = makeAlert(title: Constants.Alert.Calc.operationTitle)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bg)

        prepareGreetingAlert()
        prepareInputCalcAlert()
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
    }

    private func prepareGreetingAlert() {
        greetingAlert.addTextField { $0.placeholder = Constants.Alert.Greeting.TextField.name.rawValue }

        greetingAlert.addAction(UIAlertAction(
            title: Constants.Alert.Greeting.Action.done.rawValue,
            style: .default
        ) { [unowned self] _ in
            greetingLabel.text = "Приветствую, \(greetingAlert.textFields?.first?.text ?? "User")!"
            view.addSubview(greetingLabel)
            bg.frame = CGRect(
                x: 0,
                y: greetingLabel.frame.minY,
                width: view.bounds.width,
                height: view.bounds.height - greetingLabel.frame.minY
            )
        })
    }

    private func prepareInputCalcAlert() {
        calcInputAlert.addTextField { $0.placeholder = Constants.Alert.Calc.TextField.firstOperand.rawValue }
        calcInputAlert.addTextField { $0.placeholder = Constants.Alert.Calc.TextField.secondOperand.rawValue }

        let chooseOprationAction = UIAlertAction(
            title: Constants.Alert.Calc.InputAction.chooseOperation.rawValue,
            style: .default
        ) { [unowned self] _ in
            if let fields = calcInputAlert.textFields, fields.count == 2 {
                if let firstOperand = Int(fields.first?.text ?? ""), let secondOperand = Int(fields.last?.text ?? "") {
                    operands = (firstOperand, secondOperand)
                    prepareOperationAlert()
                    present(operationAlert, animated: true)
                    return
                }
            }

            runCalculator()
        }
        let cancelAction = UIAlertAction(
            title: Constants.Alert.cancelTitle,
            style: .default
        )
        calcInputAlert.addAction(chooseOprationAction)
        calcInputAlert.addAction(cancelAction)
    }

    private func prepareOperationAlert() {
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
                    // prepare next alert with result
                    print(result)
                }
            }
            operationAlert.addAction(action)
        }
    }

    @objc private func runCalculator() {
        present(calcInputAlert, animated: true)
    }

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
