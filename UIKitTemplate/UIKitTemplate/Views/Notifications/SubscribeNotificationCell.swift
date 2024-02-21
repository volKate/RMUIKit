// SubscribeNotificationCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нотификация с кнопкой подписаться/отписаться
final class SubscribeNotificationCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = "SubscribeNotificationCell"

    // MARK: - Visual Components

    private let subscribeButton = SubscribeButton()
    private let notificationBaseView = NotificationBaseView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func setupCell(withNotification notification: LinkNotification) {
        notificationBaseView.notification = notification
        subscribeButton.isSubscribed = notification.isSubscribed
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(notificationBaseView)
        contentView.addSubview(subscribeButton)
        setupContraints()
    }

    private func setupContraints() {
        [
            notificationBaseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            notificationBaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            notificationBaseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            subscribeButton.leadingAnchor.constraint(equalTo: notificationBaseView.trailingAnchor, constant: 8),
            subscribeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            subscribeButton.centerYAnchor.constraint(equalTo: notificationBaseView.centerYAnchor),
            subscribeButton.widthAnchor.constraint(equalToConstant: 140)

        ].activate()
    }
}
