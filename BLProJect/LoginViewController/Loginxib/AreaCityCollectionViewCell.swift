//
//  AreaCityCollectionViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/25.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class AreaCityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var areaCityTitleButton: UIButton!    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.areaCityTitleButton.isSelected = true
                self.areaCityTitleButton.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
                self.areaCityTitleButton.setImage(UIImage(named: "areaCheck.png"), for: .selected)
                self.areaCityTitleButton.imageToRight()
                
            } else {
                self.areaCityTitleButton.isSelected = false
                self.areaCityTitleButton.setTitleColor(UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCityLayoutInit()
        // Initialization code
    }
    
    private func setCityLayoutInit() {
        self.areaCityTitleButton.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14),NSAttributedString.Key.kern: -0.56]), for: .normal)
        self.areaCityTitleButton.setTitleColor(UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0
        ), for: .normal)
        self.contentView.isUserInteractionEnabled = false
    }
    
    public func setSelected(isSelcted: Bool, indexPath : IndexPath) {
        for i in 0...1 {
            if indexPath.item == UserDefaults.standard.array(forKey: "select_Index")![i] as! Int{
                self.areaCityTitleButton.isSelected = isSelcted
                self.isSelected = isSelcted
            }
        }
    }

}


extension UIButton {
  func imageToRight() {
    self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
  }
}
