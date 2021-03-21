//
//  UserInformationViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/29.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SnapKit


class UserInformationViewController: UIViewController {
    
    @IBOutlet weak var userInformationtitle: UILabel!
    @IBOutlet weak var userInformationsubtitle: UILabel!
    @IBOutlet weak var userInformationgendertitle: UILabel!
    @IBOutlet weak var userInformationmanbtn: UIButton!
    {
        didSet{
            self.userInformationmanbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
            self.userInformationmanbtn.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
        }
    }
    @IBOutlet weak var userInformationgirlbtn: UIButton!
    {
        didSet{
            self.userInformationgirlbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
            self.userInformationgirlbtn.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
        }
    }
    
    @IBOutlet weak var userInformationbirthday: UILabel!
    @IBOutlet weak var userInformationbirthdayButton: UIButton!
    @IBOutlet weak var userInformationareatitle: UILabel!
    @IBOutlet weak var userInformationareaAddbtn: UIButton!
    @IBOutlet weak var userInformationIntresttitle: UILabel!
    @IBOutlet weak var userInformationConfirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
    }

    public func initLayout(){
        self.userInformationtitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationtitle.numberOfLines = 1
        self.userInformationtitle.textAlignment = .left
        self.userInformationtitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 26)])
        self.userInformationsubtitle.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.userInformationsubtitle.numberOfLines = 2
        self.userInformationsubtitle.textAlignment = .left
        self.userInformationsubtitle.attributedText = NSAttributedString(string: "입력하신 정보로 스터디를 찾을 수 있습니다.\n지역 정보는 다른 사람들에게 공유되지 않습니다.", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        self.userInformationgendertitle.numberOfLines = 1
        self.userInformationgendertitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationgendertitle.textAlignment = .left
        self.userInformationgendertitle.attributedText = NSAttributedString(string: "성별", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        
        self.userInformationmanbtn.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationmanbtn.setTitle("남자", for: .normal)
        self.userInformationmanbtn.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.userInformationmanbtn.addTarget(self, action: #selector(manbtnAction(_:)), for: .touchUpInside)
        self.userInformationmanbtn.setAddImageView(image: UIImage(named: "genderunCheckgray.png")!, renderingMode: .alwaysOriginal)
        
        self.userInformationgirlbtn.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationgirlbtn.setTitle("여자", for: .normal)
        self.userInformationgirlbtn.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.userInformationgirlbtn.addTarget(self, action: #selector(girlbtnAction(_:)), for: .touchUpInside)
        self.userInformationgirlbtn.backgroundColor = UIColor.white
        self.userInformationgirlbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
        
        self.userInformationbirthday.text = "출생년도"
        self.userInformationbirthday.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationbirthday.textAlignment = .left
        self.userInformationbirthday.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationbirthdayButton.layer.borderWidth = 1
        self.userInformationbirthdayButton.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.userInformationbirthdayButton.setAttributedTitle(NSAttributedString(attributedString: NSAttributedString(string: "1996", attributes: [NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])), for: .normal)
        self.userInformationbirthdayButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationbirthdayButton.layer.cornerRadius = 4
        self.userInformationbirthdayButton.layer.masksToBounds = true
        self.userInformationbirthdayButton.contentHorizontalAlignment = .left
        self.userInformationbirthdayButton.setImage(UIImage(named: "triangle.png"), for: .normal)
        self.userInformationbirthdayButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationbirthdayButton.tintColor = UIColor(red: 196/266, green: 196/255, blue: 196/255, alpha: 1.0)
        self.userInformationbirthdayButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
        
        
        self.userInformationareatitle.text = "지역"
        self.userInformationareatitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationareatitle.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationareatitle.textAlignment = .left
        
        self.userInformationareaAddbtn.setAttributedTitle(NSAttributedString(string: "추가하기", attributes: [NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        self.userInformationareaAddbtn.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationareaAddbtn.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.userInformationareaAddbtn.layer.cornerRadius = 4
        self.userInformationareaAddbtn.layer.masksToBounds = true
        
        self.userInformationIntresttitle.textAlignment = .left
        self.userInformationIntresttitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationIntresttitle.attributedText = NSAttributedString(string: "관심 스터디", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        
        
        self.userInformationConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInformationConfirmButton.setAttributedTitle(NSAttributedString(string: "가입하기", attributes: [NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.userInformationConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.userInformationConfirmButton.layer.cornerRadius = 4
        self.userInformationConfirmButton.layer.masksToBounds = true
    }
    
    
    
    
    @objc func manbtnAction(_ sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
            self.userInformationgirlbtn.isSelected = false
            
        }else{
            self.userInformationgirlbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
            self.userInformationmanbtn.setAddImageView(image: UIImage(named: "genderunCheck.png")!, renderingMode: .alwaysOriginal)
            sender.isSelected = true
            self.userInformationgirlbtn.isSelected = false
        }
    }
    
    @objc func girlbtnAction(_ sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
            self.userInformationmanbtn.isSelected = false
            
        }else{
            self.userInformationmanbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
            self.userInformationgirlbtn.setAddImageView(image: UIImage(named: "genderunCheck.png")!, renderingMode: .alwaysOriginal)
            sender.isSelected = true
            self.userInformationmanbtn.isSelected = false
        }
    }
    
}


extension UIButton {
    
    public func setAddImageView(image : UIImage, renderingMode : UIImage.RenderingMode){
            self.setImage(image.withRenderingMode(renderingMode), for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: image.size.width / 2.0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            self.contentHorizontalAlignment = .left
            self.imageView?.contentMode = .scaleAspectFit
    }
}

