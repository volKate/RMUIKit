// LightsAnchorsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Светофор на NSLayoutAnchors
final class LightsAnchorsViewController: LightsViewController {
    // MARK: - Public Methods
    override func setupConstraints() {
        setupLightsBaseViewConstraints()
        setupLightsViewsConstraints()
    }

    // MARK: - Private Methods
    private func setupLightsBaseViewConstraints() {
        let lightsBaseViewHeightConstraint = lightsBaseView.heightAnchor
            .constraint(equalToConstant: Constants.lightsBaseViewHeight)
        lightsBaseViewHeightConstraint.priority = .defaultHigh
        [
            lightsBaseViewHeightConstraint,
            lightsBaseView.heightAnchor.constraint(
                lessThanOrEqualTo: view.heightAnchor,
                constant: -Constants.minimumHeightSpacing
            ),
            lightsBaseView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            lightsBaseView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            redLightView.topAnchor.constraint(
                equalTo: lightsBaseView.topAnchor,
                constant: Constants.lightsBaseViewInset.y
            ),
            lightsBaseView.bottomAnchor.constraint(
                equalTo: greenLightView.bottomAnchor,
                constant: Constants.lightsBaseViewInset.y
            ),
            lightsBaseView.widthAnchor.constraint(
                equalTo: redLightView.widthAnchor,
                constant: Constants.lightsBaseViewInset.x * 2
            ),
        ].forEach { $0.isActive = true }
    }

    private func setupLightsViewsConstraints() {
        [
            redLightView.centerXAnchor.constraint(equalTo: lightsBaseView.centerXAnchor),
            yellowLightView.centerXAnchor.constraint(equalTo: lightsBaseView.centerXAnchor),
            greenLightView.centerXAnchor.constraint(equalTo: lightsBaseView.centerXAnchor),

            yellowLightView.heightAnchor.constraint(equalTo: redLightView.heightAnchor),
            greenLightView.heightAnchor.constraint(equalTo: redLightView.heightAnchor),
            yellowLightView.topAnchor.constraint(equalToSystemSpacingBelow: redLightView.bottomAnchor, multiplier: 1),
            greenLightView.topAnchor.constraint(equalToSystemSpacingBelow: yellowLightView.bottomAnchor, multiplier: 1),

        ].forEach { $0.isActive = true }
    }
}
