//
//  StudyMapTableViewCell.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/11.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class StudyMapTableViewCell: UITableViewCell {

    @IBOutlet weak var StudyMaptitlelabel: UILabel!
    @IBOutlet weak var StudyMapContentlabel: UILabel!
    @IBOutlet weak var StudyMapranklabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setMapCellLayoutInit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setMapCellLayoutInit(){
        self.StudyMaptitlelabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.7])
        self.StudyMaptitlelabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        self.StudyMaptitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyMapContentlabel.lineBreakMode = .byWordWrapping
        self.StudyMapContentlabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyMapContentlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.StudyMapContentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyMapranklabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.6])
        self.StudyMapranklabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        
    
    }
    
}
