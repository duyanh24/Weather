//
//  ViewController.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var containerTempView: UIView!
    @IBOutlet weak var topView: UIView!
    
    // fake data
    private var dataTest = ["1","1","1","1","1","1","1","1"]
    private var weatherRespone: WeatherRespone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setupTableView()
        fetchData()
        
    }
    
    private func assignBackground() {
        let background = UIImage(named: "Background _Normal")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func setupTableView() {
        homeTableView.register(UINib(nibName: "WeekDayTableViewCell", bundle: nil), forCellReuseIdentifier: "WeekDayTableViewCell")
        homeTableView.register(UINib(nibName: "InforDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InforDetailTableViewCell")
        homeTableView.dataSource = self
        homeTableView.delegate = self
    }
    
    private func fetchData() {
        WeatherAPIService.share.fetchDataWeather(input: WeatherRequest(), completion: { result in
            guard let result = result else {
                return
            }
            self.weatherRespone = result
            self.setupData()
        })
    }
    
    private func setupData() {
        DispatchQueue.main.async {
            guard let weatherRespone = self.weatherRespone  else {
                return
            }
            self.configData()
            self.locationLabel.text = weatherRespone.timezone
            self.tempLabel.text = String(Converter.convertKelvinToCencius(kelvin: weatherRespone.current.temp)) + "°"
            self.homeTableView.reloadData()
           
        }
    }
    
    var hourly: [Hourly] = Array()
    private func configData(){
        guard let weatherRespone = weatherRespone  else {
            return
        }
        
        print(Converter.convertDurationTimeToHourMinute2(durationTime: weatherRespone.current.durationTime))
        print(Converter.convertDurationTimeToHourMinute2(durationTime: weatherRespone.current.sunrise))
        print(Converter.convertDurationTimeToHourMinute2(durationTime: weatherRespone.current.sunset))
        print("----")
        for value in weatherRespone.hourly {
            hourly.append(Hourly(durationTime: value.durationTime, sunrise: false, sunset: false, temp: value.temp, icon: value.weather[0].icon))
            print(Converter.convertDurationTimeToHourMinute2(durationTime: value.durationTime))
        }

        print("----")
        for (index, value) in hourly.enumerated() {
            if weatherRespone.current.sunrise > value.durationTime {
                print(Converter.convertDurationTimeToHourMinute2(durationTime: weatherRespone.current.sunrise))
                hourly.insert(Hourly(durationTime: weatherRespone.current.sunrise, sunrise: true, sunset: false, temp: 0, icon: ""), at: index)
                break
            }
        }
        print("----")
        for (index, value) in hourly.enumerated() {
            if weatherRespone.current.sunset < value.durationTime {
                print(Converter.convertDurationTimeToHourMinute2(durationTime: weatherRespone.current.sunset))
                hourly.insert(Hourly(durationTime: weatherRespone.current.sunset, sunrise: false, sunset: true, temp: 0, icon: ""), at: index)
                break
            }
        }
        print("----")
        for value in hourly {
            print(Converter.convertDurationTimeToHourMinute2(durationTime: value.durationTime))
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherRespone = weatherRespone  else {
            return 0
        }
        return weatherRespone.daily.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherRespone = weatherRespone  else {
            return UITableViewCell()
        }
        
        if indexPath.row == weatherRespone.daily.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InforDetailTableViewCell", for: indexPath) as? InforDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.setupData(current: weatherRespone.current)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekDayTableViewCell", for: indexPath) as? WeekDayTableViewCell else {
            return UITableViewCell()
        }
        cell.setupData(daily: weatherRespone.daily[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomHeaderView()
        guard let weatherRespone = weatherRespone  else {
            return UIView()
        }
        view.dataHourly = weatherRespone.hourly
        view.dataHourlytest = hourly
        view.setupWeekday(durationTimeToday: weatherRespone.current.durationTime)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                self.containerTempView.isHidden = true
                self.topView.isHidden = true
            })
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.topView.isHidden = false
                self.containerTempView.isHidden = false
            })
        }
    }
}
