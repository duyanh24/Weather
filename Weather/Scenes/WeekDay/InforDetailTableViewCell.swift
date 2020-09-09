//
//  InforDetailTableViewCell.swift
//  Weather
//
//  Created by AnhLD on 9/4/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class InforDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupData(current: Current, timezoneOffset: Int) {
        sunriseLabel.text = Converter.convertDurationTimeToHourMinute(durationTime: current.sunrise, timezoneOffset: timezoneOffset)
        sunsetLabel.text = Converter.convertDurationTimeToHourMinute(durationTime: current.sunset, timezoneOffset: timezoneOffset)
        visibilityLabel.text = String(current.visibility! / 1000) + " km"
        humidityLabel.text = String(current.humidity)
        windLabel.text = String(current.windSpeed) + " km/h"
        uvLabel.text = String(current.uvi)
        pressureLabel.text = String(current.pressure) + " hPa"
    }
}
