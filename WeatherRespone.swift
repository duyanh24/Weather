//
//  WeatherRespone.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct WeatherRespone: Codable {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var current: Current
    var hourly: [HourlyRespone]
    var daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone
        case current
        case hourly
        case daily
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try valueContainer.decode(Double.self, forKey: CodingKeys.latitude)
        self.longitude = try valueContainer.decode(Double.self, forKey: CodingKeys.longitude)
        self.timezone = try valueContainer.decode(String.self, forKey: CodingKeys.timezone)
        self.current = try valueContainer.decode(Current.self, forKey: CodingKeys.current)
        self.hourly = try valueContainer.decode([HourlyRespone].self, forKey: CodingKeys.hourly)
        self.daily = try valueContainer.decode([Daily].self, forKey: CodingKeys.daily)
    }
}
