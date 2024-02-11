// Track.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Track model describing main features
class Track {
    let name: String
    let artist: String
    let audioFileName: String
    let albumCoverName: String
    var prevTrack: Track?
    var nextTrack: Track?

    init(name: String, artist: String, audioFileName: String, albumCoverName: String) {
        self.name = name
        self.artist = artist
        self.audioFileName = audioFileName
        self.albumCoverName = albumCoverName
    }
}
