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
    @IBOutlet weak var userInformationgendertitle: UILabel!
    @IBOutlet weak var userInformationmanbtn: UIButton!{
        didSet{
            self.userInformationmanbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
            self.userInformationmanbtn.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
        }
    }
    @IBOutlet weak var userInformationgirlbtn: UIButton!{
        didSet{
            self.userInformationgirlbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
            self.userInformationgirlbtn.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
        }
    }
    @IBOutlet weak var userInformationareatitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
    }
    
    public func initLayout(){
        self.userInformatiotitle.textColor = UIColor(red: 65/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformatiotitle.numberOfLines = 1
        self.userInformatiotitle.textAlignment = .left
        self.userInformatiotitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Bold", size: 26)])
        self.userInformationsubtitle.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.userInformationsubtitle.numberOfLines = 2
        self.userInformationsubtitle.textAlignment = .left
        self.userInformationsubtitle.attributedText = NSAttributedString(string: "입력하신 정보로 스터디를 찾을 수 있습니다.\n지역 정보는 다른 사람들에게 공유되지 않습니다.", attributes: [NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Bold", size: 14)])
        self.userInformationgendertitle.numberOfLines = 1
        self.userInformationgendertitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationgendertitle.textAlignment = .left
        self.userInformationgendertitle.attributedText = NSAttributedString(string: "성별", attributes: [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)])
        
        self.userInformationmanbtn.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 14)
        self.userInformationmanbtn.setTitle("남자", for: .normal)
        self.userInformationmanbtn.addTarget(self, action: #selector(manbtnAction(_:)), for: .touchUpInside)
        self.userInformationmanbtn.backgroundColor = UIColor.white
        self.userInformationmanbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
        
        self.userInformationgirlbtn.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 14)
        self.userInformationgirlbtn.setTitle("여자", for: .normal)
        self.userInformationgirlbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
        self.userInformationgirlbtn.addTarget(self, action: #selector(girlbtnAction(_:)), for: .touchUpInside)
        self.userInformationgirlbtn.backgroundColor = UIColor.white
        self.userInformationgirlbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
        self.userInformationareatitle.numberOfLines = 1
        self.userInformationareatitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationareatitle.textAlignment = .left
        self.userInformationareatitle.attributedText = NSAttributedString(string: "나이", attributes: [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)])
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

