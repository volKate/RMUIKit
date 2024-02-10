// SongPlayerViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with song player, opens modally, has player controls: play/pause, rewind, quickRewind
final class SongPlayerViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var trackNameLabel: UILabel!

    // MARK: - Public Properties

    var trackName: String = ""

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        trackNameLabel.text = trackName
    }
}
