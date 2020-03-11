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
            
            ZStack(alignment: .center) {
                HStack(spacing: 60) {
                    Text("\(dataModels[0].forecastTime ?? UIConstants.Shared.noDataDefault)")
                        .foregroundColor(Color.white)
                        .shadow(radius: 1)
                        .frame(width: 120, height: 40, alignment: .trailing)
                    
                    HStack {
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.lowTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(firstForecastObjectLow)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.highTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(firstForecastObjectHigh)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                    }
                    .frame(width: 120, height: 40, alignment: .leading)
                }
                
                if dataModels[0].icon != nil {
                    Image(dataModels[0].icon!).asThumbnail()
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(Color.white)
                }
            }
            
            Divider()
                .background(Color.white)
            
            ZStack(alignment: .center) {
                HStack(spacing: 60) {
                    Text("\(dataModels[1].forecastTime ?? UIConstants.Shared.noDataDefault)")
                        .foregroundColor(Color.white)
                        .shadow(radius: 1)
                        .frame(width: 120, height: 40, alignment: .trailing)
                    
                    HStack {
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.lowTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(secondForecastObjectLow)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.highTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(secondForecastObjectHigh)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                    }
                    .frame(width: 120, height: 40, alignment: .leading)
                    
                }
                
                if dataModels[1].icon != nil {
                    Image(dataModels[1].icon!).asThumbnail()
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(Color.white)
                }
            }
            
            Divider()
                .background(Color.white)
            
            ZStack(alignment: .center) {
                HStack(spacing: 60) {
                    Text("\(dataModels[2].forecastTime ?? UIConstants.Shared.noDataDefault)")
                        .foregroundColor(Color.white)
                        .shadow(radius: 1)
                        .frame(width: 120, height: 40, alignment: .trailing)
                    
                    HStack {
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.lowTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(thirdForecastObjectLow)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                        HStack(spacing: 3) {
                            Text(UIConstants.Shared.highTempSymbol)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                            Text(thirdForecastObjectHigh)
                                .foregroundColor(Color.white)
                                .shadow(radius: 1)
                        }
                    }
                    .frame(width: 120, height: 40, alignment: .leading)
                }
                
                if dataModels[2].icon != nil {
                    Image(dataModels[2].icon!).asThumbnail()
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(Color.white)
                }
            }
            .padding([.bottom], 20)
        }
    }
    
    init(dataModels: [TriHourlyForecastDataModel], units: UnitTemperature) {
        self.dataModels = dataModels
        self.units = units
    }
}
