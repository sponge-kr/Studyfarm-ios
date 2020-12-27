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
    @IBOutlet weak var SendEmailConfirmView: UIView!
    @IBOutlet weak var SendEmailIconImage: UIImageView!
    @IBOutlet weak var SendEmailExampleLabel: UILabel!
    @IBOutlet weak var SendEmailConfirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Layoutinit()
    }
    //a1a1a1
    private func Layoutinit(){
        self.SendEmailLabel.text = "인증메일 발송 완료"
        self.SendEmailLabel.tintColor = UIColor(red: 65/255, green: 61/266, blue: 61/255, alpha: 1.0)
        self.SendEmailLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0))
//        self.SendEmailConfirmlabel.text = "\(String(describing: UserDefaults.standard.value(forKey: "service_use_email") as! String ))으로\n 인증메일을 발송했습니다."
        self.SendEmailConfirmlabel.textAlignment = .left
        self.SendEmailConfirmlabel.numberOfLines = 2
        self.SendEmailConfirmlabel.tintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.SendEmailConfirmlabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0))
        self.SendEmailConfirmView.clipsToBounds = false
        self.SendEmailConfirmView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.09).cgColor
        self.SendEmailConfirmView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.SendEmailConfirmView.layer.shadowRadius = 16
        self.SendEmailConfirmView.layer.shadowOpacity = 1
        
        self.SendEmailIconImage.image = UIImage(named: "Email@1x.png")
        self.SendEmailIconImage.contentMode = .scaleAspectFill
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.46
        self.SendEmailExampleLabel.tintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        self.SendEmailExampleLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        self.SendEmailExampleLabel.textAlignment = .left
        self.SendEmailExampleLabel.attributedText = NSAttributedString(string: "메일함에서 인증 확인 버튼을 눌러주세요.", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
        
        
        self.SendEmailConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.SendEmailConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        
        let ConfirmButtonparagraphStyle = NSMutableParagraphStyle()
        ConfirmButtonparagraphStyle.lineHeightMultiple = 1.28
        
        
        self.SendEmailConfirmButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        self.SendEmailConfirmButton.setAttributedTitle(NSAttributedString(string: "가입하기", attributes: [NSAttributedString.Key.paragraphStyle : ConfirmButtonparagraphStyle]), for: .normal)
        self.SendEmailConfirmButton.layer.cornerRadius = 8.0
        
        
        
    }
    
}
