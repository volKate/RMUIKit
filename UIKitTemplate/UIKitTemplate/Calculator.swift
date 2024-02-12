// Calculator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель выполняющая основные математические операции над двумя операндами
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
        if secondOperand != 0 {
            return Double(firstOperand) / Double(secondOperand)
        }
        return 0
    }
}
