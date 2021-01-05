//
//  SignupViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SnapKit
import SwiftyJSON



class SignupViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var signEmailtextfield: UITextField!
    @IBOutlet weak var signPasswordtextfield: UITextField!
    @IBOutlet weak var signNicknametextfield: UITextField!
    @IBOutlet weak var signConforbutton: UIButton!
    @IBOutlet weak var signSubtitlelabel: UILabel!
    @IBOutlet weak var signSubheadlabel: UILabel!
    @IBOutlet weak var signEmaillabel: UILabel!
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
    @IBOutlet weak var AgreementViewTermsLabel4: UILabel!
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
    
    public var ViewModel = SignupViewModel()
    public let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.SetSingViewLayout()
        self.SignViewAutoLayout()
        self.signConforbutton.addTarget(self, action: #selector(CallServiceApi), for: .touchUpInside)
        self.signEmailtextfield.delegate = self
        self.signNicknametextfield.delegate = self
        self.signPasswordtextfield.delegate = self
        self.ViewBind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.addKeyboardNotification()
        self.AgreementViewTermsBtn.isSelected = false
        self.AgreementViewTermsBtn2.isSelected = false
        self.AgreementViewTermsBtn3.isSelected = false
        self.AgreementViewTermsBtn4.isSelected = false
        self.AgreementViewTermsBtn5.isSelected = false
        self.AgreementButtonInit()

    }
    
    public func ViewBind(){
        signEmailtextfield.rx.text
            .bind(to: ViewModel.input.EmailSubject)
            .disposed(by: disposedBag)
        ViewModel.output.setEmailTextEnabled
            .drive{ isVailed in
                self.signEmailerrorlabel.rx.base.textColor = isVailed
            }.disposed(by: disposedBag)
        signPasswordtextfield.rx.text
            .bind(to: ViewModel.input.PasswordSubject)
            .disposed(by: disposedBag)
        ViewModel.output.setPasswordTextEnabled
            .drive{ isVailed in
                self.signPassworderrorlabel.rx.base.textColor = isVailed
            }.disposed(by: disposedBag)
    }
    
    //MARK - 초기 회원가입 Layout 구현
    public func SetSingViewLayout(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let Navigationimage = UIImage(named: "Navigation@1x.png")
        self.navigationController?.navigationBar.backIndicatorImage = Navigationimage
        
        
        self.signEmailerrorlabel.text = "올바른 형식으로 입력해주세요."
        self.signEmailerrorlabel.font = UIFont.systemFont(ofSize: 12)
        self.signEmailerrorlabel.textAlignment = .center
        self.signEmailerrorlabel.numberOfLines = 1
        self.signEmailerrorlabel.textColor = UIColor.clear
        self.signEmailerrorlabel.frame = CGRect(x: self.signEmailerrorlabel.frame.origin.x, y: self.signEmailerrorlabel.frame.origin.y, width: self.signEmailerrorlabel.frame.size.width, height: self.signEmaillabel.frame.size.height)
        
        self.signPassworderrorlabel.text = "영문, 숫자 포함 6~16자로 조합해주세요."
        self.signPassworderrorlabel.font = UIFont.systemFont(ofSize: 12)
        self.signPassworderrorlabel.textAlignment = .center
        self.signPassworderrorlabel.numberOfLines = 1
        self.signPassworderrorlabel.textColor = UIColor.clear
        self.signPassworderrorlabel.frame = CGRect(x: self.signPassworderrorlabel.frame.origin.x, y: self.signPassworderrorlabel.frame.origin.y, width: self.signPassworderrorlabel.frame.size.width, height: self.signPassworderrorlabel.frame.size.height)
        
        self.signNicknameerrorlabel.text = "이미 사용 중 입니다."
        self.signNicknameerrorlabel.font = UIFont.systemFont(ofSize: 12)
        self.signNicknameerrorlabel.textAlignment = .center
        self.signNicknameerrorlabel.numberOfLines = 1
        self.signNicknameerrorlabel.textColor = UIColor.clear
        self.signNicknameerrorlabel.frame = CGRect(x: self.signNicknameerrorlabel.frame.origin.x, y: self.signNicknameerrorlabel.frame.origin.y, width: self.signNicknameerrorlabel.frame.size.width, height: self.signNicknameerrorlabel.frame.size.height)
        
        self.signSubtitlelabel.text = "이메일로 시작하기"
        self.signSubtitlelabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0))
        self.signSubtitlelabel.textColor = UIColor.black
        self.signSubtitlelabel.textAlignment = .center
        self.signSubtitlelabel.numberOfLines = 1
        self.signSubtitlelabel.frame = CGRect(x: self.signSubtitlelabel.frame.origin.x, y: self.signSubtitlelabel.frame.origin.y, width: self.signSubtitlelabel.frame.size.width, height: self.signSubtitlelabel.frame.size.height)
        
        self.signSubheadlabel.text = "입력하신 메일로 본인인증을 위한 인증번호가 전송됩니다.\n비밀번호는 1번만 입력하니 정확히 입력해주세요."
        self.signSubheadlabel.font = UIFont.systemFont(ofSize: 14)
        self.signSubheadlabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        self.signSubheadlabel.textAlignment = .left
        self.signSubheadlabel.numberOfLines = 2
        self.signSubheadlabel.frame = CGRect(x: self.signSubheadlabel.frame.origin.x, y: self.signSubheadlabel.frame.origin.y, width: self.signSubheadlabel.frame.size.width, height: self.signSubheadlabel.frame.size.height)
        
        
        self.signEmaillabel.text = "이메일"
        self.signEmaillabel.font = UIFont.systemFont(ofSize: 14)
        self.signEmaillabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.signEmaillabel.textAlignment = .center
        self.signEmaillabel.frame = CGRect(x: self.signEmaillabel.frame.origin.x, y: self.signEmaillabel.frame.origin.y, width: self.signEmaillabel.frame.size.width, height: self.signEmaillabel.frame.size.height)
        
        self.signPasswordlabel.text = "비밀번호"
        self.signPasswordlabel.font = UIFont.systemFont(ofSize: 14)
        self.signPasswordlabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.signPasswordlabel.textAlignment = .center
        self.signPasswordlabel.frame = CGRect(x: self.signPasswordlabel.frame.origin.x, y: self.signPasswordlabel.frame.origin.y, width: self.signPasswordlabel.frame.size.width, height: self.signPasswordlabel.frame.size.height)
        
        self.signNicknamelabel.text = "닉네임"
        self.signNicknamelabel.font = UIFont.systemFont(ofSize: 14)
        self.signNicknamelabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.signNicknamelabel.textAlignment = .center
        self.signNicknamelabel.frame = CGRect(x: self.signNicknamelabel.frame.origin.x, y: self.signNicknamelabel.frame.origin.y, width: self.signNicknamelabel.frame.size.width, height: self.signNicknamelabel.frame.size.height)
        
        self.signEmailtextfield.attributedPlaceholder = NSAttributedString(string: "Welcome@email.com", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.signEmailtextfield.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.signEmailtextfield.layer.borderWidth = 1.0
        self.signEmailtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signEmailtextfield.leftViewMode = .always
        self.signEmailtextfield.textContentType = .emailAddress
        self.signEmailtextfield.frame = CGRect(x: self.signEmailtextfield.frame.origin.x, y: self.signEmailtextfield.frame.origin.y, width: self.signEmailtextfield.frame.size.width, height: self.signEmailtextfield.frame.size.height)
        
        self.signNicknametextfield.attributedPlaceholder = NSAttributedString(string: "10자 이내로 입력해주세요.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.signNicknametextfield.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.signNicknametextfield.layer.borderWidth = 1.0
        self.signNicknametextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signNicknametextfield.leftViewMode = .always
        self.signNicknametextfield.textContentType = .name
        self.signNicknametextfield.frame = CGRect(x: self.signNicknametextfield.frame.origin.x, y: self.signNicknametextfield.frame.origin.y, width: self.signNicknametextfield.frame.size.width, height: self.signNicknametextfield.frame.size.height)
        
        self.signPasswordtextfield.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.signPasswordtextfield.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.signPasswordtextfield.layer.borderWidth = 1.0
        self.signPasswordtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signPasswordtextfield.leftViewMode = .always
        self.signPasswordtextfield.textContentType = .password
        self.signPasswordtextfield.isSecureTextEntry = true
        self.signPasswordtextfield.frame = CGRect(x: self.signPasswordtextfield.frame.origin.x, y: self.signPasswordtextfield.frame.origin.y, width: self.signPasswordtextfield.frame.size.width, height: self.signPasswordtextfield.frame.size.height)
        
        self.signConforbutton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.signConforbutton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        self.signConforbutton.isEnabled = true
        self.signConforbutton.layer.borderColor = UIColor.clear.cgColor
        self.signConforbutton.layer.cornerRadius = 8
        self.signConforbutton.frame = CGRect(x: self.signConforbutton.frame.origin.x, y: self.signConforbutton.frame.origin.y, width: self.signConforbutton.frame.size.width, height: self.signConforbutton.frame.size.height)
        
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
    
    //MARK - 회원가입 AutoLayout 코드2
    private func SignViewAutoLayout(){
        self.signSubtitlelabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(112)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.signSubheadlabel.snp.top).offset(-9)
            make.width.equalTo(198)
            make.height.equalTo(35)
        }
        self.signSubheadlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signSubtitlelabel.snp.bottom).offset(9)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.signEmaillabel.snp.top).offset(-34)
            make.height.equalTo(47)
        }
        self.signEmaillabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signSubheadlabel.snp.bottom).offset(34)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.signEmailtextfield.snp.top).offset(-5)
            make.width.equalTo(39)
            make.height.equalTo(24)
        }
        self.signEmailtextfield.snp.makeConstraints { (make) in
            make.top.equalTo(self.signEmaillabel.snp.bottom).offset(5)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(374)
            make.height.equalTo(48)
        }
        self.signEmailerrorlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signEmailtextfield.snp.bottom).offset(4)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(30)
            make.bottom.equalTo(self.signPasswordlabel.snp.top).offset(-7)
            make.width.equalTo(153)
            make.height.equalTo(24)
        }
        self.signPasswordlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signEmailerrorlabel.snp.bottom).offset(7)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.signPasswordtextfield.snp.top).offset(-5)
            make.width.equalTo(52)
            make.height.equalTo(24)
        }
        self.signPasswordtextfield.snp.makeConstraints { (make) in
            make.top.equalTo(self.signPasswordlabel.snp.bottom).offset(5)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(374)
            make.height.equalTo(48)
        }
        self.signPassworderrorlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signPasswordtextfield.snp.bottom).offset(4)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(30)
            make.bottom.equalTo(self.signNicknamelabel.snp.top).offset(-7)
            make.width.equalTo(153)
            make.height.equalTo(24)
        }
        self.signNicknamelabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signPassworderrorlabel.snp.bottom).offset(7)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.signNicknametextfield.snp.top).offset(-5)
            make.width.equalTo(39)
            make.height.equalTo(24)
        }
        self.signNicknametextfield.snp.makeConstraints { (make) in
            make.top.equalTo(self.signNicknamelabel.snp.bottom).offset(5)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(374)
            make.height.equalTo(48)
        }
        self.signNicknameerrorlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signNicknametextfield.snp.bottom).offset(4)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(30)
            make.bottom.equalTo(self.signConforbutton.snp.top).offset(-40)
            make.width.equalTo(153)
            make.height.equalTo(24)
        }
        self.signConforbutton.snp.makeConstraints { (make) in
            make.top.equalTo(self.signNicknametextfield.snp.bottom).offset(40)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.width.equalTo(394)
            make.height.equalTo(49)
        }
        
    }
    
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
        oAuthApi.shared.AuthSignUpCall(SignUpParamter: SingParamter) { result in
            switch  result{
            case .success(let value):
                if value.code == 200 || value.message == "성공하였습니다."{
                    self.signNicknameerrorlabel.textColor = UIColor.clear
//                    self.AgreementViewLayout()
//                    self.AddAgreementView()
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
    
    @objc func keyboardWillShow(_ notification : Notification){
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrameRect = keyboardFrame.cgRectValue
            let KeyboardFrameHieght = keyboardFrameRect.height
            
        }
        
    }
    
    @objc func keyboardWillHide(_ notification : Notification){
        
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
