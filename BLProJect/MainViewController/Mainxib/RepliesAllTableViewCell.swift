//
//  RepliesAllTableViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/28.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class RepliesAllTableViewCell: UITableViewCell {

    @IBOutlet weak var RepliesAllUserImageView: UIImageView!
    @IBOutlet weak var RepliesAllUserNickname: UILabel!
    @IBOutlet weak var RepliesAllUserDate: UILabel!
    @IBOutlet weak var RepliesAllUserContent: UILabel!
    @IBOutlet weak var RepliesAllUserCommentBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setCellLayoutInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setCellLayoutInit() {
        var paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        self.RepliesAllUserNickname.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.66])
        self.RepliesAllUserNickname.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.RepliesAllUserDate.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.66])
        self.RepliesAllUserDate.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.RepliesAllUserContent.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.RepliesAllUserContent.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.RepliesAllUserContent.numberOfLines = 0
        self.RepliesAllUserContent.lineBreakMode = .byWordWrapping
        self.RepliesAllUserCommentBtn.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.RepliesAllUserCommentBtn.setAttributedTitle(NSAttributedString(string: "답글쓰기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        
    }
    
}
