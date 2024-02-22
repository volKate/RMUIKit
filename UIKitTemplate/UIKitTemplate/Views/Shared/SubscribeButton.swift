// SubscribeButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Копка подписаться/вы подписаны
final class SubscribeButton: UIButton {
    // MARK: - Constants

    private enum Constants {
        static let subscribeButtonText = "Подписаться"
        static let unsubscribeButtonText = "Вы подписаны"
    }

    // MARK: - Public Properties

    var isSubscribed = false {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    // MARK: - Private Methods

    private func setupButton() {
        configurationUpdateHandler = { [unowned self] _ in
            var config: UIButton.Configuration = isSubscribed ? .bordered() : .filled()
            config.attributedTitle = AttributedString(
                isSubscribed ? Constants.unsubscribeButtonText : Constants.subscribeButtonText,
                attributes: AttributeContainer([
                    .font: UIFont.verdanaBold(ofSize: 10) ?? UIFont.boldSystemFont(ofSize: 10),
                ])
            )
            config.baseForegroundColor = isSubscribed ? .grayMain : .whiteMain
            config.baseBackgroundColor = isSubscribed ? .graySecondary : .blueMain
            config.background.strokeWidth = 1
            config.background.strokeColor = isSubscribed ? .grayMain : .clear
            configuration = config
        }

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
