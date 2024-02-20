// PostFooterView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Нижняя панель поста
final class PostFooterView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let likesLabelText = "Нравится:"
        static let commentPlaceholderText = "Комментировать ..."
        static let timeStampText = "10 минут назад"
    }

    // MARK: - Visual Components

    private let sliderPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = .indicator
        pageControl.preferredCurrentPageIndicatorImage = .currentIndicator
        pageControl.pageIndicatorTintColor = .blackMain
        pageControl.currentPageIndicatorTintColor = .blackMain
        pageControl.backgroundStyle = .minimal
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 10)
        label.text = Constants.likesLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AppDataProvider.shared.currentUserAvatar))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ].activate()
        return imageView
    }()

    private let commentPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 10)
        label.textColor = .grayMain
        label.text = Constants.commentPlaceholderText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeStampLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 10)
        label.textColor = .grayMain
        label.text = Constants.timeStampText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likeButton = makeIconButton(withImage: .heart)
    private lazy var messageButton = makeIconButton(withImage: .message)
    private lazy var shareButton = makeIconButton(withImage: .send)
    private lazy var bookmarkButton = makeIconButton(withImage: .bookmark)

    var post: Post? {
        didSet {
            if let post {
                sliderPageControl.numberOfPages = post.postImages.count
                likesLabel.text = "\(Constants.likesLabelText) \(post.likesCount)"
                descriptionLabel.attributedText = makeDescriptionAtributedText(
                    accountName: post.accountName,
                    description: post.postDescription
                )
            }
        }
    }

    var currentSlide = 0 {
        didSet {
            sliderPageControl.currentPage = currentSlide
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
        [
            sliderPageControl,
            likeButton,
            messageButton,
            shareButton,
            bookmarkButton,
            likesLabel,
            descriptionLabel,
            userImageView,
            commentPlaceholderLabel,
            timeStampLabel
        ].forEach { addSubview($0) }

        setupConstraints()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        [
            likeButton.topAnchor.constraint(equalTo: topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            messageButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 8),
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),

            sliderPageControl.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            sliderPageControl.centerXAnchor.constraint(equalTo: centerXAnchor),

            trailingAnchor.constraint(equalTo: bookmarkButton.trailingAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),

            likesLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 6),
            likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            userImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            commentPlaceholderLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 3),
            commentPlaceholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentPlaceholderLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            commentPlaceholderLabel.heightAnchor.constraint(greaterThanOrEqualTo: userImageView.heightAnchor),

            timeStampLabel.topAnchor.constraint(equalTo: commentPlaceholderLabel.bottomAnchor, constant: 4),
            timeStampLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeStampLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeStampLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].activate()
    }

    private func makeIconButton(withImage image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .blackMain
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeDescriptionAtributedText(accountName: String, description: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: accountName + " ", attributes: [
            .font: UIFont.verdanaBold(ofSize: 10) ?? UIFont.boldSystemFont(ofSize: 10)
        ])
        attributedText.append(NSAttributedString(string: description, attributes: [
            .font: UIFont.verdana(ofSize: 10) ?? UIFont.systemFont(ofSize: 10)
        ]))
        return attributedText
    }
}
