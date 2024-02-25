// LightsStackViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Имплементация светофора на StackView
final class LightsStackViewController: LightsImplementationViewController {
    // MARK: - Visual Components
    private lazy var lightsBaseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [redLightView, yellowLightView, greenLightView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Public Methods
    override func setupView() {
        lightsBaseView.addSubview(lightsBaseStackView)
        view.addSubview(lightsBaseView)
        setupConstraints()
    }

    override func setupConstraints() {
        let lightsBaseViewHeightConstraint = lightsBaseView.heightAnchor
            .constraint(equalToConstant: Constants.lightsBaseViewHeight)
        lightsBaseViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            lightsBaseViewHeightConstraint,
            lightsBaseView.heightAnchor.constraint(
                lessThanOrEqualTo: view.heightAnchor,
                constant: -Constants.minimumHeightSpacing
            ),
            lightsBaseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            lightsBaseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            lightsBaseStackView.centerXAnchor.constraint(equalTo: lightsBaseView.centerXAnchor),
            lightsBaseStackView.centerYAnchor.constraint(equalTo: lightsBaseView.centerYAnchor),
            lightsBaseView.widthAnchor.constraint(
                equalTo: lightsBaseStackView.widthAnchor,
                constant: Constants.lightsBaseViewInset.x * 2
            ),
            lightsBaseView.heightAnchor.constraint(
                equalTo: lightsBaseStackView.heightAnchor,
                constant: Constants.lightsBaseViewInset.y * 2
            )
        ])
    }
}
