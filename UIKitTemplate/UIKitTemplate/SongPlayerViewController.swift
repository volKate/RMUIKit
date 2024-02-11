// SongPlayerViewController.swift
// Copyright © RoadMap. All rights reserved.

import AVFoundation
import UIKit

/// VC with song player, opens modally, has player controls: play/pause, rewind, quickRewind
final class SongPlayerViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var trackArtistLabel: UILabel!
    @IBOutlet private var trackProgressSlider: UISlider!
    @IBOutlet private var timeLeftLabel: UILabel!
    @IBOutlet private var playPauseButton: UIButton!

    // MARK: - Public Properties

    var track: Track?
    var nextTrack: Track?
    var prevTrack: Track?

    // MARK: - Private Properties

    private var player: AVAudioPlayer?
    private var timer: Timer?
    private var isPlaying: Bool {
        if let player {
            return player.isPlaying
        }
        return false
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }

    // MARK: - Private Methods/IBAction

    private func setupPlayer() {
        trackNameLabel.text = track?.name
        trackArtistLabel.text = track?.artist

        if let trackAudioFile = track?.audioFileName, let url = Bundle.main.url(
            forResource: trackAudioFile,
            withExtension: "wav"
        ) {
            do {
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            } catch {}
        }

        player?.play()
        setTimer()
    }

    private func setTimer() {
        // setup timer for updating slider and timeLeft
        if player != nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                if let self, self.isPlaying == false {
                    timer.invalidate()
                    playPauseButton.setImage(.play, for: .normal)
                    return
                } else {
                    self?.updateProgressUI()
                }
            }
        }
    }

    private func playNext() {}

    private func updateProgressUI() {
        if let player {
            let totalSecondsLeft = Int(player.duration - player.currentTime)
            let minutesLeft = String(format: "%02d", totalSecondsLeft / 60)
            let secondsLeft = String(format: "%02d", totalSecondsLeft % 60)

            timeLeftLabel.text = "\(minutesLeft):\(secondsLeft)"
            trackProgressSlider.value = Float(player.currentTime / player.duration)
        }
    }

    @IBAction private func playPauseSong(_ sender: UIButton) {
        if let player {
            if isPlaying {
                timer?.invalidate()
                player.stop()
                playPauseButton.setImage(.play, for: .normal)
            } else {
                setTimer()
                player.play()
                playPauseButton.setImage(.pause, for: .normal)
            }
            updateProgressUI()
        }
    }

    @IBAction private func rewindTrack(_ sender: UISlider) {
        if let player {
            timer?.invalidate()
            let newTime = Double(sender.value) * player.duration
            player.currentTime = newTime
            setTimer()
        }
    }

    @IBAction private func closePlayer(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
