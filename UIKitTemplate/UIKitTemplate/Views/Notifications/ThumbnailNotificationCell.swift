// ThumbnailNotificationCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нотификация с упоминанием поста
final class ThumbnailNotificationCell: UITableViewCell {
    static let reuseID = "ThumbnailNotificationCell"

    private let notificationBaseView = NotificationBaseView()
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ].activate()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(withNotification notification: LinkNotification) {
        notificationBaseView.notification = notification
        if let postThumbnail = notification.postThumbnail {
            thumbnailImageView.image = UIImage(named: postThumbnail)
        }
    }

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(notificationBaseView)
        contentView.addSubview(thumbnailImageView)
        setupContraints()
    }

    private func setupContraints() {
        [
            notificationBaseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            notificationBaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            notificationBaseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            thumbnailImageView.leadingAnchor.constraint(equalTo: notificationBaseView.trailingAnchor, constant: 24),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            thumbnailImageView.topAnchor.constraint(equalTo: notificationBaseView.topAnchor),
        ].activate()
    }
}
