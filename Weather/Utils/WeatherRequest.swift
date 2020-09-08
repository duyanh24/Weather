//
//  WeatherRequest.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    var query: [String: String]
    var url: URL?
    init(location: CLLocationCoordinate2D) {
        self.query = ["lat": String(location.latitude), "lon": String(location.longitude), "exclude": "minutely", "appid": Constants.APIKey]
        if let url = URLs.baseURLAPI?.withQueries(query) {
            self.url = url
        }
    }
}
