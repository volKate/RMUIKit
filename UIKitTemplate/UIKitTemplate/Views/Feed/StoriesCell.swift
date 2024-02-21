// StoriesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с кружочками сторис
final class StoriesCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = String(describing: StoriesCell.self)

    // MARK: - Visual Components

    private let scrollView = UIScrollView()
    private let contentContainerView = UIView()

    // MARK: - Public Properties

    var stories: [Story] = [] {
        didSet {
            setupStories()
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    // MARK: - Private Methods

    private func setupCell() {
        selectionStyle = .none
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(contentContainerView)
        contentView.addSubview(scrollView)
        setupContraints()
    }

    private func setupContraints() {
        [scrollView, contentContainerView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            contentContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ].activate()
    }
}

/// Настройка историй
extension StoriesCell {
    private func setupStories() {
        contentContainerView.subviews.forEach { $0.removeFromSuperview() }
        var storiesViews: [StoryView] = []
        for item in stories {
            let storyView = StoryView(story: item)
            contentContainerView.addSubview(storyView)
            storiesViews.append(storyView)
        }
        setupConstraints(forStoriesViews: storiesViews)
    }

    private func setupConstraints(forStoriesViews storiesViews: [StoryView]) {
        var prevStoryView: StoryView?
        for storyView in storiesViews {
            if let prevStoryView {
                storyView.leadingAnchor.constraint(equalTo: prevStoryView.trailingAnchor, constant: 8).isActive = true
            } else {
                storyView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 5)
                    .isActive = true
            }
            if storiesViews[storiesViews.count - 1] == storyView {
                contentContainerView.trailingAnchor.constraint(equalTo: storyView.trailingAnchor, constant: 5)
                    .isActive = true
            }
            [
                storyView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
                storyView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor)
            ].activate()
            prevStoryView = storyView
        }
    }
}
