// SubscribeButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SubscribeButton: UIButton {
    private enum Constants {
        static let subscribeButtonText = "Подписаться"
        static let unsubscribeButtonText = "Вы подписаны"
    }

    var isSubscribed = false {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
