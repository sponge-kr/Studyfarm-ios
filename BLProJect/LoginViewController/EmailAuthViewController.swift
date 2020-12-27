//
//  EmailAuthViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/27.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit



class EmailAuthViewController: UIViewController {
    
    @IBOutlet weak var SendEmailLabel: UILabel!
    @IBOutlet weak var SendEmailConfirmlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Layoutinit()
    }
    //a1a1a1
    private func Layoutinit(){
        self.SendEmailLabel.text = "인증메일 발송 완료"
        self.SendEmailLabel.tintColor = UIColor(red: 65/255, green: 61/266, blue: 61/255, alpha: 1.0)
        self.SendEmailLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0))
        print()
        self.SendEmailConfirmlabel.text = "\(String(describing: UserDefaults.standard.value(forKey: "service_use_email") as! String ))으로\n 인증메일을 발송했습니다."
        self.SendEmailConfirmlabel.textAlignment = .left
        self.SendEmailConfirmlabel.numberOfLines = 2
        self.SendEmailConfirmlabel.tintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.SendEmailConfirmlabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0))
        
    }
    
}
