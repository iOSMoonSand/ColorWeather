//
//  ForecastView.swift
//  ColorWeather
//
//  Created by Alexis Schreier on 01/07/20.
//  Copyright © 2020 iOS MoonSand. All rights reserved.
//

import SwiftUI

struct ForecastView: View {
    
    private var dataModels: [TriHourlyForecastDataModel]
    private var units: UnitTemperature
    
    var body: some View {
        
        let firstForecastObjectLow = Utilities.convert(temperature: dataModels[0].tempMin,
                                                       from: .kelvin,
                                                       to: units)
        let firstForecastObjectHigh = Utilities.convert(temperature: dataModels[0].tempMax,
                                                        from: .kelvin,
                                                        to: units)
        let secondForecastObjectLow = Utilities.convert(temperature: dataModels[1].tempMin,
                                                        from: .kelvin,
                                                        to: units)
        let secondForecastObjectHigh = Utilities.convert(temperature: dataModels[1].tempMax,
                                                         from: .kelvin,
                                                         to: units)
        let thirdForecastObjectLow = Utilities.convert(temperature: dataModels[2].tempMin,
                                                       from: .kelvin,
                                                       to: units)
        let thirdForecastObjectHigh = Utilities.convert(temperature: dataModels[2].tempMax,
                                                        from: .kelvin,
                                                        to: units)
        
        return VStack(alignment: .center) {
            
            Divider()
                .background(Color.white)
            
            ForecastRow(time: dataModels[0].forecastTime ?? UIConstants.Shared.noDataDefault,
                        icon: dataModels[0].icon ?? "",
                        lowTemp: firstForecastObjectLow,
                        highTemp: firstForecastObjectHigh)
            
            Divider()
                .background(Color.white)
            
            ForecastRow(time: dataModels[1].forecastTime ?? UIConstants.Shared.noDataDefault,
                        icon: dataModels[1].icon ?? "",
                        lowTemp: secondForecastObjectLow,
                        highTemp: secondForecastObjectHigh)
            
            Divider()
                .background(Color.white)
            
            ForecastRow(time: dataModels[2].forecastTime ?? UIConstants.Shared.noDataDefault,
                        icon: dataModels[2].icon ?? "",
                        lowTemp: thirdForecastObjectLow,
                        highTemp: thirdForecastObjectHigh)
                .padding([.bottom], 20)
        }
    }
    
    init(dataModels: [TriHourlyForecastDataModel], units: UnitTemperature) {
        self.dataModels = dataModels
        self.units = units
    }
}
