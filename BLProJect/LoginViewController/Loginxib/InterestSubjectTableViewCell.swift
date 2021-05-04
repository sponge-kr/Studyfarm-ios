//
//  InterestSubjectTableViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/04/14.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class InterestSubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var InterestSubjectLabel: UILabel!
    @IBOutlet weak var InterestSubjectImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.contentView.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 153/255, alpha: 1.0)
            self.InterestSubjectImageView.isHidden = false
            self.InterestSubjectLabel.textColor = UIColor.white
        } else {
            self.contentView.backgroundColor = .white
            self.InterestSubjectImageView.isHidden = true
            self.InterestSubjectLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        }
        // Configure the view for the selected state
    }
    
    private func setInitLayout() {
        self.InterestSubjectLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.InterestSubjectLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.InterestSubjectImageView.image = UIImage(named: "checkWhite.png")
        self.InterestSubjectImageView.isHidden = true
    }
}
