//
//  UserInformationViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/29.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit



class UserInformationViewController: UIViewController {
    @IBOutlet weak var userInformatiotitle: UILabel!
    @IBOutlet weak var userInformationsubtitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func InitLayout(){
        self.userInformatiotitle.textColor = UIColor(red: 65/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformatiotitle.numberOfLines = 1
        self.userInformatiotitle.textAlignment = .center
        self.userInformatiotitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font : UIFont.systemFontSize])
    }
}
