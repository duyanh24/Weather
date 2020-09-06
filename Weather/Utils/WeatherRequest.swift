//
//  WeatherRequest.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct WeatherRequest {
    var query: [String: String]
    var url: URL?
    init() {
        self.query = ["lat": "33.441792", "lon": "-94.03768", "exclude": "minutely", "appid": Constants.APIKey]
        if let url = URLs.baseURL?.withQueries(query) {
            self.url = url
        }
    }
}
