// MathAppViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MathApp main screen
final class MathAppViewController: UIViewController {
    private var safeAreaInsents: UIEdgeInsets {
        if #available(iOS 15.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if let insets = scene?.windows.first?.safeAreaInsets {
                return insets
            }
        }
        return .zero
    }

    lazy var bg: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bg"))
        image.frame = view.bounds
        return image
    }()

    lazy var greetingLabel: UILabel = {
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

    lazy var guessNumButton: UIButton = makeButton(
        title: Constants.Button.GuessNum.label,
        color: Constants.Button.GuessNum.color,
        borderColor: Constants.Button.GuessNum.borderColor
    )

    private lazy var calcButton: UIButton = makeButton(
        title: Constants.Button.Calc.label,
        color: Constants.Button.Calc.color,
        borderColor: Constants.Button.Calc.borderColor
    )

    lazy var greetingAlert: UIAlertController = {
        let alert = makeAlert(title: Constants.Alert.Greeting.title)
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bg)

        prepareGreetingAlert()
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
    }

    private func prepareGreetingAlert() {
        greetingAlert.addTextField { nameTextField in
            nameTextField.placeholder = Constants.Alert.Greeting.TextField.name.rawValue
        }

        for action in Constants.Alert.Greeting.Action.allCases {
            greetingAlert.addAction(UIAlertAction(
                title: action.rawValue,
                style: .default,
                handler: { [unowned self] action in
                    if let title = action.title, let actionCase = Constants.Alert.Greeting.Action(rawValue: title) {
                        switch actionCase {
                        case .done:
                            greetingLabel.text = "Приветствую, \(greetingAlert.textFields?.first?.text ?? "User")!"
                            view.addSubview(greetingLabel)
                            bg.frame = CGRect(
                                x: 0,
                                y: greetingLabel.frame.minY,
                                width: view.bounds.width,
                                height: view.bounds.height - greetingLabel.frame.minY
                            )
                        }
                    }
                }
            ))
        }
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
            enum Greeting {
                static let title = "Пожалуйста, представьтесь"
                enum Action: String, CaseIterable {
                    case done = "Готово"
                }

                enum TextField: String {
                    case name = "Введите ваше имя"
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
