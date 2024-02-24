// LightsStoryboardViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Светофор на сториборде
final class LightsStoryboardViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var lightsViews: [UIView]!

    // MARK: - Life Cycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for lightsView in lightsViews {
            lightsView.setNeedsLayout()
            lightsView.layoutIfNeeded()
            lightsView.layer.cornerRadius = lightsView.frame.width / 2
        }
    }
}
