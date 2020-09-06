//
//  ViewController.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var containerTempView: UIView!
    @IBOutlet weak var topView: UIView!
    
    // fake data
    private var dataTest = ["1","1","1","1","1","1","1","1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setupTableView()
        
        WeatherServiceAPI.share.fetchDataWeather(input: WeatherRequest(), completion: { result in
            guard let result = result else {
                return
            }
            print(result)
        })
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
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataTest.count - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InforDetailTableViewCell", for: indexPath) as? InforDetailTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekDayTableViewCell", for: indexPath) as? WeekDayTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomHeaderView()
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
