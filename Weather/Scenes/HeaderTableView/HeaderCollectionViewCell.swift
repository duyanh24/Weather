//
//  HeaderCollectionViewCell.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(hourly: HourlyRespone, timezoneOffset: Int) {
        timeLabel.text = Converter.convertDurationTimeToHour(durationTime: hourly.durationTime, timezoneOffset: timezoneOffset) + "h"
        tempLabel.text = String(Converter.convertKelvinToCencius(kelvin: hourly.temp)) + "°"
        guard let urlIcon = URLs.getUrlIcon(image: hourly.weather[0].icon) else {
            return
        }
        iconImage.downloaded(from: urlIcon)
    }
    
    func setupDatatest(hourly: Hourly, timezoneOffset: Int) {
        if hourly.sunrise == true {
            timeLabel.text = Converter.convertDurationTimeToHourMinute(durationTime: hourly.durationTime, timezoneOffset: timezoneOffset)
            tempLabel.text = "Sunrise"
            iconImage.image = UIImage(named: "sunrise")
        } else if hourly.sunset == true {
            timeLabel.text = Converter.convertDurationTimeToHourMinute(durationTime: hourly.durationTime, timezoneOffset: timezoneOffset)
            tempLabel.text = "Sunset"
            iconImage.image = UIImage(named: "sunset")
        } else {
            timeLabel.text = Converter.convertDurationTimeToHour(durationTime: hourly.durationTime, timezoneOffset: timezoneOffset) + "h"
            tempLabel.text = String(Converter.convertKelvinToCencius(kelvin: hourly.temp)) + "°"
            guard let urlIcon = URLs.getUrlIcon(image: hourly.icon) else {
                return
            }
            iconImage.downloaded(from: urlIcon)
        }
    }
}
