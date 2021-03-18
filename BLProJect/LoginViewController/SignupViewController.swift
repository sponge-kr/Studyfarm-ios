//
//  SignupViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit



class SignupViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    @IBOutlet weak var signEmailtextfield: UITextField!
    @IBOutlet weak var signPasswordtextfield: UITextField!
    @IBOutlet weak var signNicknametextfield: UITextField!
    @IBOutlet weak var signConforbutton: UIButton!
    @IBOutlet weak var signSubtitlelabel: UILabel!
    @IBOutlet weak var signSubheadlabel: UILabel!
    @IBOutlet weak var signEmaillabel: UILabel!
    @IBOutlet weak var signEmailSubLabel: UILabel!
    @IBOutlet weak var signPasswordlabel: UILabel!
    @IBOutlet weak var signNicknamelabel: UILabel!
    @IBOutlet weak var signEmailerrorlabel: UILabel!
    @IBOutlet weak var signPassworderrorlabel: UILabel!
    @IBOutlet weak var signNicknameerrorlabel: UILabel!
    @IBOutlet var AgreementView: UIView!
    @IBOutlet weak var AgreementViewLabel: UILabel!
    @IBOutlet weak var AgreementViewFullLabel: UILabel!
    @IBOutlet weak var AgreementViewConfirmBtn: UIButton!
    @IBOutlet weak var AgreementViewLine: UIView!
    @IBOutlet weak var AgreementViewTermsLabel: UILabel!
    @IBOutlet weak var AgreementViewTermsLabel2: UILabel!
    @IBOutlet weak var AgreementViewTermsLabel3: UILabel!
    @IBOutlet weak var signEmailerrorLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var AgreementViewTermsLabel4: UILabel!
    @IBOutlet weak var signScrollView: UIScrollView!
    @IBOutlet weak var AgreementViewTermsBtn: UIButton! {
        didSet {
            let unCheckimage = UIImage(named: "unCheckGray@1x.png")
            self.AgreementViewTermsBtn.setImage(unCheckimage, for: .normal)
        }
    }
    @IBOutlet weak var AgreementViewTermsBtn2: UIButton! {
        didSet {
            let unCheckimage = UIImage(named: "unCheckGray@1x.png")
            self.AgreementViewTermsBtn2.setImage(unCheckimage, for: .normal)
        }
    }
    @IBOutlet weak var AgreementViewTermsBtn3: UIButton! {
        didSet {
            let unCheckimage = UIImage(named: "unCheckGray@1x.png")
            self.AgreementViewTermsBtn3.setImage(unCheckimage, for: .normal)
        }
    }
    @IBOutlet weak var AgreementViewTermsBtn4: UIButton! {
        didSet {
            let unCheckimage = UIImage(named: "unCheckGray@1x.png")
            self.AgreementViewTermsBtn4.setImage(unCheckimage, for: .normal)
        }
    }
    @IBOutlet weak var AgreementViewTermsBtn5: UIButton! {
        didSet {
            let unCheckimage = UIImage(named: "unCheckGray@1x.png")
            self.AgreementViewTermsBtn5.setImage(unCheckimage, for: .normal)
        }
    }
    @IBOutlet weak var AcceptsTermsBtn: UIButton!
    @IBOutlet weak var AcceptsTermsBtn2: UIButton!
    @IBOutlet weak var AcceptsTermsBtn3: UIButton!
    @IBOutlet weak var AcceptsTermsBtn4: UIButton!
    
    
    lazy var signPasswordRightView: UIView = {
        let signRightView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        signRightView.addSubview(self.singPasswordRightButton)
        signRightView.tag = 0
        return signRightView
    }()
    
    lazy var singPasswordRightButton: UIButton = {
        let signRightButton = UIButton(type: .custom)
        signRightButton.frame = CGRect(x: 0, y: 10, width: 24, height: 12)
        signRightButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
        signRightButton.addTarget(self, action: #selector(ispasswordSecurity(sender:)), for: .touchUpInside)
        return signRightButton
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.SetSingViewLayout()
        self.signConforbutton.addTarget(self, action: #selector(CallServiceApi), for: .touchUpInside)
        self.signEmailtextfield.delegate = self
        self.signNicknametextfield.delegate = self
        self.signPasswordtextfield.delegate = self
        self.signScrollView.delegate = self
        self.signScrollView.isScrollEnabled = false
        self.addKeyboardNotification()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.AgreementViewTermsBtn.isSelected = false
        self.AgreementViewTermsBtn2.isSelected = false
        self.AgreementViewTermsBtn3.isSelected = false
        self.AgreementViewTermsBtn4.isSelected = false
        self.AgreementViewTermsBtn5.isSelected = false
        self.AgreementButtonInit()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK - 초기 회원가입 Layout 구현
    public func SetSingViewLayout(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let Navigationimage = UIImage(named: "Navigation.png")
        self.navigationController?.navigationBar.backIndicatorImage = Navigationimage
        
        
        self.signEmailerrorlabel.text = "올바른 형식의 이메일을 입력하세요."
        self.signEmailerrorlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.signEmailerrorlabel.textAlignment = .left
        self.signEmailerrorlabel.numberOfLines = 1
        self.signEmailerrorlabel.textColor = UIColor.clear

        self.signPassworderrorlabel.text = "비밀번호가 너무 짧습니다."
        self.signPassworderrorlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.signPassworderrorlabel.textAlignment = .left
        self.signPassworderrorlabel.numberOfLines = 1
        self.signPassworderrorlabel.textColor = UIColor.clear
        
        self.signNicknameerrorlabel.text = "이미 사용 중 입니다."
        self.signNicknameerrorlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.signNicknameerrorlabel.textAlignment = .left
        self.signNicknameerrorlabel.numberOfLines = 1
        self.signNicknameerrorlabel.textColor = UIColor.clear
       
        self.signSubtitlelabel.text = "이메일로 시작하기"
        self.signSubtitlelabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.signSubtitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signSubtitlelabel.textAlignment = .left
        self.signSubtitlelabel.numberOfLines = 1
        
        self.signSubheadlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signSubheadlabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.signSubheadlabel.attributedText = NSAttributedString(string: "입력하신 메일로 본인인증을 위한 인증번호가 전송됩니다.\n비밀번호는 1번만 입력하니 정확히 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.77])
        self.signSubheadlabel.textAlignment = .left
        self.signSubheadlabel.numberOfLines = 0
        
        self.signEmaillabel.text = "이메일"
        self.signEmaillabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signEmaillabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signEmaillabel.textAlignment = .left
        self.signEmailSubLabel.attributedText = NSAttributedString(string: "메일 인증을 받을 수 있는 주소를 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.66])
        self.signEmailSubLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.signEmailSubLabel.textAlignment = .left
        self.signEmailSubLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        
        self.signPasswordlabel.text = "비밀번호"
        self.signPasswordlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signPasswordlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signPasswordlabel.textAlignment = .left
        
        self.signNicknamelabel.text = "닉네임"
        self.signNicknamelabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signNicknamelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signNicknamelabel.textAlignment = .left
        
        self.signEmailtextfield.attributedPlaceholder = NSAttributedString(string: "이메일 주소 입력", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.signEmailtextfield.layer.borderWidth = 1.0
        self.signEmailtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signEmailtextfield.leftViewMode = .always
        self.signEmailtextfield.textContentType = .emailAddress
        self.signEmailtextfield.layer.cornerRadius = 6
        self.signEmailtextfield.layer.masksToBounds = true
        
        self.signNicknametextfield.attributedPlaceholder = NSAttributedString(string: "10자 이내로 입력해주세요.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.signNicknametextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.signNicknametextfield.layer.borderWidth = 1.0
        self.signNicknametextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signNicknametextfield.layer.cornerRadius = 6
        self.signNicknametextfield.layer.masksToBounds = true
        self.signNicknametextfield.leftViewMode = .always
        self.signNicknametextfield.textContentType = .name
        
        self.signPasswordtextfield.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.signPasswordtextfield.layer.borderWidth = 1.0
        self.signPasswordtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signPasswordtextfield.rightView = self.signPasswordRightView
        self.signPasswordtextfield.rightViewMode = .always
        self.signPasswordtextfield.leftViewMode = .always
        self.signPasswordtextfield.textContentType = .password
        self.signPasswordtextfield.isSecureTextEntry = true
        self.signPasswordtextfield.layer.cornerRadius = 6
        self.signPasswordtextfield.layer.masksToBounds = true
        
        self.signConforbutton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.signConforbutton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        self.signConforbutton.isEnabled = false
        self.signConforbutton.layer.cornerRadius = 8
    }
    
    public func AddAgreementView(){
        let window = UIApplication.shared.keyWindow
        let ScreenSize = UIScreen.main.bounds.size
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onCickTransparentView))
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.AgreementView.frame = CGRect(x: 0, y: ScreenSize.height, width: ScreenSize.width, height: ScreenSize.height / 2)
        window?.addSubview(self.AgreementView)
        self.view.addGestureRecognizer(tapGesture)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.alpha = 0.5
            self.AgreementView.frame = CGRect(x: 0, y: ScreenSize.height - ScreenSize.height / 2, width: ScreenSize.width, height: ScreenSize.height / 2)
        }, completion: nil)
    }
    
    
    public func AgreementViewLayout(){
        self.AgreementViewLabel.text = "약관 동의"
        self.AgreementViewLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 1.0))
        self.AgreementViewLabel.textAlignment = .left
        self.AgreementViewLabel.numberOfLines = 1
        self.AgreementViewLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.AgreementViewLabel.frame = CGRect(x: self.AgreementViewLabel.frame.origin.x, y: self.AgreementViewLabel.frame.origin.y, width: self.AgreementViewLabel.frame.size.width, height: self.AgreementViewLabel.frame.size.height)
        
        self.AgreementView.backgroundColor = UIColor.white
        self.AgreementView.layer.cornerRadius = 8
        self.AgreementViewFullLabel.text = "전체 동의"
        self.AgreementViewFullLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.5))
        self.AgreementViewFullLabel.textAlignment = .left
        self.AgreementViewFullLabel.numberOfLines = 1
        self.AgreementViewFullLabel.textColor = UIColor(red: 50/255, green: 43/255, blue: 43/255, alpha: 1.0)
        self.AgreementViewFullLabel.frame = CGRect(x: self.AgreementViewFullLabel.frame.origin.x, y: self.AgreementViewFullLabel.frame.origin.y, width: self.AgreementViewFullLabel.frame.size.width, height: self.AgreementViewFullLabel.frame.size.height)
        
        self.AgreementViewLine.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        self.AgreementViewLine.frame = CGRect(x: self.AgreementViewLine.frame.origin.x, y: self.AgreementViewLine.frame.origin.y, width: self.AgreementViewLine.frame.size.width, height: self.AgreementViewLine.frame.size.height)
        
        
        self.AgreementViewTermsLabel.text = "스터디팜 이용약관 동의[필수]"
        self.AgreementViewTermsLabel.font = UIFont.systemFont(ofSize: 14)
        self.AgreementViewTermsLabel.textColor = UIColor(red: 87/255, green: 80/255, blue: 80/255, alpha: 1.0)
        self.AgreementViewTermsLabel.numberOfLines = 1
        self.AgreementViewTermsLabel.frame = CGRect(x: self.AgreementViewTermsLabel.frame.origin.x, y: self.AgreementViewTermsLabel.frame.origin.y, width: self.AgreementViewTermsLabel.frame.size.width, height: self.AgreementViewTermsLabel.frame.size.height)
        
        self.AgreementViewTermsLabel2.text = "개인정보 수집이용 동의[필수]"
        self.AgreementViewTermsLabel2.font = UIFont.systemFont(ofSize: 14)
        self.AgreementViewTermsLabel2.textColor = UIColor(red: 87/255, green: 80/255, blue: 80/255, alpha: 1.0)
        self.AgreementViewTermsLabel2.numberOfLines = 1
        self.AgreementViewTermsLabel2.frame = CGRect(x: self.AgreementViewTermsLabel2.frame.origin.x, y: self.AgreementViewTermsLabel2.frame.origin.y, width: self.AgreementViewTermsLabel2.frame.size.width, height: self.AgreementViewTermsLabel2.frame.size.height)
        
        self.AgreementViewTermsLabel3.text = "개인정보 수집이용 동의[선택]"
        self.AgreementViewTermsLabel3.font = UIFont.systemFont(ofSize: 14)
        self.AgreementViewTermsLabel3.textColor = UIColor(red: 87/255, green: 80/255, blue: 80/255, alpha: 1.0)
        self.AgreementViewTermsLabel3.numberOfLines = 1
        self.AgreementViewTermsLabel3.frame = CGRect(x: self.AgreementViewTermsLabel3.frame.origin.x, y: self.AgreementViewTermsLabel3.frame.origin.y, width: self.AgreementViewTermsLabel3.frame.size.width, height: self.AgreementViewTermsLabel3.frame.size.height)
        
        self.AgreementViewTermsLabel4.text = "마케팅 정보 수신 동의[선택]"
        self.AgreementViewTermsLabel4.font = UIFont.systemFont(ofSize: 14)
        self.AgreementViewTermsLabel4.textColor = UIColor(red: 87/255, green: 80/255, blue: 80/255, alpha: 1.0)
        self.AgreementViewTermsLabel4.numberOfLines = 1
        self.AgreementViewTermsLabel4.frame = CGRect(x: self.AgreementViewTermsLabel4.frame.origin.x, y: self.AgreementViewTermsLabel4.frame.origin.y, width: self.AgreementViewTermsLabel4.frame.size.width, height: self.AgreementViewTermsLabel4.frame.size.height)
        
        
        self.AgreementViewConfirmBtn.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.AgreementViewConfirmBtn.setAttributedTitle(NSAttributedString(string: "동의 후 계속하기", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0.5)),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        
        self.AgreementViewConfirmBtn.layer.borderColor = UIColor.clear.cgColor
        self.AgreementViewConfirmBtn.layer.cornerRadius = 8
        self.AgreementViewConfirmBtn.isEnabled = false
        self.AgreementViewConfirmBtn.addTarget(self, action: #selector(ConfirmButtonSelect), for: .touchUpInside)
        self.AgreementViewConfirmBtn.frame = CGRect(x: self.AgreementViewConfirmBtn.frame.origin.x, y: self.AgreementViewConfirmBtn.frame.origin.y, width: self.AgreementViewConfirmBtn.frame.size.width, height: self.AgreementViewConfirmBtn.frame.size.height)
        
        self.AgreementViewTermsBtn.tintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.AgreementViewTermsBtn.addTarget(self, action: #selector(AgreementAllisSelect(sender:)), for: .touchUpInside)
        self.AgreementViewTermsBtn2.tintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.AgreementViewTermsBtn2.addTarget(self, action: #selector(AgreementisSelect(sender:)), for: .touchUpInside)
        self.AgreementViewTermsBtn3.tintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.AgreementViewTermsBtn3.addTarget(self, action: #selector(AgreementisSelect(sender:)), for: .touchUpInside)
        self.AgreementViewTermsBtn4.tintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.AgreementViewTermsBtn4.addTarget(self, action: #selector(AgreementisSelect(sender:)), for: .touchUpInside)
        self.AgreementViewTermsBtn5.tintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.AgreementViewTermsBtn5.addTarget(self, action: #selector(AgreementisSelect(sender:)), for: .touchUpInside)
        
        
        self.AcceptsTermsBtn.setTitleColor(UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), for: .normal)
        self.AcceptsTermsBtn.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
        self.AcceptsTermsBtn2.setTitleColor(UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), for: .normal)
        self.AcceptsTermsBtn2.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue , NSAttributedString.Key.underlineColor : UIColor(red: 146/244, green: 146/244, blue: 146/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
        self.AcceptsTermsBtn3.setTitleColor(UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), for: .normal)
        self.AcceptsTermsBtn3.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
        self.AcceptsTermsBtn4.setTitleColor(UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), for: .normal)
        self.AcceptsTermsBtn4.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
        
    }
    
    //MARK - 약관동의 화면 AutoLayout 코드3
    private func AgreementViewAutoLayout(){
        self.AgreementViewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.bottom.equalTo(self.AgreementViewFullLabel.snp.top).offset(-37)
            make.width.equalTo(245)
            make.height.equalTo(24)
        }
        self.AgreementViewFullLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewLabel.snp.bottom).offset(37)
            make.left.equalTo(self.AgreementViewTermsBtn.snp.right).offset(12)
            make.bottom.equalTo(self.AgreementViewTermsLabel.snp.top).offset(-34)
            make.width.equalTo(63)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewLabel.snp.bottom).offset(37)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.right.equalTo(self.AgreementViewFullLabel.snp.left).offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsBtn2.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewLine.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.right.equalTo(self.AgreementViewTermsLabel.snp.left).offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewLine.snp.bottom).offset(16)
            make.left.equalTo(self.AgreementViewTermsBtn2.snp.right).offset(12)
            make.bottom.equalTo(self.AgreementViewTermsLabel2.snp.top).offset(-17)
            make.width.equalTo(171)
            make.height.equalTo(24)
        }
        self.AcceptsTermsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewLine.snp.bottom).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-33)
            make.bottom.equalTo(self.AcceptsTermsBtn2.snp.top).offset(-16)
            make.width.equalTo(34)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsBtn3.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsBtn2.snp.bottom).offset(17)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.right.equalTo(self.AgreementViewTermsLabel2.snp.left).offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsLabel.snp.bottom).offset(17)
            make.left.equalTo(self.AgreementViewTermsBtn3.snp.right).offset(12)
            make.bottom.equalTo(self.AgreementViewTermsLabel3.snp.top).offset(-17)
            make.width.equalTo(171)
            make.height.equalTo(24)
        }
        self.AcceptsTermsBtn2.snp.makeConstraints { (make) in
            make.top.equalTo(self.AcceptsTermsBtn.snp.bottom).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-33)
            make.bottom.equalTo(self.AcceptsTermsBtn3.snp.top).offset(-16)
            make.width.equalTo(34)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsBtn4.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsBtn3.snp.bottom).offset(17)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.right.equalTo(self.AgreementViewTermsLabel3.snp.left).offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsLabel2.snp.bottom).offset(17)
            make.left.equalTo(self.AgreementViewTermsBtn4.snp.right).offset(12)
            make.bottom.equalTo(self.AgreementViewTermsLabel4.snp.top).offset(-17)
            make.width.equalTo(171)
            make.height.equalTo(24)
        }
        self.AcceptsTermsBtn3.snp.makeConstraints { (make) in
            make.top.equalTo(self.AcceptsTermsBtn2.snp.bottom).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-33)
            make.bottom.equalTo(self.AcceptsTermsBtn4.snp.top).offset(-19)
            make.width.equalTo(34)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsBtn5.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsBtn4.snp.bottom).offset(17)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(31)
            make.right.equalTo(self.AgreementViewTermsLabel4.snp.left).offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        self.AgreementViewTermsLabel4.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsLabel3.snp.bottom).offset(17)
            make.left.equalTo(self.AgreementViewTermsBtn5.snp.right).offset(12)
            make.bottom.equalTo(self.AgreementViewConfirmBtn.snp.top).offset(-44)
            make.width.equalTo(171)
            make.height.equalTo(24)
        }
        self.AcceptsTermsBtn4.snp.makeConstraints { (make) in
            make.top.equalTo(self.AcceptsTermsBtn3.snp.bottom).offset(19)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-33)
            make.bottom.equalTo(self.AgreementViewConfirmBtn.snp.top).offset(-44)
            make.width.equalTo(34)
            make.height.equalTo(24)
        }
        self.AgreementViewConfirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.AgreementViewTermsLabel4.snp.bottom).offset(44)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(48)
        }
    }
    
    
    
    
    public func addKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func necessaryCheckAnimation(){
        if self.AgreementViewTermsBtn2.isSelected == true && self.AgreementViewTermsBtn3.isSelected == true {
            self.AgreementViewConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.AgreementViewConfirmBtn.isEnabled = true
        }else{
            self.AgreementViewConfirmBtn.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
            self.AgreementViewConfirmBtn.isEnabled = false
        }
    }
    
    
    // 추후 AgreementView RadiusButton 리펙토링
    public func AgreementButtonisAllSelect(){
        if self.AgreementViewTermsBtn.isSelected == true{
            self.AgreementViewTermsBtn2.isSelected = true
            self.AgreementViewTermsBtn3.isSelected = true
            self.AgreementViewTermsBtn4.isSelected = true
            self.AgreementViewTermsBtn5.isSelected = true
        }else{
            self.AgreementViewTermsBtn2.isSelected = false
            self.AgreementViewTermsBtn3.isSelected = false
            self.AgreementViewTermsBtn4.isSelected = false
            self.AgreementViewTermsBtn5.isSelected = false
        }
    }
    
    
    private func AgreementLayoutInit(){
        self.AgreementViewTermsBtn.customEnableLayout()
        self.AgreementViewTermsBtn2.customEnableLayout()
        self.AgreementViewTermsBtn3.customEnableLayout()
        self.AgreementViewTermsBtn4.customEnableLayout()
        self.AgreementViewTermsBtn5.customEnableLayout()
    }
    public func AgreementButtonInit(){
        self.AgreementViewTermsBtn.backgroundColor = UIColor.white
        self.AgreementViewTermsBtn2.backgroundColor = UIColor.white
        self.AgreementViewTermsBtn3.backgroundColor = UIColor.white
        self.AgreementViewTermsBtn4.backgroundColor = UIColor.white
        self.AgreementViewTermsBtn5.backgroundColor = UIColor.white
        
        self.AgreementViewTermsBtn.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        self.AgreementViewTermsBtn2.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        self.AgreementViewTermsBtn3.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        self.AgreementViewTermsBtn4.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        self.AgreementViewTermsBtn5.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
    }
    
    public func AgreememtButtonisSelect() {
        if self.AgreementViewTermsBtn2.isSelected == false || self.AgreementViewTermsBtn3.isSelected == false || self.AgreementViewTermsBtn4.isSelected == false || self.AgreementViewTermsBtn5.isSelected == false{
            self.AgreementViewTermsBtn.isSelected = false
        }
        self.necessaryCheckAnimation()
        self.AgreementLayoutInit()
    }
    public func AgreementButtonAllisSelect(){
        self.AgreementButtonisAllSelect()
        self.necessaryCheckAnimation()
        self.AgreementLayoutInit()
    }
    
    @objc
    private func ispasswordSecurity( sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.singPasswordRightButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
            self.signPasswordtextfield.rightView = self.signPasswordRightView
            self.signPasswordtextfield.rightViewMode = .always
            self.signPasswordtextfield.isSecureTextEntry = true
            self.signPasswordtextfield.setNeedsLayout()
        } else {
            sender.isSelected = true
            self.singPasswordRightButton.setImage(UIImage(named: "eye.png"), for: .selected)
            self.signPasswordtextfield.rightView = self.signPasswordRightView
            self.signPasswordtextfield.rightViewMode = .always
            self.signPasswordtextfield.isSecureTextEntry = false
            self.signPasswordtextfield.setNeedsLayout()
        }
    }
    
    @objc func AgreementAllisSelect(sender : UIButton){
        
        sender.checkboxAnimation {
            self.AgreementButtonAllisSelect()
            print(sender.isSelected)
        }
    }
    
    
    @objc func AgreementisSelect(sender : UIButton){
        sender.checkboxAnimation {
            self.AgreememtButtonisSelect()
            
            print(sender.isSelected)
        }
        
    }
    @objc func ConfirmButtonSelect(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            let ScreenSize = UIScreen.main.bounds.size
            self.AgreementView.frame = CGRect(x: 0, y: ScreenSize.height, width: ScreenSize.width, height: ScreenSize.height)
        } completion: { (succes) in
            if succes == true{
                let Storyboard = UIStoryboard(name: "EmailAuthViewController", bundle: nil)
                let EmailView = Storyboard.instantiateViewController(withIdentifier: "EmailView") as? EmailAuthViewController
                guard let EmailVC = EmailView else { return }
                self.navigationController?.pushViewController(EmailVC, animated: true)
                self.view.alpha = 1
                self.view.backgroundColor = UIColor.systemBackground
            }
        }
    }
    @objc func CallServiceApi(){
        self.AgreementViewLayout()
        self.AddAgreementView()
        self.AgreementViewAutoLayout()
        let SingParamter = SignUpParamter(email: self.signEmailtextfield.text!, password: self.signPasswordtextfield.text!, nickname: self.signNicknametextfield.text!, service_use_agree: true)
        OAuthApi.shared.AuthSignUpCall(SignUpParamter: SingParamter) { result in
            switch  result{
            case .success(let value):
                if value.code == 200 || value.message == "성공하였습니다."{
                    self.signNicknameerrorlabel.textColor = UIColor.clear
                    self.AgreementViewLayout()
                    self.AddAgreementView()
                    self.AgreementViewAutoLayout()
                    UserDefaults.standard.set(value.email, forKey: "service_use_email")
                }else if value.code == 400 && value.message == "이미 존재하는 이메일입니다."{
                    DispatchQueue.main.async {
                        self.signEmailerrorlabel.text = "이미 존재하는 이메일입니다."
                        self.signEmailerrorlabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                    }
                }else if value.code == 400 && value.message == "이미 존재하는 닉네임입니다."{
                    DispatchQueue.main.async {
                        self.signEmailerrorlabel.text = "이미 존재하는 닉네임입니다."
                        self.signNicknameerrorlabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    @objc func onCickTransparentView() {
        let ScreenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view.alpha = 1
            self.view.backgroundColor = UIColor.systemBackground
            self.AgreementView.frame = CGRect(x: 0, y: ScreenSize.height, width: ScreenSize.width, height: ScreenSize.height)
        }, completion: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification : Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.signScrollView.isScrollEnabled = true
            let keyboardShowFrame = keyboardFrame.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.signConforbutton.frame.origin.y - self.signConforbutton.frame.size.height - keyboardShowFrame.height, right: 0.0)
            signScrollView.contentInset = contentInsets
            signScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification : Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.signScrollView.isScrollEnabled = false
            let keyboardHideFrame = keyboardFrame.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.signConforbutton.frame.origin.y + self.signConforbutton.frame.size.height + keyboardHideFrame.height, right: 0.0)
            self.signScrollView.contentOffset.y = 0
            self.signScrollView.contentInset = contentInsets
            self.signScrollView.scrollIndicatorInsets = contentInsets
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.signPasswordtextfield.resignFirstResponder()
        self.signEmailtextfield.resignFirstResponder()
        self.signNicknametextfield.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let EmailVaildation = NSPredicate(format: "SELF MATCHES %@",EmailRegex)
        if EmailVaildation.evaluate(with: self.signEmailtextfield.text) == false {
            UIView.animate(withDuration: 0.2) {
                self.signEmaillabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signEmailerrorlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                self.signEmailerrorLabelTopConstraint.constant = 44
                self.signEmaillabel.setNeedsLayout()
                self.signEmailtextfield.setNeedsLayout()
                self.signPasswordlabel.setNeedsLayout()
                self.signEmailerrorlabel.setNeedsLayout()
            }
            
        } else {
            UIView.animate(withDuration: 0.2) {
                self.signEmaillabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
                self.signEmailerrorlabel.textColor = UIColor.clear
                self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
                self.signEmailerrorLabelTopConstraint.constant = 24
                self.signEmaillabel.setNeedsLayout()
                self.signEmailtextfield.setNeedsLayout()
                self.signPasswordlabel.setNeedsLayout()
                self.signEmailerrorlabel.setNeedsLayout()
            }
        }
        if self.signPasswordtextfield.text!.count < 5 {
            UIView.animate(withDuration: 0.2) {
                self.signPasswordlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signPassworderrorlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                self.signPasswordlabel.setNeedsLayout()
                self.signPasswordtextfield.setNeedsLayout()
                self.signPassworderrorlabel.setNeedsLayout()
            }
        } else {
            self.signPasswordlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.signPassworderrorlabel.textColor = UIColor.clear
            self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
            self.signPasswordlabel.setNeedsLayout()
            self.signPasswordtextfield.setNeedsLayout()
            self.signPassworderrorlabel.setNeedsLayout()
        }
        
        if EmailVaildation.evaluate(with: self.signEmailtextfield.text) == true && self.signPasswordtextfield.text!.count > 5 && self.signNicknametextfield.text!.count < 10 {
            self.signConforbutton.isEnabled = true
            self.signConforbutton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
        
        
        return true
    }
    
    
}

extension UIButton {
    
    func customEnableLayout() {
        if isSelected == true {
            self.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.layer.cornerRadius = 4
            let Checkimage = UIImage(named: "check@1x.png")
            self.layer.borderColor = UIColor.white.cgColor
            self.setImage(Checkimage, for: .normal)
            self.setTitle("", for: .normal)
        }else{
            self.backgroundColor = UIColor.white
            self.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        }
    }
    
    func checkboxAnimation(closure : @escaping () -> Void) {
        guard let image = self.imageView else {return}
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear) {
            self.setTitle("", for: .selected)
        } completion: { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                closure()
            }, completion: nil)
            
        }
    }
}
