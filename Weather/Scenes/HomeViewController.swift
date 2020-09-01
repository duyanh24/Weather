//
//  ViewController.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var headerView: UIView!
    
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setupTableView()
        // Do any additional setup after loading the view.
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
        //homeTableView.register(UINib(nibName: "HeaderView", bundle: nil), forCellReuseIdentifier: "HeaderView")
        homeTableView.register(UINib(nibName: "WeekDayTableViewCell", bundle: nil), forCellReuseIdentifier: "WeekDayTableViewCell")
        homeTableView.dataSource = self
        homeTableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        homeTableView.delegate = self
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekDayTableViewCell", for: indexPath) as? WeekDayTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                    "sectionHeader") as! CustomHeaderView

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//         return "Temp"
//    }
    
}
