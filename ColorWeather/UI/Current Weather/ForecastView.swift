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
            HStack(spacing: 16) {
                Text("\(dataModels[0].forecastTime ?? UIConstants.Shared.noDataDefault)")
                    .foregroundColor(ColorConstants.Text.darkGray)
                
                if dataModels[0].icon != nil {
                    Image(dataModels[0].icon!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30,
                               height: 30,
                               alignment: .center)
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(ColorConstants.Text.darkGray)
                }
                
                HStack {
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.lowTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(firstForecastObjectLow)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.highTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(firstForecastObjectHigh)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                }
            }
            
            Divider()
            HStack(spacing: 16) {
                Text("\(dataModels[1].forecastTime ?? UIConstants.Shared.noDataDefault)")
                    .foregroundColor(ColorConstants.Text.darkGray)
                
                if dataModels[1].icon != nil {
                    Image(dataModels[1].icon!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30,
                               height: 30,
                               alignment: .center)
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(ColorConstants.Text.darkGray)
                }
                
                HStack {
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.lowTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(secondForecastObjectLow)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.highTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(secondForecastObjectHigh)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                }
            }
            Divider()
            HStack(spacing: 16) {
                Text("\(dataModels[2].forecastTime ?? UIConstants.Shared.noDataDefault)")
                    .foregroundColor(ColorConstants.Text.darkGray)
                
                if dataModels[2].icon != nil {
                    Image(dataModels[2].icon!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30,
                               height: 30,
                               alignment: .center)
                } else {
                    Text(UIConstants.Shared.noDataDefault)
                        .foregroundColor(ColorConstants.Text.darkGray)
                }
                
                HStack {
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.lowTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(thirdForecastObjectLow)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                    HStack(spacing: 3) {
                        Text(UIConstants.Shared.highTempSymbol)
                            .foregroundColor(ColorConstants.Text.darkGray)
                        Text(thirdForecastObjectHigh)
                            .foregroundColor(ColorConstants.Text.darkGray)
                    }
                }
            }.padding([.bottom], 20)
        }
    }
    
    init(dataModels: [TriHourlyForecastDataModel], units: UnitTemperature) {
        self.dataModels = dataModels
        self.units = units
    }
}
