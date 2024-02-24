// LightsImplementationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовый класс имплементации светофора
class LightsViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let lightsBaseViewHeight = 376.0
        static let lightsBaseViewInset = (x: 25.0, y: 15.0)
        static let minimumHeightSpacing = 60.0
    }

    // MARK: - Visual Components

    private(set) lazy var lightsBaseView = makeView(withBackground: .blackMain, isAspectOne: false)
    private(set) lazy var redLightView = makeView(withBackground: .redMain)
    private(set) lazy var yellowLightView = makeView(withBackground: .yellowMain)
    private(set) lazy var greenLightView = makeView(withBackground: .greenMain)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for lightsView in [redLightView, yellowLightView, greenLightView] {
            lightsView.setNeedsLayout()
            lightsView.layoutIfNeeded()
            lightsView.layer.cornerRadius = lightsView.frame.width / 2
        }
    }

    // MARK: - Public Methods

    func setupConstraints() {}

    // MARK: - Private Methods

    private func setupView() {
        [
            redLightView,
            yellowLightView,
            greenLightView
        ].forEach { lightsBaseView.addSubview($0) }
        view.addSubview(lightsBaseView)
        setupConstraints()
    }

    private func makeView(withBackground backgroundcolor: UIColor, isAspectOne: Bool = true) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundcolor
        view.translatesAutoresizingMaskIntoConstraints = false
        if isAspectOne {
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
        return view
    }
}
