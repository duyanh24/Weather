//
//  InforDetailTableViewCell.swift
//  Weather
//
//  Created by AnhLD on 9/4/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class InforDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
