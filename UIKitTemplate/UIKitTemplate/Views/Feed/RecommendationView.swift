// RecommendationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рекоммендация аккаунта с возможностью подписаться
final class RecommendationView: UIView {
    private enum Constants {
        static let subscribeButtonText = "Подписаться"
    }

    private let accountImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 55
        view.translatesAutoresizingMaskIntoConstraints = false
        [
            view.heightAnchor.constraint(equalToConstant: 115),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ].activate()
        return view
    }()

    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subscribeButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.filled())
        button.configuration?.attributedTitle = AttributedString(
            Constants.subscribeButtonText,
            attributes: AttributeContainer([
                .font: UIFont.verdanaBold(ofSize: 10) ?? UIFont.boldSystemFont(ofSize: 10),
                .foregroundColor: UIColor.whiteMain.cgColor
            ])
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    var account: Account? {
        didSet {
            if let account {
                accountImageView.image = UIImage(named: account.avatar)
                accountNameLabel.text = account.name
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .whiteMain
        addSubview(accountImageView)
        addSubview(accountNameLabel)
        addSubview(subscribeButton)

        setupConstraints()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        [
            widthAnchor.constraint(greaterThanOrEqualToConstant: 185),
            accountImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            accountImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountNameLabel.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 5),
            accountNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            accountNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subscribeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 14)
        ].activate()
    }
}
