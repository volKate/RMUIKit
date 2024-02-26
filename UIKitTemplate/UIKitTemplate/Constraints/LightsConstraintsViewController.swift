// LightsConstraintsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Светофор на NSLayoutConstraints
final class LightsConstraintsViewController: LightsImplementationViewController {
    // MARK: - Public Methods

    override func setupConstraints() {
        setupLightsBaseViewConstraints()
        setupLightsViewsConstraints()
    }

    // MARK: - Private Methods

    private func setupLightsBaseViewConstraints() {
        let lightsBaseViewHeightConstraint = NSLayoutConstraint(
            item: lightsBaseView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: Constants.lightsBaseViewHeight
        )
        lightsBaseViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            lightsBaseViewHeightConstraint,
            NSLayoutConstraint(
                item: lightsBaseView,
                attribute: .height,
                relatedBy: .lessThanOrEqual,
                toItem: view,
                attribute: .height,
                multiplier: 1,
                constant: -Constants.minimumHeightSpacing
            ),
            NSLayoutConstraint(
                item: lightsBaseView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: lightsBaseView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: redLightView,
                attribute: .top,
                relatedBy: .equal,
                toItem: lightsBaseView,
                attribute: .top,
                multiplier: 1,
                constant: Constants.lightsBaseViewInset.y
            ),
            NSLayoutConstraint(
                item: lightsBaseView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: greenLightView,
                attribute: .bottom,
                multiplier: 1,
                constant: Constants.lightsBaseViewInset.y
            ),
            NSLayoutConstraint(
                item: lightsBaseView,
                attribute: .width,
                relatedBy: .equal,
                toItem: redLightView,
                attribute: .width,
                multiplier: 1,
                constant: Constants.lightsBaseViewInset.x * 2
            )

        ])
    }

    private func setupLightsViewsConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: redLightView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: lightsBaseView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: yellowLightView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: lightsBaseView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: greenLightView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: lightsBaseView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: yellowLightView,
                attribute: .height,
                relatedBy: .equal,
                toItem: redLightView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: greenLightView,
                attribute: .height,
                relatedBy: .equal,
                toItem: redLightView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: yellowLightView,
                attribute: .top,
                relatedBy: .equal,
                toItem: redLightView,
                attribute: .bottom,
                multiplier: 1,
                constant: 8
            ),
            NSLayoutConstraint(
                item: greenLightView,
                attribute: .top,
                relatedBy: .equal,
                toItem: yellowLightView,
                attribute: .bottom,
                multiplier: 1,
                constant: 8
            ),
        ])
    }
}
