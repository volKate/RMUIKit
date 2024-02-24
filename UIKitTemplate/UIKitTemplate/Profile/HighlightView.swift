// HighlightView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол обработки событий на StoryView/HighlightView
protocol StoryViewDelegate: AnyObject {
    /// Открыть историю в полном формате
    func viewStory(_ story: Story)
}

final class HighlightView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let avatarSize = 49.0
        static let avatarCornerRadius = avatarSize / 2
        static let nameFontSize = 10.0
        static let highlightWidth = 55.0
    }

    // MARK: - Visual Components

    private let highlightNameLabel: UILabel = {
        let label = BaseLabel(size: Constants.nameFontSize)
        label.textAlignment = .center
        return label
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = AvatarImageView()
        imageView.size = Constants.avatarSize
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.whiteMain.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hightlightTapped(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()

    // MARK: - Public Properties

    var delegate: StoryViewDelegate?

    // MARK: - Private Properties

    private var highlight: Story?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public Methods

    func configure(withHighlight highlight: Story) {
        self.highlight = highlight
        avatarImageView.image = UIImage(named: highlight.imageName)
        highlightNameLabel.text = highlight.highlightName
    }

    // MARK: - Private Methods

    private func setupView() {
        disableAutoresizingMask()
        addSubviews(
            avatarImageView,
            highlightNameLabel
        )
        setupConstraints()
    }

    private func setupConstraints() {
        [
            widthAnchor.constraint(equalToConstant: Constants.highlightWidth),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            highlightNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            highlightNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            highlightNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            highlightNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].activate()
    }

    @objc private func hightlightTapped(_ gestureRecornizer: UITapGestureRecognizer) {
        if let highlight {
            delegate?.viewStory(highlight)
        }
    }
}
