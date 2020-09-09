//
//  ViewController.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var containerTempView: UIView!
    @IBOutlet weak var topView: UIView!
    
    private var weatherRespone: WeatherRespone?
    private var hourly: [Hourly] = Array()
    private var checkDayAndNight = 0
    private var timer = Timer()
    private let locationManager = CLLocationManager()
    private var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLocation()
    }
    
    // call api every 10 minutes
    private func scheduledTimer() {
        fetchData()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(self.fetchData), userInfo: nil, repeats: true)
    }
    
    private func setupBackground(nameImage: String) {
        let background = UIImage(named: nameImage)
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
    
    private func setupLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.requestLocation()
        }
    }
    
    @objc private func fetchData() {
        guard let location = location else {
            self.showToast(message : "Can't get location ")
            return
        }
        WeatherAPIService.share.fetchDataWeather(input: WeatherRequest(location: location), completion: { result in
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
                self.showToast(message : "Can't get location ")
                return
            }
            self.configData()
            self.locationLabel.text = weatherRespone.timezone
            self.tempLabel.text = String(Converter.convertKelvinToCencius(kelvin: weatherRespone.current.temp)) + "°"
            self.homeTableView.reloadData()
            if self.checkDayAndNight == 1 {
                self.setupBackground(nameImage: Constants.BackgroundDay)
            } else {
                self.setupBackground(nameImage: Constants.BackgroundNight)
            }
        }
    }
    
    private func configData(){
        guard let weatherRespone = weatherRespone  else {
            return
        }
        
        for value in weatherRespone.hourly {
            hourly.append(Hourly(durationTime: value.durationTime, sunrise: false, sunset: false, temp: value.temp, icon: value.weather[0].icon))
            if Converter.convertDurationTimeToHour(durationTime: value.durationTime, timezoneOffset: weatherRespone.timezoneOffset) == "23" {
                break
            }
        }

        for index in 0..<hourly.count-1 {
            if weatherRespone.current.sunrise > hourly[index].durationTime
                && weatherRespone.current.sunrise < hourly[index+1].durationTime {
                hourly.insert(Hourly(durationTime: weatherRespone.current.sunrise, sunrise: true, sunset: false, temp: 0, icon: ""), at: index)
                checkDayAndNight += 1
                break
            }
        }
        
        for index in 0..<hourly.count-1 {
            if weatherRespone.current.sunset > hourly[index].durationTime
                && weatherRespone.current.sunset < hourly[index+1].durationTime {
                hourly.insert(Hourly(durationTime: weatherRespone.current.sunset, sunrise: false, sunset: true, temp: 0, icon: ""), at: index)
                checkDayAndNight += 1
                break
            }
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
            cell.setupData(current: weatherRespone.current, timezoneOffset: weatherRespone.timezoneOffset)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekDayTableViewCell", for: indexPath) as? WeekDayTableViewCell else {
            return UITableViewCell()
        }
        cell.setupData(daily: weatherRespone.daily[indexPath.row], timezoneOffset: weatherRespone.timezoneOffset)
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
        view.dataHourly = hourly
        view.timezoneOffset = weatherRespone.timezoneOffset
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

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = locValue
        scheduledTimer()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.showToast(message : "Can't get location ")
    }
}
