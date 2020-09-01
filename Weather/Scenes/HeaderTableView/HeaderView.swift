//
//  HeaderView.swift
//  Weather
//
//  Created by AnhLD on 9/1/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {
    
    @IBOutlet weak var headerColectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupColectionView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupColectionView() {
        headerColectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        headerColectionView.delegate = self
        headerColectionView.dataSource = self
        headerColectionView.contentInset.right = 20
        headerColectionView.contentInset.left = 20
    }
    
}

extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth * 150 / 375
        //let height = 70
        return CGSize(width: width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
