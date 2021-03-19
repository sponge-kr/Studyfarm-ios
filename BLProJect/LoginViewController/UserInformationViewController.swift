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

extension UIPickerView {
    public func setTopBorderLayer(){
        let topLayer = CALayer()
        topLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
        topLayer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0).cgColor
        topLayer.borderWidth = 1
        self.layer.addSublayer(topLayer)
    }
}


class DifficultyBtn : UIView {
    
    lazy var beginButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width / 4.5, height: self.frame.size.height))
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setTitle("초급", for: .normal)
        button.setTitleColor(UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.backgroundColor = UIColor.white
        if button.isSelected == true{
            button.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
        return button
    }()
    
    lazy var beginmiddleButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.beginButton.frame.origin.x + self.beginButton.frame.size.width, y: self.beginButton.frame.origin.y, width: self.frame.size.width / 4.5, height: self.frame.size.height))
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setTitle("초중급", for: .normal)
        button.setTitleColor(UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.backgroundColor = UIColor.white
        if button.isSelected == true{
            button.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
        return button
    }()
    
    lazy var middleButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.beginmiddleButton.frame.origin.x + self.beginmiddleButton.frame.size.width, y: self.beginmiddleButton.frame.origin.y, width: self.frame.size.width / 4.5, height: self.frame.size.height))
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setTitle("중급", for: .normal)
        button.setTitleColor(UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.backgroundColor = UIColor.white
        if button.isSelected == true{
            button.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
        return button
    }()
    
    lazy var advancedButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.middleButton.frame.origin.x + self.middleButton.frame.size.width, y: self.middleButton.frame.origin.y, width: self.frame.size.width / 4.5, height: self.frame.size.height))
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setTitle("상급", for: .normal)
        button.setTitleColor(UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        button.backgroundColor = UIColor.white
        if button.isSelected == true{
            button.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
        return button
    }()
    var Button : [UIButton] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInitLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInitLayout()
    }
   
    public func setInitLayout(){
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        self.Button.append(beginButton)
        self.Button.append(beginmiddleButton)
        self.Button.append(middleButton)
        self.Button.append(advancedButton)
        for views in self.Button {
            self.addSubview(views)
        }
    }
    
}
