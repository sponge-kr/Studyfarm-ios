//
//  BLMainCollectionViewHeader.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/10.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit

class BLMainCollectionViewHeader: UICollectionReusableView {
    @IBOutlet weak var reusableState: UIButton!
    @IBOutlet weak var reusableTitle: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initLayout()
    }
    
    //MARK - Button Attribute
    private func initLayout(){
        
        self.reusableState.frame = CGRect(x: self.reusableState.frame.origin.x, y: self.reusableState.frame.origin.y, width: self.reusableState.frame.size.width, height: self.reusableState.frame.size.height)
        self.reusableTitle.frame = CGRect(x: self.reusableTitle.frame.origin.x, y: self.reusableTitle.frame.origin.y, width: self.reusableTitle.frame.size.width, height: self.reusableTitle.frame.size.height)
        
    }
    
    
}
