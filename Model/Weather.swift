//
//  Weather.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.main = try valueContainer.decode(String.self, forKey: CodingKeys.main)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.icon = try valueContainer.decode(String.self, forKey: CodingKeys.icon)
    }
}
