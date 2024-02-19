// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ProfileViewController: UIViewController {
    enum Constants {
        static let screenTitle = "Профиль"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.screenTitle
    }
}
