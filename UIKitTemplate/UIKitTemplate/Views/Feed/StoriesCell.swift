// StoriesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с кружочками сторис
final class StoriesCell: UITableViewCell {
    // MARK: - Visual Components
    private let scrollView = UIScrollView()
    private let contentContainerView = UIView()
    let stories = [
        StoryView(avatar: .lavanda, accountName: "lavanda123", isOwn: true),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123"),
        StoryView(avatar: .lavanda, accountName: "lavanda123")
    ]

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupCell() {
        scrollView.showsHorizontalScrollIndicator = false
        stories.forEach { contentContainerView.addSubview($0) }

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

        var prevStoryView: StoryView?
        for storyView in stories {
            if let prevStoryView {
                storyView.leadingAnchor.constraint(equalTo: prevStoryView.trailingAnchor, constant: 8).isActive = true
            } else {
                storyView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 5)
                    .isActive = true
            }
            if stories[stories.count - 1] == storyView {
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
