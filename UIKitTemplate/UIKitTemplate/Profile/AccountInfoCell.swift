// AccountInfoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шапка профиля
final class AccountInfoCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let publicationsStatName = "публикации"
        static let subscribersStatName = "подписчики"
        static let subsriptionsStatName = "подписки"
        static let plusButtonImage = "plus"
        static let editButtonText = "Изменить"
        static let shareButtonText = "Поделиться профилем"
        static let plusButtonSize = 26.0
        static let plusButtonCornerRadius = plusButtonSize / 2
    }

    static let reuseID = String(describing: AccountInfoCell.self)

    // MARK: - Visual Components

    private lazy var publicationsStatsLabel = makeStatsLabel()
    private lazy var subscribersStatsLabel = makeStatsLabel()
    private lazy var subscriptionsStatsLabel = makeStatsLabel()
    private lazy var editButton = makeActionButton(text: Constants.editButtonText)
    private lazy var shareButton = makeActionButton(text: Constants.shareButtonText)
    private lazy var accountButton = makeActionButton(image: .account)
    private lazy var accountImageView: UIImageView = {
        let imageView = AvatarImageView()
        imageView.size = 80
        return imageView
    }()

    private lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setImage(UIImage(systemName: Constants.plusButtonImage), for: .normal)
        plusButton.backgroundColor = .pinkMain
        plusButton.tintColor = .whiteMain
        plusButton.layer.cornerRadius = Constants.plusButtonCornerRadius
        plusButton.disableAutoresizingMask()
        plusButton.widthAnchor.constraint(equalToConstant: Constants.plusButtonSize).activate()
        return plusButton
    }()

    private lazy var linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.disableAutoresizingMask()
        return button
    }()

    private let userNameLabel = BaseBoldLabel()
    private let descriptionLabel = BaseLabel()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Public Methods

    func configure(withAccount account: Account) {
        publicationsStatsLabel.attributedText = makeStatsAtttributedText(
            count: account.stats.publicationsCount,
            statName: Constants.publicationsStatName
        )
        subscribersStatsLabel.attributedText = makeStatsAtttributedText(
            count: account.stats.subscribersCount,
            statName: Constants.subscribersStatName
        )
        subscriptionsStatsLabel.attributedText = makeStatsAtttributedText(
            count: account.stats.subscriptionsCount,
            statName: Constants.subsriptionsStatName
        )
        accountImageView.image = UIImage(named: account.avatar)
        userNameLabel.text = account.info.fullName
        descriptionLabel.text = account.info.description
        linkButton.setTitle("📎\(account.info.link.text)", for: .normal)
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        contentView.addSubviews(
            publicationsStatsLabel,
            subscribersStatsLabel,
            subscriptionsStatsLabel,
            accountImageView,
            plusButton,
            userNameLabel,
            descriptionLabel,
            linkButton,
            editButton,
            shareButton,
            accountButton
        )
        setupConstraints()
    }

    private func setupConstraints() {
        setupAvatarConstraints()
        setupStatsConstraints()
        setupInfoConstraints()
        setupActionButtonsConstraints()
    }

    private func setupAvatarConstraints() {
        [
            accountImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            accountImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor),
            plusButton.bottomAnchor.constraint(equalTo: accountImageView.bottomAnchor),
            plusButton.trailingAnchor.constraint(equalTo: accountImageView.trailingAnchor)
        ].activate()
    }

    private func setupStatsConstraints() {
        [
            publicationsStatsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            subscribersStatsLabel.topAnchor.constraint(equalTo: publicationsStatsLabel.topAnchor),
            subscriptionsStatsLabel.topAnchor.constraint(equalTo: publicationsStatsLabel.topAnchor),
            subscriptionsStatsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            subscriptionsStatsLabel.leadingAnchor.constraint(
                equalTo: subscribersStatsLabel.trailingAnchor,
                constant: 1
            ),
            subscribersStatsLabel.leadingAnchor.constraint(equalTo: publicationsStatsLabel.trailingAnchor, constant: 1),
            publicationsStatsLabel.leadingAnchor.constraint(
                lessThanOrEqualTo: accountImageView.trailingAnchor,
                constant: 46
            ),
            subscribersStatsLabel.widthAnchor.constraint(equalTo: publicationsStatsLabel.widthAnchor),
            subscriptionsStatsLabel.widthAnchor.constraint(equalTo: publicationsStatsLabel.widthAnchor)
        ].activate()
    }

    private func setupInfoConstraints() {
        descriptionLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        [
            accountImageView.bottomAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: -9),
            userNameLabel.leadingAnchor.constraint(equalTo: accountImageView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            descriptionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: accountImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            linkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            linkButton.leadingAnchor.constraint(equalTo: accountImageView.leadingAnchor),
        ].activate()
    }

    private func setupActionButtonsConstraints() {
//        accountButton.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        [
            editButton.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 15),
            shareButton.topAnchor.constraint(equalTo: editButton.topAnchor),
            accountButton.topAnchor.constraint(equalTo: editButton.topAnchor),
            editButton.leadingAnchor.constraint(equalTo: accountImageView.leadingAnchor),
            accountButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            shareButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 5),
            accountButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: 5),
            editButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor),
            accountButton.widthAnchor.constraint(equalToConstant: 25),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ].activate()
    }

    private func makeStatsLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.disableAutoresizingMask()
        return label
    }

    private func makeStatsAtttributedText(count: Int, statName: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(count)\n", attributes: [
            .font: UIFont.verdanaBold(ofSize: 14) ?? UIFont.boldSystemFont(ofSize: 14)
        ])
        attributedText.append(NSAttributedString(string: statName, attributes: [
            .font: UIFont.verdana(ofSize: 10) ?? UIFont.systemFont(ofSize: 10)
        ]))
        return attributedText
    }

    private func makeActionButton(text: String? = nil, image: UIImage? = nil) -> UIButton {
        let button = UIButton(configuration: .filled())
        button.setImage(image, for: .normal)
        button.configuration?.baseBackgroundColor = .grayLight
        button.configuration?.baseForegroundColor = .blackMain
        button.configuration?.attributedTitle = AttributedString(text ?? "", attributes: AttributeContainer([
            .font: UIFont.verdanaBold(ofSize: 10) ?? UIFont.boldSystemFont(ofSize: 10)]))
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 7, trailing: 5)
        button.configuration?.cornerStyle = .large
        button.disableAutoresizingMask()
        return button
    }
}
