//
//  URLs.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct URLs {
    static let baseStringUrlAPI = "https://api.openweathermap.org/data/2.5/onecall?"
    static var baseURLAPI = URL(string: baseStringUrlAPI)
    static var baseStringUrlIcon = "https://openweathermap.org/img/wn/"
    
    static func getUrlIcon(image: String) -> URL? {
        let url = baseStringUrlIcon + image + "@2x.png"
        return URL(string: url)
    }
}
