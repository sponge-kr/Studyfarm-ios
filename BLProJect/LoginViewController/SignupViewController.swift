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
    @IBOutlet weak var SignEmailTextField: UITextField!
    @IBOutlet weak var SignPasswordTextField: UITextField!
    @IBOutlet weak var SignNicknamTextField: UITextField!
    @IBOutlet weak var SignJoinButton: UIButton!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var ExplanationSubject: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var NicknameLabel: UILabel!
    @IBOutlet weak var EmailErrorAlert: UILabel!
    @IBOutlet weak var PasswordErrorAlert: UILabel!
    @IBOutlet weak var NicknameErrorAlert: UILabel!
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
        self.SignJoinButton.addTarget(self, action: #selector(CallServiceApi), for: .touchUpInside)
        self.SignEmailTextField.delegate = self
        self.SignNicknamTextField.delegate = self
        self.SignPasswordTextField.delegate = self
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
        SignEmailTextField.rx.text
            .bind(to: ViewModel.input.EmailSubject)
            .disposed(by: disposedBag)
        ViewModel.output.setEmailTextEnabled
            .drive{ isVailed in
                self.EmailErrorAlert.rx.base.textColor = isVailed
            }.disposed(by: disposedBag)
        SignPasswordTextField.rx.text
            .bind(to: ViewModel.input.PasswordSubject)
            .disposed(by: disposedBag)
        ViewModel.output.setPasswordTextEnabled
            .drive{ isVailed in
                self.PasswordErrorAlert.rx.base.textColor = isVailed
            }.disposed(by: disposedBag)
    }
    
    //MARK - 초기 회원가입 Layout 구현
    public func SetSingViewLayout(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let Navigationimage = UIImage(named: "Navigation@1x.png")
        self.navigationController?.navigationBar.backIndicatorImage = Navigationimage
        
        
        self.EmailErrorAlert.text = "올바른 형식으로 입력해주세요."
        self.EmailErrorAlert.font = UIFont.systemFont(ofSize: 12)
        self.EmailErrorAlert.textAlignment = .center
        self.EmailErrorAlert.numberOfLines = 1
        self.EmailErrorAlert.textColor = UIColor.clear
        self.EmailErrorAlert.frame = CGRect(x: self.EmailErrorAlert.frame.origin.x, y: self.EmailErrorAlert.frame.origin.y, width: self.EmailErrorAlert.frame.size.width, height: self.EmailLabel.frame.size.height)
        
        self.PasswordErrorAlert.text = "영문, 숫자 포함 6~16자로 조합해주세요."
        self.PasswordErrorAlert.font = UIFont.systemFont(ofSize: 12)
        self.PasswordErrorAlert.textAlignment = .center
        self.PasswordErrorAlert.numberOfLines = 1
        self.PasswordErrorAlert.textColor = UIColor.clear
        self.PasswordErrorAlert.frame = CGRect(x: self.PasswordErrorAlert.frame.origin.x, y: self.PasswordErrorAlert.frame.origin.y, width: self.PasswordErrorAlert.frame.size.width, height: self.PasswordErrorAlert.frame.size.height)
        
        self.NicknameErrorAlert.text = "이미 사용 중 입니다."
        self.NicknameErrorAlert.font = UIFont.systemFont(ofSize: 12)
        self.NicknameErrorAlert.textAlignment = .center
        self.NicknameErrorAlert.numberOfLines = 1
        self.NicknameErrorAlert.textColor = UIColor.clear
        self.NicknameErrorAlert.frame = CGRect(x: self.NicknameErrorAlert.frame.origin.x, y: self.NicknameErrorAlert.frame.origin.y, width: self.NicknameErrorAlert.frame.size.width, height: self.NicknameErrorAlert.frame.size.height)
        
        self.SubjectLabel.text = "이메일로 시작하기"
        self.SubjectLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0))
        self.SubjectLabel.textColor = UIColor.black
        self.SubjectLabel.textAlignment = .center
        self.SubjectLabel.numberOfLines = 1
        self.SubjectLabel.frame = CGRect(x: self.SubjectLabel.frame.origin.x, y: self.SubjectLabel.frame.origin.y, width: self.SubjectLabel.frame.size.width, height: self.SubjectLabel.frame.size.height)
        
        self.ExplanationSubject.text = "입력하신 메일로 본인인증을 위한 인증번호가 전송됩니다.\n비밀번호는 1번만 입력하니 정확히 입력해주세요."
        self.ExplanationSubject.font = UIFont.systemFont(ofSize: 14)
        self.ExplanationSubject.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        self.ExplanationSubject.textAlignment = .left
        self.ExplanationSubject.numberOfLines = 2
        self.ExplanationSubject.frame = CGRect(x: self.ExplanationSubject.frame.origin.x, y: self.ExplanationSubject.frame.origin.y, width: self.ExplanationSubject.frame.size.width, height: self.ExplanationSubject.frame.size.height)
        
        
        self.EmailLabel.text = "이메일"
        self.EmailLabel.font = UIFont.systemFont(ofSize: 14)
        self.EmailLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.EmailLabel.textAlignment = .center
        self.EmailLabel.frame = CGRect(x: self.EmailLabel.frame.origin.x, y: self.EmailLabel.frame.origin.y, width: self.EmailLabel.frame.size.width, height: self.EmailLabel.frame.size.height)
        
        self.PasswordLabel.text = "비밀번호"
        self.PasswordLabel.font = UIFont.systemFont(ofSize: 14)
        self.PasswordLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.PasswordLabel.textAlignment = .center
        self.PasswordLabel.frame = CGRect(x: self.PasswordLabel.frame.origin.x, y: self.PasswordLabel.frame.origin.y, width: self.PasswordLabel.frame.size.width, height: self.PasswordLabel.frame.size.height)
        
        self.NicknameLabel.text = "닉네임"
        self.NicknameLabel.font = UIFont.systemFont(ofSize: 14)
        self.NicknameLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.NicknameLabel.textAlignment = .center
        self.NicknameLabel.frame = CGRect(x: self.NicknameLabel.frame.origin.x, y: self.NicknameLabel.frame.origin.y, width: self.NicknameLabel.frame.size.width, height: self.NicknameLabel.frame.size.height)
        
        self.SignEmailTextField.attributedPlaceholder = NSAttributedString(string: "Welcome@email.com", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.SignEmailTextField.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.SignEmailTextField.layer.borderWidth = 1.0
        self.SignEmailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.SignEmailTextField.leftViewMode = .always
        self.SignEmailTextField.textContentType = .emailAddress
        self.SignEmailTextField.frame = CGRect(x: self.SignEmailTextField.frame.origin.x, y: self.SignEmailTextField.frame.origin.y, width: self.SignEmailTextField.frame.size.width, height: self.SignEmailTextField.frame.size.height)
        
        self.SignNicknamTextField.attributedPlaceholder = NSAttributedString(string: "10자 이내로 입력해주세요.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.SignNicknamTextField.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.SignNicknamTextField.layer.borderWidth = 1.0
        self.SignNicknamTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.SignNicknamTextField.leftViewMode = .always
        self.SignNicknamTextField.textContentType = .name
        self.SignNicknamTextField.frame = CGRect(x: self.SignNicknamTextField.frame.origin.x, y: self.SignNicknamTextField.frame.origin.y, width: self.SignNicknamTextField.frame.size.width, height: self.SignNicknamTextField.frame.size.height)
        
        self.SignPasswordTextField.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.6)])
        self.SignPasswordTextField.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.SignPasswordTextField.layer.borderWidth = 1.0
        self.SignPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.SignPasswordTextField.leftViewMode = .always
        self.SignPasswordTextField.textContentType = .password
        self.SignPasswordTextField.isSecureTextEntry = true
        self.SignPasswordTextField.frame = CGRect(x: self.SignPasswordTextField.frame.origin.x, y: self.SignPasswordTextField.frame.origin.y, width: self.SignPasswordTextField.frame.size.width, height: self.SignPasswordTextField.frame.size.height)
        
        self.SignJoinButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.SignJoinButton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        self.SignJoinButton.isEnabled = true
        self.SignJoinButton.layer.borderColor = UIColor.clear.cgColor
        self.SignJoinButton.layer.cornerRadius = 8
        self.SignJoinButton.frame = CGRect(x: self.SignJoinButton.frame.origin.x, y: self.SignJoinButton.frame.origin.y, width: self.SignJoinButton.frame.size.width, height: self.SignJoinButton.frame.size.height)
        
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
    
    public func SignViewAutoLayout(){
        
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
                let EmailAuthView = self.storyboard?.instantiateViewController(withIdentifier: "EmailAuth")
                guard let EmailVc = EmailAuthView else {return}
                self.navigationController?.pushViewController(EmailVc, animated: true)
                self.view.alpha = 1
                self.view.backgroundColor = UIColor.systemBackground
            }
        }
    }
    
    @objc func CallServiceApi(){
        self.AgreementViewLayout()
        self.AddAgreementView()
        let SingParamter = SignUpParamter(email: self.SignEmailTextField.text!, password: self.SignPasswordTextField.text!, nickname: self.SignNicknamTextField.text!, service_use_agree: true)
        oAuthApi.shared.AuthSignUpCall(SignUpParamter: SingParamter) { result in
            switch  result{
            case .success(let value):
                if value.code == 200 || value.message == "성공하였습니다."{
                    self.NicknameErrorAlert.textColor = UIColor.clear
//                    self.AgreementViewLayout()
//                    self.AddAgreementView()
                    //2020월 12월 27일 월요알
                    UserDefaults.standard.set(value.email, forKey: "service_use_email")
                }else if value.code == 400 && value.message == "이미 존재하는 이메일입니다."{
                    DispatchQueue.main.async {
                        self.EmailErrorAlert.text = "이미 존재하는 이메일입니다."
                        self.EmailErrorAlert.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                    }
                }else if value.code == 400 && value.message == "이미 존재하는 닉네임입니다."{
                    DispatchQueue.main.async {
                        self.EmailErrorAlert.text = "이미 존재하는 닉네임입니다."
                        self.NicknameErrorAlert.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
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
