//
//  LoginViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import GoogleSignIn
import SnapKit
import SwiftKeychainWrapper
import RxCocoa
import RxSwift




class LoginViewController: UIViewController {
    @IBOutlet weak var loginConfirmbutton: UIButton!
    @IBOutlet weak var loginSubtitlelabel: UILabel!
    @IBOutlet weak var loginSubheadlabel: UILabel!
    @IBOutlet weak var loginGrayline: UIView!
    @IBOutlet weak var loginAutotitlelabel: UILabel!
    @IBOutlet weak var loginAutoswitch: UISwitch!
    @IBOutlet weak var loginGraylines: UIView!
    @IBOutlet weak var loginDescriptionlabel: UILabel!
    @IBOutlet weak var loginEmailtextfiled: UITextField!
    @IBOutlet weak var loginPasswordtextfiled: UITextField!
    @IBOutlet weak var kakaoLoginbutton: UIButton!
    @IBOutlet weak var naverLoginbutton: UIButton!
    @IBOutlet weak var googleLoginbutton: UIButton!
    @IBOutlet weak var signUpbutton: UIButton!
    
    public var ErrorAlert : LoginAlertView!
    var ViewModel : LoginViewModel = LoginViewModel()
    let disposeBag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetLoginLayout()
        self.setAutoLayout()
        self.loginConfirmbutton.addTarget(self, action: #selector(ReceiveLoginAPI), for: .touchUpInside)
        self.kakaoLoginbutton.addTarget(self, action: #selector(KakaoLogin), for: .touchUpInside)
        self.signUpbutton.addTarget(self, action: #selector(SignUpTransform), for: .touchUpInside)
        let TokenKeyChain = KeychainWrapper.standard.string(forKey: "token")
        print("TokenkeyChain 값 입니다",TokenKeyChain)
        if TokenKeyChain != nil {
            let MainViewCall = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
            guard let MainVC = MainViewCall else { return }
            self.navigationController?.pushViewController(MainVC, animated: true)
        }else{
            //ErrorAlert
            
            
        }
        self.TextFiledbind()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.keyboardAddObserver()
    }
    
    
    override func viewDidLayoutSubviews() {
        self.naverLoginbutton.layer.cornerRadius = self.naverLoginbutton.frame.size.width / 2.0
        self.naverLoginbutton.layer.masksToBounds = true
        self.kakaoLoginbutton.layer.cornerRadius = self.kakaoLoginbutton.frame.size.width / 2.0
        self.kakaoLoginbutton.layer.masksToBounds = true
        self.googleLoginbutton.layer.cornerRadius = self.googleLoginbutton.frame.size.width / 2.0
        self.googleLoginbutton.layer.masksToBounds = true
    }
    
    private func TextFiledbind(){
        loginEmailtextfiled.rx.text
            .bind(to: ViewModel.input.EmailText)
            .disposed(by: disposeBag)
        loginPasswordtextfiled.rx.text
            .bind(to: ViewModel.input.PassWordText)
            .disposed(by: disposeBag)
        ViewModel.output.setEmailTextEnabled
            .drive{ (isempty) in
                self.loginEmailtextfiled.rx.base.layer.borderColor = isempty
            }.disposed(by: disposeBag)
        ViewModel.output.setPasswordTextEnabled
            .drive{ (isempty) in
                self.loginPasswordtextfiled.rx.base.layer.borderColor = isempty
            }.disposed(by: disposeBag)
        ViewModel.output.isEmptyEmailText
            .drive{ (ishidden) in
                self.loginEmailtextfiled.rightView?.rx.base.isHidden = ishidden
            }.disposed(by: disposeBag)
    }
    
    private func KakaoAPICall(){
        if KeychainWrapper.standard.string(forKey: "Kakaotoken") != nil{
            oAuthApi.shared.AuthKakaoLoginCall { result in
                switch result{
                case.success(let value):
                    if value.code == 400 {
                        let kakaoParamter = KakaoUserParamter(nickname: "Do-hsaa", service_use_agree: true)
                        oAuthApi.shared.AuthkakaoSignUp(KakaoUserParamter: kakaoParamter) {  result in
                            switch result{
                            case.success(let value):
                                print(value.email)
                                
                            case.failure(let error):
                            print(error.localizedDescription)
                            }
                            
                        }
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
                let MainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                guard let MainVC = MainView else {return}
                self.navigationController?.pushViewController(MainVC, animated: true)
            }
        
    }
}
    
    // MARK - 초기 로그인 Layout 구현
    private func SetLoginLayout(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
    
        self.loginConfirmbutton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.loginConfirmbutton.tintColor = UIColor.white
        self.loginConfirmbutton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.loginConfirmbutton.layer.borderColor = UIColor.clear.cgColor
        self.loginConfirmbutton.layer.cornerRadius = 8
        self.loginConfirmbutton.layer.masksToBounds = true
        
        self.loginSubtitlelabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0))
        self.loginSubtitlelabel.text = "나와 딱 맞는 \n스터디를 찾고 계신가요?"
        self.loginSubtitlelabel.textColor = UIColor.black
        self.loginSubtitlelabel.textAlignment = .left
        self.loginSubtitlelabel.frame = CGRect(x: self.loginSubtitlelabel.frame.origin.x, y: self.loginSubtitlelabel.frame.origin.y, width: self.loginSubtitlelabel.frame.size.width, height: self.loginSubtitlelabel.frame.size.height)
        self.loginSubtitlelabel.numberOfLines = 2
        
        
        self.loginSubheadlabel.text = "스터디팜을 이용하시려면 로그인해 주세요"
        self.loginSubheadlabel.font = UIFont.systemFont(ofSize: 14)
        self.loginSubheadlabel.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        self.loginSubheadlabel.textAlignment = .left
        self.loginSubheadlabel.frame = CGRect(x: self.loginSubheadlabel.frame.origin.x, y: self.loginSubheadlabel.frame.origin.y, width: self.loginSubheadlabel.frame.size.width, height: self.loginSubheadlabel.frame.size.height)
        self.loginSubheadlabel.numberOfLines = 1
        
        self.loginGrayline.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.loginGrayline.frame = CGRect(x: self.loginGrayline.frame.origin.x, y: self.loginGrayline.frame.origin.y, width: self.loginGrayline.frame.size.width, height: self.loginGrayline.frame.size.height)
        self.loginGraylines.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.loginGraylines.frame = CGRect(x: self.loginGraylines.frame.origin.x, y: self.loginGraylines.frame.origin.y, width: self.loginGraylines.frame.size.width, height: self.loginGraylines.frame.size.height)
        
        
        self.loginDescriptionlabel.text = "다음 계정으로 이용"
        self.loginDescriptionlabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.loginDescriptionlabel.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        self.loginDescriptionlabel.textAlignment = .center
        self.loginDescriptionlabel.frame = CGRect(x: self.loginDescriptionlabel.frame.origin.x, y: self.loginDescriptionlabel.frame.origin.y, width: self.loginDescriptionlabel.frame.size.width, height: self.loginDescriptionlabel.frame.size.height)
        
        
        self.loginEmailtextfiled.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        self.loginEmailtextfiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.loginEmailtextfiled.layer.borderWidth = 1.0
        self.loginEmailtextfiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.loginEmailtextfiled.leftViewMode = .always
        
    
        self.loginPasswordtextfiled.attributedPlaceholder = NSAttributedString(string: "비밀번호 (영문, 숫자 조합의 8~16자)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        self.loginPasswordtextfiled.isSecureTextEntry = true
        self.loginPasswordtextfiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.loginPasswordtextfiled.layer.borderWidth = 1.0
        self.loginPasswordtextfiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.loginPasswordtextfiled.leftViewMode = .always
        
        self.loginAutotitlelabel.text = "자동로그인"
        self.loginAutotitlelabel.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        self.loginAutotitlelabel.font = UIFont.systemFont(ofSize: 12)
        self.loginAutotitlelabel.numberOfLines = 1
        self.loginAutotitlelabel.textAlignment = .center
        
        self.loginAutoswitch.onTintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        
        
        self.signUpbutton.setAttributedTitle(NSAttributedString(string: "이메일로 회원가입", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
    
        self.kakaoLoginbutton.frame = CGRect(x: self.kakaoLoginbutton.frame.origin.x, y: self.kakaoLoginbutton.frame.origin
                                            .y, width: self.kakaoLoginbutton.frame.size.width, height: self.kakaoLoginbutton.frame.size.height)
        self.kakaoLoginbutton.backgroundColor = UIColor(red: 255/255, green: 198/255, blue: 83/255, alpha: 1.0)
        self.kakaoLoginbutton.setAttributedTitle(NSAttributedString(string: "카", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.kakaoLoginbutton.layer.cornerRadius = self.kakaoLoginbutton.frame.size.width / 2.0
        self.kakaoLoginbutton.layer.borderColor = UIColor.clear.cgColor
        
        self.naverLoginbutton.frame = CGRect(x: self.naverLoginbutton.frame.origin.x, y: self.naverLoginbutton.frame.origin.y, width: self.naverLoginbutton.frame.size.width, height: self.naverLoginbutton.frame.size.height)
        self.naverLoginbutton.backgroundColor = UIColor(red: 42/255, green: 210/255, blue: 137/255, alpha: 1.0)
        self.naverLoginbutton.setAttributedTitle(NSAttributedString(string: "네", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.naverLoginbutton.layer.cornerRadius = self.naverLoginbutton.frame.size.width / 2.0
        self.naverLoginbutton.layer.borderColor = UIColor.clear.cgColor
        
        self.googleLoginbutton.frame = CGRect(x: self.googleLoginbutton.frame.origin.x, y: self.googleLoginbutton.frame.origin.y, width: self.googleLoginbutton.frame.size.width, height: self.googleLoginbutton.frame.size.height)
        self.googleLoginbutton.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        self.googleLoginbutton.setAttributedTitle(NSAttributedString(string: "구", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.googleLoginbutton.layer.cornerRadius = self.googleLoginbutton.frame.size.width / 2.0
        self.googleLoginbutton.layer.borderColor = UIColor.clear.cgColor
        
        
    }
    
    //MARK - 로그인 AutoLayout 코드1
    private func setAutoLayout(){
        self.loginSubtitlelabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(87)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.loginSubheadlabel.snp.top).offset(-20)
            make.width.equalTo(277)
            make.height.equalTo(72)
        }
        self.loginSubheadlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginSubtitlelabel.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.loginEmailtextfiled.snp.top).offset(-17)
            make.width.equalTo(253)
            make.height.equalTo(24)
        }
        self.loginEmailtextfiled.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.loginPasswordtextfiled.snp.top).offset(-25)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(333)
            make.height.equalTo(45)
        }
        self.loginPasswordtextfiled.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.loginAutoswitch.snp.top).offset(-27)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.equalTo(333)
            make.height.equalTo(45)
        }
        self.loginAutoswitch.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.loginConfirmbutton.snp.top).offset(-28)
            make.right.equalTo(self.loginAutotitlelabel.snp.left).offset(-10)
        }
        self.loginAutotitlelabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginPasswordtextfiled.snp.bottom).offset(32)
            make.bottom.equalTo(self.loginConfirmbutton.snp.top).offset(-30)
            make.left.equalTo(self.loginAutoswitch.snp.right).offset(10)
        }
        self.loginConfirmbutton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.bottom.equalTo(self.signUpbutton.snp.top).offset(-9)
            make.width.equalTo(355)
            make.height.equalTo(49)
        }
        self.signUpbutton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginConfirmbutton.snp.bottom).offset(9)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(24)
            make.bottom.equalTo(self.loginDescriptionlabel.snp.top).offset(-37)
        }
        self.loginDescriptionlabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpbutton.snp.bottom).offset(37)
            make.left.equalTo(self.loginGrayline.snp.right).offset(28)
            make.height.equalTo(24)
        }
        self.loginGrayline.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpbutton.snp.bottom).offset(47)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(22)
            make.right.equalTo(self.loginDescriptionlabel.snp.left).offset(-28)
            make.width.equalTo(94)
            make.height.equalTo(1)
        }
        self.loginGraylines.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginConfirmbutton.snp.bottom).offset(80)
            make.left.equalTo(self.loginDescriptionlabel.snp.right).offset(28)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-18)
            make.width.equalTo(94)
            make.height.equalTo(1)
        }
        self.naverLoginbutton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginGrayline.snp.bottom).offset(53)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(87)
            make.right.equalTo(self.kakaoLoginbutton.snp.left).offset(-25)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
        self.kakaoLoginbutton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginDescriptionlabel.snp.bottom).offset(40)
            make.left.equalTo(self.naverLoginbutton.snp.right).offset(25)
            make.right.equalTo(self.googleLoginbutton.snp.left).offset(-25)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
        self.googleLoginbutton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginDescriptionlabel.snp.bottom).offset(40)
            make.left.equalTo(self.kakaoLoginbutton.snp.right).offset(25)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
        
    }
    
    public func keyboardAddObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification : NSNotification){
        if let keyboardFrame : NSValue =  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let KeyboardFrameRect = keyboardFrame.cgRectValue
            let keyboardFrameHeight = KeyboardFrameRect.height
            self.loginConfirmbutton.frame = CGRect(x: self.loginConfirmbutton.frame.origin.x, y: self.loginConfirmbutton.frame.origin.y - keyboardFrameHeight, width: self.loginConfirmbutton.frame.size.width, height: self.loginConfirmbutton.frame.size.height)
            
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification){
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let KeyboardFrameRect = keyboardFrame.cgRectValue
            let KeyboardFrameHight = KeyboardFrameRect.height
            self.loginConfirmbutton.frame = CGRect(x: self.loginConfirmbutton.frame.origin.x, y: self.loginConfirmbutton.frame.origin.y + KeyboardFrameHight, width: self.loginConfirmbutton.frame.size.width, height: self.loginConfirmbutton.frame.size.height)
        }
    }
    
    
    
    @objc func KakaoLogin(){
        AuthApi.shared.loginWithKakaoAccount(authType: .Reauthenticate) { (oAuthToken, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                _ = oAuthToken
                guard let AccesToken = oAuthToken?.accessToken else { return }
                if AccesToken != "" {
                    KeychainWrapper.standard.set(AccesToken, forKey: "Kakaotoken")
                    self.KakaoAPICall()
                }
            }
        }
    }
    
    @objc func SignUpTransform(){
        let Storyboard = UIStoryboard(name: "SignupViewController", bundle: nil)
        let SignView = Storyboard.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let SignVC = SignView else { return }
        self.navigationController?.pushViewController(SignVC, animated: true)
    }
    
    
    
    
    @objc func ReceiveLoginAPI(){
        let Paramter = LoginParamter(email: self.loginEmailtextfiled.text!, password: self.loginPasswordtextfiled.text!)
        
        oAuthApi.shared.AuthLoginCall(LoginParamter: Paramter) { [weak self] result in
            switch result {
            case .success(let value):
                print("테스트 status code 값입니다 : \(value.message)")
                if value.code == 200 {
                    KeychainWrapper.standard.set(oAuthApi.shared.LoginModel.token, forKey: "token")
                    let MainView = self?.storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController
                    guard let MainVC = MainView else { return }
                    self?.navigationController?.pushViewController(MainVC, animated: true)
                }else{
                    self?.ErrorAlert = LoginAlertView(frame: self!.view.frame)
                    self?.ErrorAlert.LoginTitle.text = value.message
                    self?.view.addSubview(self!.ErrorAlert)
                    self?.ErrorAlert.LoginConfirmBtn.addTarget(self, action: #selector(self?.HideAlertView(_:)), for: .touchUpInside)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    @objc func showAccountView(){
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let SignVC = signUpView else { return }
        self.navigationController?.pushViewController(SignVC, animated: false)
    }
    @IBAction func HideAlertView(_ sender : Any){
        self.ErrorAlert.removeFromSuperview()
    }
}




