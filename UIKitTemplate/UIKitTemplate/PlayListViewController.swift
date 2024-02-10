// PlayListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the list of songs in library
final class PlayListViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var letItBeTrack: UIView!
    @IBOutlet private var yesterdayTrack: UIView!
    @IBOutlet private var showMustGoOnTrack: UIView!

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songPlayerVC = segue.destination as? SongPlayerViewController,
              let sender = sender as? UIView else { return }
        switch sender {
        case letItBeTrack:
            songPlayerVC.trackName = "Let it be"
        case yesterdayTrack:
            songPlayerVC.trackName = "Yesterday"
        case showMustGoOnTrack:
            songPlayerVC.trackName = "Show Must Go On"
        default:
            return
        }
    }

    // MARK: - Private Methods/IBAction

    @IBAction private func openSongPlayer(_ sender: UIView) {
        performSegue(withIdentifier: "openSongPlayer", sender: sender)
    }
}
