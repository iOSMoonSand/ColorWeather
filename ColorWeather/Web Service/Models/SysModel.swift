//
//  SysModel.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 12/30/19.
//  Copyright © 2019 iOS MoonSand. All rights reserved.
//

/// SysModel mirrors the JSON response obtained by calling the /weather endpoint
/// (AKA Current Weather) on the OpenWeather API. SysModel includes only the properties
/// needed for ColorWeather.
///
/// The full response object is structured as such:
/// * sys
///     * sys.type Internal OWM parameter
///     * sys.id Internal OWM parameter
///     * sys.message Internal OWM parameter
///     * sys.country Country code (GB, JP etc.)
///     * sys.sunrise Sunrise time, unix, UTC
///     * sys.sunset Sunset time, unix, UTC
///
struct SysModel {
    var sunrise: Double?
    var sunset: Double?
}

private struct Constants {
    static let sunrise = "sunrise"
    static let sunset = "sunset"
}

extension SysModel {
    init?(jsonDictionary: JSONDictionary) {
        // We create a mirror of the current object and iterate over its properties
        // (children) to check if all values are nil. If so, the server was unable to
        // send us the data we need so we'll return nil instead of returning an empty model object.
        let mainMirror = Mirror(reflecting: self)
        guard !(mainMirror.children.compactMap { $0 }).isEmpty else {
            return nil
        }
        
        self.sunrise = jsonDictionary[Constants.sunrise] as? Double
        self.sunset = jsonDictionary[Constants.sunset] as? Double
    }
}
