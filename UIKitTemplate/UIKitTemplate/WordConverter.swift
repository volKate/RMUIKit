// WordConverter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель принимающая слово и разворачивающая его
struct WordConverter {
    private(set) var word: String

    /// Вычисляемое перевернутое слово
    var converted: String {
        String(word.lowercased().reversed()).capitalized
    }
}
