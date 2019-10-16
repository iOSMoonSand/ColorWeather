//
//  WeatherModel.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 09/19/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

/// WeatherModel mirrors the JSON response obtained by calling the /weather endoint
/// (AKA Current Weather) on the OpenWeather API. WeatherModel only includes the properties
/// needed for ColorWeather.
///
/// The full response object is structured as such:
/// * weather (more info Weather condition codes)
///     * weather.id: Weather condition id
///     * weather.main: Group of weather parameters (Rain, Snow, Extreme, Clouds etc.)
///     * weather.description: Weather condition within the group
///     * weather.icon: Weather icon id
///
struct WeatherModel {
    var description: String?
    var icon: String?
}

private struct Constants {
    static let description = "description"
    static let icon = "icon"
}

extension WeatherModel {
    init?(jsonDictionary: JSONDictionary) {
        // We create a mirror of the current object and iterate over its properties
        // (children) to check if all values are nil. If so, the server was unable to
        // send us the data we need so we'll return nil instead of returning an empty model object.
        let weatherMirror = Mirror(reflecting: self)
        guard !(weatherMirror.children.compactMap { $0 }).isEmpty else {
            return nil
        }
        
        self.description = jsonDictionary[Constants.description] as? String
        self.icon = jsonDictionary[Constants.icon] as? String
    }
}
