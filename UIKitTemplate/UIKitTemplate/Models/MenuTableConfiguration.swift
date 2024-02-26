// MenuTableConfiguration.swift
// Copyright © RoadMap. All rights reserved.

/// Конфигурация таблицы имплементаций светофора
struct MenuTableConfiguration {
    /// Виды имплементаций
    enum LightsTaskImplementation {
        /// Сториборд
        case storyboard
        /// NSLayoutConstraint
        case nsConstraints
        /// NSLayoutAnchor
        case anchors
        /// Стэк
        case stackView
        /// Визуальный форматтер
        case visualFormatLanguage
    }

    /// Реализованные имплементации
    let lightsTaskImplementations: [LightsTaskImplementation] = [.storyboard, .nsConstraints, .anchors, .stackView]
    /// Мапа имплементаций к лейблам ячеек
    let taskImplementationsNameMap: [LightsTaskImplementation: String] = [
        .storyboard: "Storyboard",
        .nsConstraints: "NSLayoutConstrainst",
        .anchors: "NSLayoutAnchors",
        .stackView: "UIStackView",
        .visualFormatLanguage: "Visual Format Language"
    ]

    /// Идентификатор ViewController со сториборда
    let storyboardViewControllerId = "LightsStoryboardViewController"
    /// Имя сториборда
    let storyboardName = "Main"
}
