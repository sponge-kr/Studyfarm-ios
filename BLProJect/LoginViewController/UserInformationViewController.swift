//
//  UserInformationViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/29.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SnapKit



class UserInformationViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var userInformationtitle: UILabel!
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
    @IBOutlet weak var userInformationagetitle: UILabel!
    @IBOutlet weak var userInformationagepickerview: UIPickerView!
    @IBOutlet weak var userInformationareatitle: UILabel!
    private let pickertitle = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.userInformationagepickerview.delegate = self
        self.userInformationagepickerview.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        self.userInformationagepickerview.subviews[1].backgroundColor = UIColor.clear
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.userInformationagepickerview.reloadAllComponents()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let BackgroundView = UIView()
        BackgroundView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        BackgroundView.layer.cornerRadius = BackgroundView.frame.size.width / 2.0
        BackgroundView.layer.borderColor = UIColor.clear.cgColor
        BackgroundView.layer.masksToBounds = true
            let BackgroundLabel = UILabel()
        BackgroundLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        BackgroundLabel.textAlignment = .center
        BackgroundLabel.font = UIFont.systemFont(ofSize: 30)
        BackgroundLabel.text = self.pickertitle[row]
        BackgroundView.addSubview(BackgroundLabel)

        BackgroundView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
            if pickerView.selectedRow(inComponent: component) == row {
                BackgroundLabel.attributedText =  NSAttributedString(string: self.pickertitle[row], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor:UIColor.white])
                BackgroundView.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            }
            return BackgroundView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickertitle.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickertitle[row]
    }
    
    
    public func initLayout(){
        self.userInformationtitle.textColor = UIColor(red: 65/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationtitle.numberOfLines = 1
        self.userInformationtitle.textAlignment = .left
        self.userInformationtitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Bold", size: 26)])
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
        self.userInformationagetitle.numberOfLines = 1
        self.userInformationagetitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationagetitle.textAlignment = .left
        self.userInformationagetitle.attributedText = NSAttributedString(string: "나이", attributes: [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)])
        var rotatoeAngle : CGFloat = -90 * (.pi/180)
        var pickerViewY = self.userInformationagepickerview.frame.origin.y
        self.userInformationagepickerview.transform = CGAffineTransform(rotationAngle: rotatoeAngle)
        self.userInformationagepickerview.tintColor = UIColor.clear
        self.userInformationagepickerview.frame = CGRect(x: -150, y: pickerViewY, width: self.view.frame.size.width + 300, height: 70)
        self.userInformationagepickerview.layer.borderWidth = 1
        self.userInformationagepickerview.layer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0).cgColor
        
        self.userInformationareatitle.numberOfLines = 1
        self.userInformationareatitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationareatitle.attributedText = NSAttributedString(string: "지역", attributes: [NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Bold", size: 14)])
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
        topLayer.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
        topLayer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0).cgColor
        topLayer.borderWidth = 1
        self.layer.addSublayer(topLayer)
    }
}
