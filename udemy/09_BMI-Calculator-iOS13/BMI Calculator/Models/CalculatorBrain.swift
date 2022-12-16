//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Wooyoung on 2022/12/16.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat More", color: .blue)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fine", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "Loose Weight", color: .red)
        }
    }
    
    func getBMIValue() -> String {
        let bmiToString = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiToString
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? ""
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
}
