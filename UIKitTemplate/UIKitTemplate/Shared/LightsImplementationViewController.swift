// LightsImplementationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовый класс имплементации светофора
class LightsImplementationViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let lightsBaseViewHeight = 376.0
        static let lightsBaseViewInset = (x: 25.0, y: 15.0)
        static let minimumHeightSpacing = 60.0
    }

    // MARK: - Visual Components

    private(set) lazy var lightsBaseView = makeBaseView(withBackground: .blackMain)
    private(set) lazy var redLightView = makeCircleView(withBackground: .redMain)
    private(set) lazy var yellowLightView = makeCircleView(withBackground: .yellowMain)
    private(set) lazy var greenLightView = makeCircleView(withBackground: .greenMain)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Public Methods

    func setupConstraints() {}

    func setupView() {
        [
            redLightView,
            yellowLightView,
            greenLightView
        ].forEach { lightsBaseView.addSubview($0) }
        view.addSubview(lightsBaseView)
        setupConstraints()
    }

    // MARK: - Private Methods

    private func makeBaseView(withBackground backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func makeCircleView(withBackground backgroundColor: UIColor) -> CircleView {
        let view = CircleView()
        view.backgroundColor = backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }
}
