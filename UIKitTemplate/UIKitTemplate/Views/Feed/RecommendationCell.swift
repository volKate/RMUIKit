// RecommendationCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка рекоммендации
final class RecommendationCell: UITableViewCell {
    // MARK: - Constants

    static let reuseID = "RecommendationCell"
    private enum Constants {
        static let recommendationLabelText = "Рекомендуем вам"
        static let allButtonText = "Все"
    }

    // MARK: - Visual Components

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let recommendationLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 10)
        label.text = Constants.recommendationLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let allButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.plain())
        button.configuration?.attributedTitle = AttributedString(
            Constants.allButtonText,
            attributes: AttributeContainer([
                .font: UIFont.verdanaBold(ofSize: 10) ?? UIFont.boldSystemFont(ofSize: 10),
                .foregroundColor: UIColor.blueMain.cgColor
            ])
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return button
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func setupCell(withRecommendations recommendations: [Recommendation]) {
        selectionStyle = .none
        backgroundColor = .blueSecondary
        contentView.addSubview(recommendationLabel)
        contentView.addSubview(allButton)

        scrollView.addSubview(containerView)
        contentView.addSubview(scrollView)

        var recommendationViews: [RecommendationView] = []
        for recommendation in recommendations {
            let recommendationView = RecommendationView()
            recommendationView.account = recommendation.account
            containerView.addSubview(recommendationView)
            recommendationViews.append(recommendationView)
        }

        setupConstraints()
        setupConstraints(forRecommendationViews: recommendationViews)
    }

    // MARK: - Private Methods

    private func setupConstraints() {
        allButton.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        [
            recommendationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            recommendationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recommendationLabel.heightAnchor.constraint(equalToConstant: 15),
            allButton.leadingAnchor.constraint(equalTo: recommendationLabel.trailingAnchor, constant: 10),
            allButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            allButton.centerYAnchor.constraint(equalTo: recommendationLabel.centerYAnchor),

            scrollView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            containerView.heightAnchor.constraint(equalToConstant: 255),
            scrollView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.widthAnchor.constraint(greaterThanOrEqualTo: contentView.widthAnchor)

        ].activate()
    }

    private func setupConstraints(forRecommendationViews recommendationViews: [RecommendationView]) {
        var prevRecommendationView: RecommendationView?
        for (index, recommendationView) in recommendationViews.enumerated() {
            if let prevRecommendationView {
                recommendationView.leadingAnchor
                    .constraint(equalTo: prevRecommendationView.trailingAnchor, constant: 20).isActive = true
            } else {
                recommendationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17)
                    .isActive = true
            }
            if index == recommendationViews.count - 1 {
                containerView.trailingAnchor.constraint(equalTo: recommendationView.trailingAnchor, constant: 17)
                    .isActive = true
            }
            [
                recommendationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
                containerView.bottomAnchor.constraint(equalTo: recommendationView.bottomAnchor, constant: 25)
            ].activate()

            prevRecommendationView = recommendationView
        }
    }
}
