//
//  Temp.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct Temp: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var evening: Double
    var morning: Double
    
    enum CodingKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case evening = "eve"
        case morning = "morn"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try valueContainer.decode(Double.self, forKey: CodingKeys.day)
        self.min = try valueContainer.decode(Double.self, forKey: CodingKeys.min)
        self.max = try valueContainer.decode(Double.self, forKey: CodingKeys.max)
        self.night = try valueContainer.decode(Double.self, forKey: CodingKeys.night)
        self.evening = try valueContainer.decode(Double.self, forKey: CodingKeys.evening)
        self.morning = try valueContainer.decode(Double.self, forKey: CodingKeys.morning)
    }
}
