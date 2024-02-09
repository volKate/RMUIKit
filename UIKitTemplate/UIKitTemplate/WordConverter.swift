// WordConverter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// WordConverted Model
struct WordConverter {
    private(set) var word: String

    var converted: String {
        String(word.lowercased().reversed()).capitalized
    }
}
