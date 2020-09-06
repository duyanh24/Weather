//
//  WeatherServiceAPI.swift
//  Weather
//
//  Created by Apple on 9/6/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

class WeatherServiceAPI {
    
    static let share = WeatherServiceAPI()
    
    func fetchDataWeather(input: WeatherRequest, completion: @escaping (WeatherRespone?) -> Void){
        guard let url = input.url else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let weatherRespone = try jsonDecoder.decode(WeatherRespone.self, from: data)
                    //print(weatherRespone)
                    completion(weatherRespone)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            } else {
                completion(nil)
                return
            }
        }
        task.resume()
    }
}
