// Calculator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Calculator model
struct Calculator {
    func sum(_ firstOperand: Int, _ secondOperand: Int) -> Int {
        firstOperand + secondOperand
    }

    func substract(_ firstOperand: Int, _ secondOperand: Int) -> Int {
        firstOperand - secondOperand
    }

    func multiply(_ firstOperand: Int, by secondOperand: Int) -> Int {
        firstOperand * secondOperand
    }

    func divide(_ firstOperand: Int, by secondOperand: Int) -> Double {
        Double(firstOperand) / Double(secondOperand)
    }
}
