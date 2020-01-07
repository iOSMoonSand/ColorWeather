//
//  Utilities.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/30/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

import Foundation

struct Utilities {
    
    static func convert(temperature: Double?, from inputUnit: UnitTemperature, to outputUnit: UnitTemperature) -> String {
        
        guard let temperature = temperature else {
            return "--"
        }
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        let input = Measurement(value: temperature, unit: inputUnit)
        let output = input.converted(to: outputUnit)
        
        return measurementFormatter.string(from: output)
    }
}
