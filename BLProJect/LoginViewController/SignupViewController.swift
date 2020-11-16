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
    
    public var ViewModel = SignViewModel()
    public let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.SetSingViewLayout()
        self.SignViewAutoLayout()
        self.SignJoinButton.addTarget(self, action: #selector(CallServiceApi), for: .touchUpInside)
        //        self.SignJoinButton.addTarget(self, action: #selector(ShowSignAlert), for: .touchUpInside)
        self.SignEmailTextField.delegate = self
        self.SignNicknamTextField.delegate = self
        self.SignPasswordTextField.delegate = self
        SignEmailTextField.rx.text
            .map{$0 ?? ""}
            .bind(to: ViewModel.EmailText)
            .disposed(by: disposedBag)
        SignPasswordTextField.rx.text
            .map{$0 ?? ""}
            .bind(to: ViewModel.PasswordText)
            .disposed(by: disposedBag)
        SignNicknamTextField.rx.text
            .map{$0 ?? ""}
            .bind(to: ViewModel.NickNameText)
            .disposed(by: disposedBag)
        
        ViewModel
            .isVaild()
            .bind(to: SignJoinButton.rx.isEnabled)
            .disposed(by: disposedBag)
        ViewModel
            .isVaild()
            .map{$0 ? UIColor.black : UIColor.lightGray}
            .bind(to: SignJoinButton.rx.backgroundColor)
            .disposed(by: disposedBag)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.addKeyboardNotification()
    }
    
    //MARK - 초기 회원가입 Layout 구현
    public func SetSingViewLayout(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let Navigationimage = UIImage(named: "Navigation@1x.png")
        self.navigationController?.navigationBar.backIndicatorImage = Navigationimage
        
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
        self.SignJoinButton.layer.borderColor = UIColor.clear.cgColor
        self.SignJoinButton.layer.cornerRadius = 8
        self.SignJoinButton.frame = CGRect(x: self.SignJoinButton.frame.origin.x, y: self.SignJoinButton.frame.origin.y, width: self.SignJoinButton.frame.size.width, height: self.SignJoinButton.frame.size.height)
        
    }
    
    public func SignViewAutoLayout(){
//        self.SubjectLabel.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize(width: 374, height: 100))
//            make.top.equalTo(self.view).offset(156)
//            make.right.equalTo(self.view).offset(-20)
//            make.left.equalTo(self.view).offset(20)
//            make.bottom.equalTo(self.SignEmailTextField.snp.top).offset(-48)
//
//        }
//        self.SignEmailTextField.snp.makeConstraints { (make) in
//            make.right.equalTo(self.view).offset(-20)
//            make.left.equalTo(self.view).offset(20)
//            make.bottom.equalTo(self.SignNicknamTextField.snp.top).offset(-70)
//            make.top.equalTo(self.SubjectLabel.snp.bottom).offset(48)
//            make.size.equalTo(CGSize(width: 374, height: 30))
//        }
//        self.SignNicknamTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(self.SignEmailTextField.snp
//                                .bottom).offset(70)
//            make.right.equalTo(self.view).offset(-20)
//            make.left.equalTo(self.view).offset(20)
//            make.bottom.equalTo(self.SignPasswordTextField.snp.top).offset(-70)
//            make.size.equalTo(CGSize(width: 374, height: 30))
//        }
//        self.SignPasswordTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(self.SignNicknamTextField.snp.bottom).offset(70)
//            make.right.equalTo(self.view).offset(-20)
//            make.left.equalTo(self.view).offset(20)
//            make.bottom.equalTo(self.SignJoinButton.snp.top).offset(-83)
//            make.size.equalTo(CGSize(width: 374, height: 30))
//        }
//        self.SignJoinButton.snp.makeConstraints { (make) in
//            make.top.equalTo(self.SignPasswordTextField.snp.bottom).offset(83)
//            make.right.equalTo(self.view).offset(-20)
//            make.left.equalTo(self.view).offset(20)
//            make.bottom.equalTo(self.view).offset(-149)
//            make.size.equalTo(CGSize(width: 374, height: 40))
//        }
    }
    
    public func addKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func ShowSignAlert(){
        let SignAlert = SingUpAlertView(frame: self.view.frame)
        self.view.addSubview(SignAlert)
        
        
    }
    
    @objc func CallServiceApi(){
        
        let SingParamter = SignUpParamter(email: "ysk8019@daum.net", password: "kysd1234!", nickname: "Do-HY-K11", service_use_agree: true)
        
        oAuthApi.shared.AuthSignUpCall(SignUpParamter: SingParamter) { [weak self] reuslt in
            switch reuslt {
            case .success(let value):
                print(value.code)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
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


extension UITextField {
    
    func UnderLine(){
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
