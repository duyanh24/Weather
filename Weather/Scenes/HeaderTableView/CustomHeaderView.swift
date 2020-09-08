//
//  CustomHeaderView.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    private let topView = UIView()
    private let todayLabel = UILabel()
    private let minTemLabel = UILabel()
    private let maxTemLabel = UILabel()
    private let headerColectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var dataHourly: [Hourly]? {
        didSet {
            headerColectionView.reloadData()
        }
    }
    var timezoneOffset: Int?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupBackgound()
        setupColectionView()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgound() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 177/255, alpha: 1)
    }
    
    private func configureContents() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemLabel.translatesAutoresizingMaskIntoConstraints = false
        headerColectionView.translatesAutoresizingMaskIntoConstraints = false
        	
        topView.addSubview(todayLabel)
        topView.addSubview(minTemLabel)
        topView.addSubview(maxTemLabel)
        contentView.addSubview(topView)
        contentView.addSubview(headerColectionView)
        contentView.backgroundColor = .clear
        
        topView.backgroundColor = .clear
        
        todayLabel.textColor = .white
        //todayLabel.text = "Tuesday Today"
        
        minTemLabel.textColor = .white
        //minTemLabel.text = "25"
        minTemLabel.font = UIFont.systemFont(ofSize: 19)
        minTemLabel.textColor = UIColor(red: 123/255, green: 185/255, blue: 213/255, alpha: 1)
        
        maxTemLabel.textColor = .white
        //maxTemLabel.text = "32"
        maxTemLabel.font = UIFont.systemFont(ofSize: 19)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),
            
            todayLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            todayLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            minTemLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            minTemLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            maxTemLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -60),
            maxTemLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            headerColectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -1),
            headerColectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            headerColectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            headerColectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupColectionView() {
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        headerColectionView.setCollectionViewLayout(layout, animated: true)
        headerColectionView.showsHorizontalScrollIndicator = false
        headerColectionView.backgroundColor = .clear
        headerColectionView.layer.borderColor = UIColor(red: 105/255, green: 177/255, blue: 209/255, alpha: 1).cgColor
        headerColectionView.layer.borderWidth = 1.0
        headerColectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        headerColectionView.delegate = self
        headerColectionView.dataSource = self
        headerColectionView.contentInset.right = 10
        headerColectionView.contentInset.left = 10
    }
    
    func setupWeekday(durationTimeToday: Int) {
        todayLabel.text = Converter.convertDurationTimeToWeekday(durationTime: durationTimeToday, timezoneOffset: timezoneOffset ?? 0) + " Today"
    }
}

extension CustomHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataHourly = dataHourly else {
            return 0
        }
        return dataHourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let dataHourly = dataHourly else {
            return UICollectionViewCell()
        }
        cell.setupDatatest(hourly: dataHourly[indexPath.row], timezoneOffset: timezoneOffset ?? 0)
        return cell
    }
}

extension CustomHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateContentWidthColectionView(index: indexPath.row)
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension CustomHeaderView {
    func calculateContentWidthColectionView(index: Int) -> CGFloat {
        let tempLabel = UILabel()
        
        guard let dataHourly = dataHourly else {
            return CGFloat()
        }
        
        if dataHourly[index].sunrise == true {
            tempLabel.text = "Sunrise"
        } else if dataHourly[index].sunset == true {
            tempLabel.text = "Sunset"
        } else {
            tempLabel.text = "35"
        }
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        
        let widthTempLabel = tempLabel.intrinsicContentSize.width + 20
        
        guard let width = [widthTempLabel, 60].max() else { return .zero }
        return CGFloat(width)
    }
}
