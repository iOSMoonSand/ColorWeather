//
//  MainModel.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

/// MainModel mirrors the JSON response obtained by calling the /weather endpoint
/// (AKA Current Weather) on the OpenWeather API. MainModel includes only the properties
/// needed for ColorWeather.
///
/// The full response object is structured as such:
/// * main
///     * main.temp: Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
///     * main.pressure: Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
///     * main.humidity: Humidity, %
///     * main.temp_min: Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
///     * main.temp_max: Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
///     * main.sea_level: Atmospheric pressure on the sea level, hPa
///     * main.grnd_level: Atmospheric pressure on the ground level, hPa
///
struct MainModel {
    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
}

private struct Constants {
    static let temp = "temp"
    static let tempMin = "temp_min"
    static let tempMax = "temp_max"
}

extension MainModel {
    init?(jsonDictionary: JSONDictionary) {
        // We create a mirror of the current object and iterate over its properties
        // (children) to check if all values are nil. If so, the server was unable to
        // send us the data we need so we'll return nil instead of returning an empty model object.
        let mainMirror = Mirror(reflecting: self)
        guard !(mainMirror.children.compactMap { $0 }).isEmpty else {
            return nil
        }
        
        self.temp = jsonDictionary[Constants.temp] as? Double
        self.tempMin = jsonDictionary[Constants.tempMin] as? Double
        self.tempMax = jsonDictionary[Constants.tempMax] as? Double
    }
}
