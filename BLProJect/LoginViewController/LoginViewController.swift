//
//  LoginViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth
import Alamofire
import SnapKit
import SwiftyJSON
import SwiftKeychainWrapper
import RxCocoa
import RxSwift




class LoginViewController: UIViewController {
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var MainSubject: UILabel!
    @IBOutlet weak var ParentsSubject: UILabel!
    @IBOutlet weak var ContourLine: UIView!
    @IBOutlet weak var AuthLoginSubject: UILabel!
    @IBOutlet weak var AuthLoginSwitch: UISwitch!
    @IBOutlet weak var ContourLine2: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var EmailTextFiled: UITextField!
    @IBOutlet weak var PasswordTextFiled: UITextField!
    @IBOutlet weak var KakaoLoginBtn: UIButton!
    @IBOutlet weak var NaverLoginBtn: UIButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var SignUpBtn: UIButton!
    
    public var ErrorAlert : LoginAlertView!
    var ViewModel : LoginViewModel = LoginViewModel()
    let disposeBag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetLoginLayout()
        self.SetAutoLayout()
        self.ConfirmButton.addTarget(self, action: #selector(ReceiveLoginAPI), for: .touchUpInside)
        self.KakaoLoginBtn.addTarget(self, action: #selector(KakaoLogin), for: .touchUpInside)
        self.SignUpBtn.addTarget(self, action: #selector(SignUpTransform), for: .touchUpInside)
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
        self.KeyboardAddObserver()
    }
    
    
    private func TextFiledbind(){
        EmailTextFiled.rx.text
            .bind(to: ViewModel.input.EmailText)
            .disposed(by: disposeBag)
        PasswordTextFiled.rx.text
            .bind(to: ViewModel.input.PassWordText)
            .disposed(by: disposeBag)
        ViewModel.output.setEmailTextEnabled
            .drive{ (isempty) in
                self.EmailTextFiled.rx.base.layer.borderColor = isempty
            }.disposed(by: disposeBag)
        ViewModel.output.setPasswordTextEnabled
            .drive{ (isempty) in
                self.PasswordTextFiled.rx.base.layer.borderColor = isempty
            }.disposed(by: disposeBag)
        ViewModel.output.isEmptyEmailText
            .drive{ (ishidden) in
                self.EmailTextFiled.rightView?.rx.base.isHidden = ishidden
            }.disposed(by: disposeBag)
    }
    
    private func KakaoAPICall(){
        if KeychainWrapper.standard.string(forKey: "Kakaotoken") != nil{
            oAuthApi.shared.AuthKakaoLoginCall { result in
                switch result{
                case.success(let value):
                    if value.code == 401 {
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
    
        self.ConfirmButton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.ConfirmButton.tintColor = UIColor.white
        self.ConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.ConfirmButton.layer.borderColor = UIColor.clear.cgColor
        self.ConfirmButton.layer.cornerRadius = 8
        self.ConfirmButton.layer.masksToBounds = true
        
        self.MainSubject.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0))
        self.MainSubject.text = "나와 딱 맞는 \n스터디를 찾고 계신가요?"
        self.MainSubject.textColor = UIColor.black
        self.MainSubject.textAlignment = .left
        self.MainSubject.frame = CGRect(x: self.MainSubject.frame.origin.x, y: self.MainSubject.frame.origin.y, width: self.MainSubject.frame.size.width, height: self.MainSubject.frame.size.height)
        self.MainSubject.numberOfLines = 2
        
        
        self.ParentsSubject.text = "스터디팜을 이용하시려면 로그인해 주세요"
        self.ParentsSubject.font = UIFont.systemFont(ofSize: 14)
        self.ParentsSubject.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        self.ParentsSubject.textAlignment = .left
        self.ParentsSubject.frame = CGRect(x: self.ParentsSubject.frame.origin.x, y: self.ParentsSubject.frame.origin.y, width: self.ParentsSubject.frame.size.width, height: self.ParentsSubject.frame.size.height)
        self.ParentsSubject.numberOfLines = 1
        
        self.ContourLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.ContourLine.frame = CGRect(x: self.ContourLine.frame.origin.x, y: self.ContourLine.frame.origin.y, width: self.ContourLine.frame.size.width, height: self.ContourLine.frame.size.height)
        self.ContourLine2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.ContourLine2.frame = CGRect(x: self.ContourLine2.frame.origin.x, y: self.ContourLine2.frame.origin.y, width: self.ContourLine2.frame.size.width, height: self.ContourLine2.frame.size.height)
        
        
        self.descriptionLabel.text = "다음 계정으로 이용"
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.descriptionLabel.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.frame = CGRect(x: self.descriptionLabel.frame.origin.x, y: self.descriptionLabel.frame.origin.y, width: self.descriptionLabel.frame.size.width, height: self.descriptionLabel.frame.size.height)
        
        
        self.EmailTextFiled.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        self.EmailTextFiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.EmailTextFiled.layer.borderWidth = 1.0
        self.EmailTextFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.EmailTextFiled.leftViewMode = .always
        
    
        self.PasswordTextFiled.attributedPlaceholder = NSAttributedString(string: "비밀번호 (영문, 숫자 조합의 8~16자)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        self.PasswordTextFiled.isSecureTextEntry = true
        self.PasswordTextFiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.PasswordTextFiled.layer.borderWidth = 1.0
        self.PasswordTextFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.PasswordTextFiled.leftViewMode = .always
        
        self.AuthLoginSubject.text = "자동로그인"
        self.AuthLoginSubject.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        self.AuthLoginSubject.font = UIFont.systemFont(ofSize: 12)
        self.AuthLoginSubject.numberOfLines = 1
        self.AuthLoginSubject.textAlignment = .center
        
        self.AuthLoginSwitch.onTintColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        
        self.SignUpBtn.setAttributedTitle(NSAttributedString(string: "이메일로 회원가입", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0),NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]), for: .normal)
    
        self.KakaoLoginBtn.frame = CGRect(x: self.KakaoLoginBtn.frame.origin.x, y: self.KakaoLoginBtn.frame.origin
                                            .y, width: self.KakaoLoginBtn.frame.size.width, height: self.KakaoLoginBtn.frame.size.height)
        self.KakaoLoginBtn.backgroundColor = UIColor(red: 255/255, green: 198/255, blue: 83/255, alpha: 1.0)
        self.KakaoLoginBtn.setAttributedTitle(NSAttributedString(string: "카", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.KakaoLoginBtn.layer.cornerRadius = self.KakaoLoginBtn.frame.size.height / 2
        self.KakaoLoginBtn.layer.borderColor = UIColor.clear.cgColor
        
        self.NaverLoginBtn.frame = CGRect(x: self.NaverLoginBtn.frame.origin.x, y: self.NaverLoginBtn.frame.origin.y, width: self.NaverLoginBtn.frame.size.width, height: self.NaverLoginBtn.frame.size.height)
        self.NaverLoginBtn.backgroundColor = UIColor(red: 42/255, green: 210/255, blue: 137/255, alpha: 1.0)
        self.NaverLoginBtn.setAttributedTitle(NSAttributedString(string: "네", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.NaverLoginBtn.layer.cornerRadius = self.NaverLoginBtn.frame.size.width / 2
        self.NaverLoginBtn.layer.borderColor = UIColor.clear.cgColor
        
        self.GoogleLoginBtn.frame = CGRect(x: self.GoogleLoginBtn.frame.origin.x, y: self.GoogleLoginBtn.frame.origin.y, width: self.GoogleLoginBtn.frame.size.width, height: self.GoogleLoginBtn.frame.size.height)
        self.GoogleLoginBtn.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        self.GoogleLoginBtn.setAttributedTitle(NSAttributedString(string: "구", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.GoogleLoginBtn.layer.cornerRadius = self.GoogleLoginBtn.frame.size.height / 2
        self.GoogleLoginBtn.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    private func SetAutoLayout(){
        
        
    }
    
    public func KeyboardAddObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification : NSNotification){
        if let keyboardFrame : NSValue =  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let KeyboardFrameRect = keyboardFrame.cgRectValue
            let keyboardFrameHeight = KeyboardFrameRect.height
            self.ConfirmButton.frame = CGRect(x: self.ConfirmButton.frame.origin.x, y: self.ConfirmButton.frame.origin.y - keyboardFrameHeight, width: self.ConfirmButton.frame.size.width, height: self.ConfirmButton.frame.size.height)
            
        }
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification){
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let KeyboardFrameRect = keyboardFrame.cgRectValue
            let KeyboardFrameHight = KeyboardFrameRect.height
            self.ConfirmButton.frame = CGRect(x: self.ConfirmButton.frame.origin.x, y: self.ConfirmButton.frame.origin.y + KeyboardFrameHight, width: self.ConfirmButton.frame.size.width, height: self.ConfirmButton.frame.size.height)
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
        let SignView = self.storyboard?.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let SignVC = SignView else { return }
        self.navigationController?.pushViewController(SignVC, animated: true)
    }
    
    
    
    
    @objc func ReceiveLoginAPI(){
        let Paramter = LoginParamter(email: self.EmailTextFiled.text!, password: self.PasswordTextFiled.text!)
        
        oAuthApi.shared.AuthLoginCall(LoginParamter: Paramter) { [weak self] result in
            switch result {
            case .success(let value):
                print("테스트 status code 값입니다 : \(value.message)")
                if value.code == 200 {
                    KeychainWrapper.standard.set(oAuthApi.shared.LoginModel.token!, forKey: "token")
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




