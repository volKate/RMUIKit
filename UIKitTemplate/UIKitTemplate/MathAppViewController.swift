// MathAppViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MathApp main screen
final class WordReverterViewController: UIViewController {
    private var converter: WordConverter?

    lazy var startButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "greenNeon")
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        var attributedTitle = AttributedString("Начать")
        attributedTitle.foregroundColor = .white
        attributedTitle.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        config.attributedTitle = attributedTitle
        var button = UIButton(configuration: config)

        button.frame = CGRect(
            origin: .zero,
            size: CGSize(width: view.bounds.width - 40.0, height: 44.0)
        )
        button.center = view.center

        return button
    }()

    lazy var enterWordAlert: UIAlertController = {
        var alert = UIAlertController(title: "Введите ваше слово", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Введите слово" }
        return alert
    }()

    lazy var originalWordLabel: UILabel = makeDescriptionLabel("Вы ввели слово")
    lazy var convertedWordLabel: UILabel = makeDescriptionLabel("А вот что получится, если читать справо налево")
    lazy var originalWordValue: UILabel = makeValueLabel()
    lazy var convertedWordValue: UILabel = makeValueLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startButton)

        startButton.addTarget(self, action: #selector(touchStartButton), for: .touchUpInside)
    }

    @objc private func touchStartButton() {
        resetToStart()
        showEnterWordAlert()
    }

    private func showEnterWordAlert() {
        resetWordTextField()
        if enterWordAlert.actions.isEmpty {
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { [unowned self] _ in
                resetWordTextField()
            }
            let okAction = UIAlertAction(title: "Ок", style: .default) { [unowned self] _ in
                if let word = enterWordAlert.textFields?.first?.text {
                    converter = WordConverter(word: word)
                    showResult()
                } else {
                    showEnterWordAlert()
                }
            }
            enterWordAlert.addAction(cancelAction)
            enterWordAlert.addAction(okAction)
            enterWordAlert.preferredAction = okAction
        }
        present(enterWordAlert, animated: true)
    }

    private func showResult() {
        originalWordValue.text = converter?.word
        convertedWordValue.text = converter?.converted

        layoutLabels()
        startButton.frame = CGRect(
            x: startButton.frame.minX,
            y: view.bounds.maxY - 240,
            width: startButton.frame.width,
            height: startButton.frame.height
        )
    }

    private func layoutLabels() {
        let padding = 50.0
        let labelWidth = view.bounds.width - padding * 2
        let labelHeight = 57.0
        originalWordLabel.frame = CGRect(x: padding, y: 120, width: labelWidth, height: labelHeight)
        originalWordValue.frame = CGRect(
            x: padding,
            y: labelHeight + originalWordLabel.frame.minY,
            width: labelWidth,
            height: labelHeight
        )
        convertedWordLabel.frame = CGRect(
            x: padding,
            y: labelHeight + originalWordValue.frame.minY,
            width: labelWidth,
            height: labelHeight
        )
        convertedWordValue.frame = CGRect(
            x: padding,
            y: labelHeight + convertedWordLabel.frame.minY,
            width: labelWidth,
            height: labelHeight
        )
        view.addSubview(originalWordLabel)
        view.addSubview(originalWordValue)
        view.addSubview(convertedWordLabel)
        view.addSubview(convertedWordValue)
    }

    private func resetToStart() {
        startButton.center = view.center
        resetWordTextField()
        originalWordLabel.removeFromSuperview()
        originalWordValue.removeFromSuperview()
        convertedWordLabel.removeFromSuperview()
        convertedWordValue.removeFromSuperview()
    }

    private func resetWordTextField() {
        enterWordAlert.textFields?.forEach { $0.text = "" }
    }

    private func makeDescriptionLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = title
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }

    private func makeValueLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.font.fontDescriptor.withSymbolicTraits(.traitItalic)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        label.textAlignment = .center
        return label
    }
}
