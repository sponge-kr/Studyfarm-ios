//
//  StudyDetailRepliesTableViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/24.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class StudyDetailRepliesTableViewCell: UITableViewCell {
    @IBOutlet weak var StudyRepliesUserProfile: UIImageView!
    @IBOutlet weak var StudyRepliesUserNickname: UILabel!
    @IBOutlet weak var StudyRepliesUserDate: UILabel!
    @IBOutlet weak var StudyRepliesUserContent: UILabel!
    @IBOutlet weak var StudyRepliesUserReplyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ReplyCellLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


    private func ReplyCellLayout(){
        self.StudyRepliesUserNickname.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyRepliesUserNickname.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyRepliesUserDate.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyRepliesUserContent.numberOfLines = 0
        self.StudyRepliesUserContent.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyRepliesUserContent.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyRepliesUserReplyBtn.setTitle("답글쓰기", for: .normal)
        self.StudyRepliesUserReplyBtn.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.StudyRepliesUserReplyBtn.backgroundColor = UIColor.clear
        self.StudyRepliesUserReplyBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        
    }
}