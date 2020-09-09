//
//  Hourly.swift
//  Weather
//
//  Created by Apple on 9/7/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

class Hourly {
    var durationTime: Int
    var sunrise = false
    var sunset = false
    var temp: Double
    var icon: String
    
    init(durationTime: Int, sunrise: Bool, sunset: Bool, temp: Double, icon: String) {
        self.durationTime = durationTime
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.icon = icon
    }
}
