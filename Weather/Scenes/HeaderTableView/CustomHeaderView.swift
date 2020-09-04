//
//  CustomHeaderView.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    let topView = UIView()
    let todayLabel = UILabel()
    let minTemLabel = UILabel()
    let maxTemLabel = UILabel()
    let headerColectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    // fake data
    let dataTest = ["12h", "sunrise", "sunset", "duyanh", "1h", "4h","12h", "sunrise", "sunset", "duyanh", "1h", "4h"]

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupColectionView()
        configureContents()
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 177/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        todayLabel.text = "Tuesday Today"
        
        minTemLabel.textColor = .white
        minTemLabel.text = "25"
        minTemLabel.font = UIFont(name: "System", size: 19)
        minTemLabel.textColor = UIColor(red: 123/255, green: 185/255, blue: 213/255, alpha: 1)
        
        maxTemLabel.textColor = .white
        maxTemLabel.text = "32"
        maxTemLabel.font = UIFont(name: "System", size: 19)
        
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
}

extension CustomHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.timeLabel.text = dataTest[indexPath.row]
        return cell
    }
}

extension CustomHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let timeLabel = UILabel()
        let tempLabel = UILabel()
        timeLabel.text = dataTest[indexPath.row]
        timeLabel.font = UIFont(name: "System", size: 17)
        tempLabel.text = "35"
        tempLabel.font = UIFont(name: "System", size: 20)
        
        let widthTimeLabel = timeLabel.intrinsicContentSize.width + 20
        let widthTempLabel = tempLabel.intrinsicContentSize.width + 20
        
        guard let width = [widthTimeLabel, widthTempLabel, 50].max() else { return CGSize() }
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
