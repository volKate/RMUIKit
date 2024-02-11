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

    private var tracks = [
        TrackList.letItBe: Track(
            name: "Let it be",
            artist: "The Beatles",
            audioFileName: "letItBe",
            albumCoverName: "letItBeCover"
        ),
        TrackList.yesterday: Track(
            name: "Yesterday",
            artist: "The Beatles",
            audioFileName: "yesterday",
            albumCoverName: "yesterdayCover"
        ),
        TrackList.showMustGoOn: Track(
            name: "The Show Must Go On",
            artist: "Queen",
            audioFileName: "showMustGoOn",
            albumCoverName: "showMustGoOnCover"
        )
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        tracks[.letItBe]?.nextTrack = tracks[.yesterday]
        tracks[.yesterday]?.nextTrack = tracks[.showMustGoOn]
        tracks[.yesterday]?.prevTrack = tracks[.letItBe]
        tracks[.showMustGoOn]?.prevTrack = tracks[.yesterday]
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songPlayerVC = segue.destination as? SongPlayerViewController,
              let sender = sender as? UIView else { return }
        switch sender {
        case letItBeTrack:
            songPlayerVC.track = tracks[.letItBe]
            songPlayerVC.track?.nextTrack = tracks[.yesterday]
        case yesterdayTrack:
            songPlayerVC.track = tracks[.yesterday]
            songPlayerVC.track?.nextTrack = tracks[.showMustGoOn]
            songPlayerVC.track?.prevTrack = tracks[.letItBe]
        case showMustGoOnTrack:
            songPlayerVC.track = tracks[.showMustGoOn]
            songPlayerVC.track?.prevTrack = tracks[.yesterday]
        default:
            return
        }
    }

    // MARK: - Private Methods/IBAction

    @IBAction private func openSongPlayer(_ sender: UIView) {
        performSegue(withIdentifier: "openSongPlayer", sender: sender)
    }
}
