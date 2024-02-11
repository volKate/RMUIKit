// PlayListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// VC with the list of songs in library
final class PlayListViewController: UIViewController {
    // MARK: - Constants

    enum TrackList {
        case letItBe
        case yesterday
        case showMustGoOn
    }

    // MARK: - IBOutlets

    @IBOutlet private var letItBeTrack: UIView!
    @IBOutlet private var yesterdayTrack: UIView!
    @IBOutlet private var showMustGoOnTrack: UIView!

    // MARK: - Private Properties

    private let tracks = [
        TrackList.letItBe: Track(name: "Let it be", artist: "The Beatles", audioFileName: "letItBe"),
        TrackList.yesterday: Track(name: "Yesterday", artist: "The Beatles", audioFileName: "yesterday"),
        TrackList.showMustGoOn: Track(name: "The Show Must Go On", artist: "Queen", audioFileName: "showMustGoOn")
    ]

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songPlayerVC = segue.destination as? SongPlayerViewController,
              let sender = sender as? UIView else { return }
        switch sender {
        case letItBeTrack:
            songPlayerVC.track = tracks[.letItBe]
        case yesterdayTrack:
            songPlayerVC.track = tracks[.yesterday]
        case showMustGoOnTrack:
            songPlayerVC.track = tracks[.showMustGoOn]
        default:
            return
        }
    }

    // MARK: - Private Methods/IBAction

    @IBAction private func openSongPlayer(_ sender: UIView) {
        performSegue(withIdentifier: "openSongPlayer", sender: sender)
    }
}
