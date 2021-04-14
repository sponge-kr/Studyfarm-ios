//
//  InterestTableViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/04/14.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {

    @IBOutlet weak var interesetKindLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInitLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.interesetKindLabel.textColor = .white
            self.contentView.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        } else {
            self.contentView.backgroundColor = .white
            self.interesetKindLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        }
        // Configure the view for the selected state
    }
    
    private func setInitLayout() {
        self.interesetKindLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.interesetKindLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
    }
}
