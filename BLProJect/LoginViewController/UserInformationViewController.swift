//
//  UserInformationViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/29.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SnapKit


class UserInformationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    @IBOutlet weak var userInformationagetitle: UILabel!
    @IBOutlet weak var userInformationagepickerview: UIPickerView!
    @IBOutlet weak var userInformationareatitle: UILabel!
    @IBOutlet weak var userInformationareaAddbtn: UIButton!
    @IBOutlet weak var userInformationIntresttitle: UILabel!
    private var pickerViewRow : Int = 0
    private let pickertitle = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInformationagepickerview.delegate = self
        self.userInformationagepickerview.dataSource = self
        self.initLayout()
    }
    override func viewDidLayoutSubviews() {
        self.userInformationagepickerview.subviews[1].backgroundColor = UIColor.clear
    }
    
    
    
    
    
    public func initLayout(){
        self.userInformationtitle.textColor = UIColor(red: 65/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationtitle.numberOfLines = 1
        self.userInformationtitle.textAlignment = .left
        self.userInformationtitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 26)])
        self.userInformationsubtitle.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.userInformationsubtitle.numberOfLines = 2
        self.userInformationsubtitle.textAlignment = .left
        self.userInformationsubtitle.attributedText = NSAttributedString(string: "입력하신 정보로 스터디를 찾을 수 있습니다.\n지역 정보는 다른 사람들에게 공유되지 않습니다.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)])
        self.userInformationgendertitle.numberOfLines = 1
        self.userInformationgendertitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationgendertitle.textAlignment = .left
        self.userInformationgendertitle.attributedText = NSAttributedString(string: "성별", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)])
        
        self.userInformationmanbtn.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        self.userInformationmanbtn.setTitle("남자", for: .normal)
        self.userInformationmanbtn.addTarget(self, action: #selector(manbtnAction(_:)), for: .touchUpInside)
        self.userInformationmanbtn.backgroundColor = UIColor.white
        self.userInformationmanbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
        
        self.userInformationgirlbtn.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        self.userInformationgirlbtn.setTitle("여자", for: .normal)
        self.userInformationgirlbtn.setTitleColor(UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0), for: .normal)
        self.userInformationgirlbtn.addTarget(self, action: #selector(girlbtnAction(_:)), for: .touchUpInside)
        self.userInformationgirlbtn.backgroundColor = UIColor.white
        self.userInformationgirlbtn.setAddImageView(image: UIImage(named: "genderunCheckgray@1x.png")!, renderingMode: .alwaysOriginal)
        self.userInformationagetitle.numberOfLines = 1
        self.userInformationagetitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationagetitle.textAlignment = .left
        self.userInformationagetitle.attributedText = NSAttributedString(string: "나이", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!])
        var rotatoeAngle : CGFloat = -90 * (.pi/180)
        var pickerViewY = self.userInformationagepickerview.frame.origin.y
        self.userInformationagepickerview.transform = CGAffineTransform(rotationAngle: rotatoeAngle)
        self.userInformationagepickerview.tintColor = UIColor.clear
        self.userInformationagepickerview.frame = CGRect(x: -150, y: pickerViewY, width: self.view.frame.size.width + 300, height: 70)
        self.userInformationagepickerview.layer.borderWidth = 1
        self.userInformationagepickerview.layer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0).cgColor
        
        self.userInformationareatitle.numberOfLines = 1
        self.userInformationareatitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationareatitle.attributedText = NSAttributedString(string: "지역", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!])
        self.defaultPickerValue(item: "25", Component: 0)
        self.userInformationareaAddbtn.setTitleColor(UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0), for: .normal)
        self.userInformationareaAddbtn.setAttributedTitle(NSAttributedString(string: "추가하기+", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)]), for: .normal)
        self.userInformationareaAddbtn.frame = CGRect(x: self.userInformationareaAddbtn.frame.origin.x, y: self.userInformationareaAddbtn.frame.origin.y, width: self.userInformationareaAddbtn.frame.size.width, height: self.userInformationareaAddbtn.frame.size.height)
        
        self.userInformationIntresttitle.textAlignment = .left
        self.userInformationIntresttitle.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.userInformationIntresttitle.numberOfLines = 1
        self.userInformationIntresttitle.attributedText = NSAttributedString(string: "관심 스터디", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16)])
        
    }
    
    public func defaultPickerValue(item : String, Component : Int){
        if let index = pickertitle.firstIndex(of: item) {
            self.userInformationagepickerview.selectRow(index, inComponent: Component, animated: true)
            self.pickerViewRow = Int(index)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerViewRow = row
        pickerView.reloadAllComponents()
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
        BackgroundLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 24)
        BackgroundLabel.text = self.pickertitle[row]
        BackgroundView.addSubview(BackgroundLabel)
        BackgroundView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        if self.pickerViewRow == row {
                BackgroundLabel.attributedText =  NSAttributedString(string: self.pickertitle[row], attributes: [NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Medium", size: 24),NSAttributedString.Key.foregroundColor:UIColor.white])
                BackgroundView.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1)
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
