// PostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с постом
final class PostCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = String(describing: PostCell.self)
    enum Constants {
        static let postImageRatio = 1.56
    }

    // MARK: - Visual Components

    private let imageSliderView: UIScrollView = {
        let slider = UIScrollView()
        slider.isPagingEnabled = true
        slider.showsHorizontalScrollIndicator = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let postHeaderView = PostHeaderView()
    private let postFooterView = PostFooterView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Properties

    func setupCell(withPost post: Post) {
        selectionStyle = .none
        let slideViews = makeSliderImageViews(post: post)
        imageSliderView.delegate = self

        postHeaderView.post = post
        postFooterView.post = post

        slideViews.forEach { imageSliderView.addSubview($0) }
        contentView.addSubview(postHeaderView)
        contentView.addSubview(postFooterView)
        contentView.addSubview(imageSliderView)

        setupConstraints(forSlideViews: slideViews)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageSliderView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            imageSliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageSliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            postFooterView.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor, constant: 20),
            postFooterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            contentView.trailingAnchor.constraint(equalTo: postFooterView.trailingAnchor, constant: 12)
        ].activate()
    }

    /// Настройка фото-слайдов
    private func makeSliderImageViews(post: Post) -> [UIImageView] {
        post.postImages.map {
            let postImageView = UIImageView(image: UIImage(named: $0))
            postImageView.contentMode = .scaleAspectFill
            postImageView.translatesAutoresizingMaskIntoConstraints = false
            return postImageView
        }
    }

    private func setupConstraints(forSlideViews slideViews: [UIImageView]) {
        var prevPostImageView: UIImageView?
        for (index, postImageView) in slideViews.enumerated() {
            [
                postImageView.topAnchor.constraint(equalTo: imageSliderView.topAnchor),
                postImageView.bottomAnchor.constraint(equalTo: imageSliderView.bottomAnchor),
                postImageView.heightAnchor.constraint(equalTo: imageSliderView.heightAnchor),
                postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                postImageView.widthAnchor.constraint(
                    equalTo: postImageView.heightAnchor,
                    multiplier: Constants.postImageRatio
                )
            ].activate()
            if let prevPostImageView {
                postImageView.leadingAnchor.constraint(equalTo: prevPostImageView.trailingAnchor).isActive = true
            } else {
                postImageView.leadingAnchor.constraint(equalTo: imageSliderView.leadingAnchor).isActive = true
            }
            if index == slideViews.count - 1 {
                postImageView.trailingAnchor.constraint(equalTo: imageSliderView.trailingAnchor).isActive = true
            }
            prevPostImageView = postImageView
        }
    }
}

/// Обработка скролла слайдера с фото
extension PostCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageSliderView {
            let slide = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            postFooterView.currentSlide = slide
        }
    }
}
