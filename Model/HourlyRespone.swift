//
//  Hourly.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct HourlyRespone: Codable {
    var durationTime: Int
    var temp: Double
    var feelLike: Double
    var pressure: Int
    var humidity: Int
    var visibility: Int?
    var windSpeed: Double
    var weather: [Weather]
    var sunrise = false
    var sunset = false
    
    enum CodingKeys: String, CodingKey {
        case durationTime = "dt"
        case temp
        case feelLike = "feels_like"
        case pressure
        case humidity
        case visibility
        case windSpeed = "wind_speed"
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.durationTime = try valueContainer.decode(Int.self, forKey: CodingKeys.durationTime)
        self.temp = try valueContainer.decode(Double.self, forKey: CodingKeys.temp)
        self.feelLike = try valueContainer.decode(Double.self, forKey: CodingKeys.feelLike)
        self.pressure = try valueContainer.decode(Int.self, forKey: CodingKeys.pressure)
        self.humidity = try valueContainer.decode(Int.self, forKey: CodingKeys.humidity)
        self.visibility = try? valueContainer.decode(Int.self, forKey: CodingKeys.visibility)
        self.windSpeed = try valueContainer.decode(Double.self, forKey: CodingKeys.windSpeed)
        self.weather = try valueContainer.decode([Weather].self, forKey: CodingKeys.weather)
    }
}
