//
//  WeekDayTableViewCell.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {

    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupData(daily: Daily, timezoneOffset: Int) {
        weekdayLabel.text = Converter.convertDurationTimeToWeekday(durationTime: daily.durationTime, timezoneOffset: timezoneOffset)
        maxTempLabel.text = String(Converter.convertKelvinToCencius(kelvin: daily.temp.max))
        minTempLabel.text = String(Converter.convertKelvinToCencius(kelvin: daily.temp.min))
        guard let urlIcon = URLs.getUrlIcon(image: daily.weather[0].icon) else {
            return
        }
        iconImage.downloaded(from: urlIcon)
    }
}
