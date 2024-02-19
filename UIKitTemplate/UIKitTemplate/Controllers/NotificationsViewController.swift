// NotificationsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NotificationsViewController: UIViewController {
    enum Constants {
        static let screenTitle = "Уведомления"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.screenTitle
    }
}
