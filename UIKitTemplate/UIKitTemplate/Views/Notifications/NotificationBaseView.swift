// NotificationBaseView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовое вью нотификации
final class NotificationBaseView: UIView {
    // MARK: - Visual Components

    private let avatarImageView = AvatarImageView()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    var notification: LinkNotification? {
        didSet {
            if let notification {
                setupView(withNotification: notification)
            }
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        avatarImageView.size = 40.0
        addSubview(avatarImageView)
        addSubview(commentLabel)

        setupConstraints()
    }

    private func setupView(withNotification notification: LinkNotification) {
        avatarImageView.image = UIImage(named: notification.account.avatar)
        commentLabel.attributedText = makeCommentAtributedText(
            accountName: notification.account.name,
            comment: notification.message,
            hoursAgo: notification.hoursAgo
        )
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        [
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            heightAnchor.constraint(greaterThanOrEqualTo: avatarImageView.heightAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 7),
            commentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].activate()
    }

    private func makeCommentAtributedText(accountName: String, comment: String, hoursAgo: Int) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: accountName + " ", attributes: [
            .font: UIFont.verdanaBold(ofSize: 12) ?? UIFont.boldSystemFont(ofSize: 12)
        ])
        attributedText.append(NSAttributedString(string: comment + " ", attributes: [
            .font: UIFont.verdana(ofSize: 12) ?? UIFont.systemFont(ofSize: 12)
        ]))
        let hoursStr = hoursAgo < 24 ? "\(hoursAgo)ч" : "\(hoursAgo / 24)д"
        attributedText.append(NSAttributedString(string: hoursStr, attributes: [
            .font: UIFont.verdana(ofSize: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.grayMain.cgColor
        ]))
        return attributedText
    }
}
