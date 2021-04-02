//
//  AreaEmptyCollectionViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/29.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class AreaEmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var areaEmptyTitleLabel: UILabel!
    @IBOutlet weak var areaEmptyConfirmButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        self.areaEmptyTitleLabel.attributedText = NSAttributedString(string: "Sorry!\n현재 베타 서비스로 운영되고 있어\n서울 / 경기만 신청 가능합니다. ㅜ_ㅜ", attributes: [NSAttributedString.Key.kern: -0.77])
        self.areaEmptyTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.areaEmptyTitleLabel.numberOfLines = 0
        self.areaEmptyTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.areaEmptyConfirmButton.setAttributedTitle(NSAttributedString(string: "우리 지역 신청하기 !", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16),NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,NSAttributedString.Key.kern: -0.88]), for: .normal)
        self.areaEmptyConfirmButton.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .normal)
        
    }

}
