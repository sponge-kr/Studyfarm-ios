//
//  LoginViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import KakaoSDKUser
import GoogleSignIn
import SnapKit
import SwiftKeychainWrapper
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var loginConfirmButton: UIButton!
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginSubTitleLabel: UILabel!
    @IBOutlet weak var loginFirstGrayLine: UIView!
    @IBOutlet weak var loginAutoTitleLabel: UILabel!
    @IBOutlet weak var loginAutoLoginSwitch: UISwitch!
    @IBOutlet weak var loginSecondGrayLine: UIView!
    @IBOutlet weak var loginDescriptionLabel: UILabel!
    @IBOutlet weak var loginEmailTextFiled: UITextField!
    @IBOutlet weak var loginPasswordTextFiled: UITextField!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var naverLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    public var ErrorAlert : LoginAlertView!
    var ViewModel : LoginViewModel = LoginViewModel()
    let disposeBag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLoginLayout()
        self.loginConfirmButton.addTarget(self, action: #selector(receiveLoginAPI), for: .touchUpInside)
        self.kakaoLoginButton.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUpTransform), for: .touchUpInside)
        let tokenKeyChain = KeychainWrapper.standard.string(forKey: "token")
        print("TokenkeyChain 값 입니다", tokenKeyChain)
        if tokenKeyChain != nil {
            let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
            guard let MainVC = mainView else { return }
            self.navigationController?.pushViewController(MainVC, animated: true)
        } else {
            //ErrorAlert
            
        }
        self.TextfiledBind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.keyboardAddObserver()
    }
    
    override func viewDidLayoutSubviews() {
        self.setCircleLoginLayout()
    }
    
    private func setCircleLoginLayout(){
        self.naverLoginButton.layer.cornerRadius = self.naverLoginButton.frame.size.width / 2.0
        self.naverLoginButton.layer.masksToBounds = true
        self.kakaoLoginButton.layer.cornerRadius = self.kakaoLoginButton.frame.size.width / 2.0
        self.kakaoLoginButton.layer.masksToBounds = true
        self.googleLoginButton.layer.cornerRadius = self.googleLoginButton.frame.size.width / 2.0
        self.googleLoginButton.layer.masksToBounds = true
    }
    
    private func TextfiledBind() {
        loginEmailTextFiled.rx.text
            .bind(to: ViewModel.input.EmailText)
            .disposed(by: disposeBag)
        loginPasswordTextFiled.rx.text
            .bind(to: ViewModel.input.PassWordText)
            .disposed(by: disposeBag)
        ViewModel.output.setEmailTextEnabled
            .drive { (isEmpty) in
                self.loginEmailTextFiled.rx.base.layer.borderColor = isEmpty
            }.disposed(by: disposeBag)
        ViewModel.output.setPasswordTextEnabled
            .drive { (isEmpty) in
                self.loginPasswordTextFiled.rx.base.layer.borderColor = isEmpty
            }.disposed(by: disposeBag)
        ViewModel.output.isEmptyEmailText
            .drive { (isHidden) in
                self.loginEmailTextFiled.rightView?.rx.base.isHidden = isHidden
            }.disposed(by: disposeBag)
    }
    
    private func kakaoAPICall() {
        if KeychainWrapper.standard.string(forKey: "Kakaotoken") != nil{
            OAuthApi.shared.AuthKakaoLoginCall { result in
                switch result {
                case.success(let value):
                    if value.code == 400 {
                        let kakaoParamter = KakaoUserParamter(nickname: "Do-hsaa", service_use_agree: true)
                        OAuthApi.shared.AuthkakaoSignUp(KakaoUserParamter: kakaoParamter) {  result in
                            switch result {
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
    
    // MARK: - 초기 로그인 Layout 구현
    private func setLoginLayout(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
    
        self.loginConfirmButton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)]), for: .normal)
        self.loginConfirmButton.tintColor = UIColor.white
        self.loginConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.loginConfirmButton.layer.borderColor = UIColor.clear.cgColor
        self.loginConfirmButton.layer.cornerRadius = 8
        self.loginConfirmButton.layer.masksToBounds = true
        
        self.loginTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.loginTitleLabel.text = "나와 딱 맞는 \n스터디를 찾고 계신가요?"
        self.loginTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.loginTitleLabel.textAlignment = .left
        self.loginTitleLabel.numberOfLines = 2
        
        self.loginSubTitleLabel.text = "스터디가 Fun해지는 시간! \n시작이 반이다. 첫 걸음을 환영합니다.😊"
        self.loginSubTitleLabel.lineBreakMode = .byWordWrapping
        self.loginSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.loginSubTitleLabel.textColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
        self.loginSubTitleLabel.textAlignment = .left
        self.loginSubTitleLabel.numberOfLines = 2
        
        self.loginFirstGrayLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.31)
        self.loginSecondGrayLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.31)
        
        self.loginDescriptionLabel.text = "다음 계정으로 이용"
        self.loginDescriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.loginDescriptionLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        self.loginDescriptionLabel.textAlignment = .center
        
        self.loginEmailTextFiled.attributedPlaceholder = NSAttributedString(string: "이메일 주소 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        self.loginEmailTextFiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.loginEmailTextFiled.layer.borderWidth = 1.0
        self.loginEmailTextFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.loginEmailTextFiled.leftViewMode = .always
        
        self.loginPasswordTextFiled.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        self.loginPasswordTextFiled.isSecureTextEntry = true
        self.loginPasswordTextFiled.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
        self.loginPasswordTextFiled.layer.borderWidth = 1.0
        self.loginPasswordTextFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.loginPasswordTextFiled.leftViewMode = .always
        
        self.loginAutoTitleLabel.text = "자동로그인"
        self.loginAutoTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.loginAutoTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.loginAutoTitleLabel.numberOfLines = 1
        self.loginAutoTitleLabel.textAlignment = .center
        
        self.signUpButton.setAttributedTitle(NSAttributedString(string: "이메일로 회원가입", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0),NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.kern : -0.66]), for: .normal)
    
        self.kakaoLoginButton.backgroundColor = UIColor(red: 255/255, green: 198/255, blue: 83/255, alpha: 1.0)
        self.kakaoLoginButton.setAttributedTitle(NSAttributedString(string: "카", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.kakaoLoginButton.layer.cornerRadius = self.kakaoLoginButton.frame.size.width / 2.0
        self.kakaoLoginButton.layer.borderColor = UIColor.clear.cgColor
        
        self.naverLoginButton.backgroundColor = UIColor(red: 42/255, green: 210/255, blue: 137/255, alpha: 1.0)
        self.naverLoginButton.setAttributedTitle(NSAttributedString(string: "네", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.naverLoginButton.layer.cornerRadius = self.naverLoginButton.frame.size.width / 2.0
        self.naverLoginButton.layer.borderColor = UIColor.clear.cgColor
        
        self.googleLoginButton.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        self.googleLoginButton.setAttributedTitle(NSAttributedString(string: "구", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(1.0)),NSAttributedString.Key.foregroundColor : UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 0.17)]), for: .normal)
        self.googleLoginButton.layer.cornerRadius = self.googleLoginButton.frame.size.width / 2.0
        self.googleLoginButton.layer.borderColor = UIColor.clear.cgColor
        
        
    }
    
    
    public func keyboardAddObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc
    func keyboardWillShow(_ notification : NSNotification){
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardFrameRect = keyboardFrame.cgRectValue
            let keyboardFrameHeight = keyboardFrameRect.height
            self.loginConfirmButton.frame = CGRect(x: self.loginConfirmButton.frame.origin.x, y: self.loginConfirmButton.frame.origin.y - keyboardFrameHeight, width: self.loginConfirmButton.frame.size.width, height: self.loginConfirmButton.frame.size.height)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification : NSNotification){
        if let keyboardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrameRect = keyboardFrame.cgRectValue
            let keyboardFrameHight = keyboardFrameRect.height
            self.loginConfirmButton.frame = CGRect(x: self.loginConfirmButton.frame.origin.x, y: self.loginConfirmButton.frame.origin.y + keyboardFrameHight, width: self.loginConfirmButton.frame.size.width, height: self.loginConfirmButton.frame.size.height)
        }
    }
    
    
    @objc
    func kakaoLogin(){
        UserApi.shared.loginWithKakaoAccount { (oAuthToken, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                _ = oAuthToken
                guard let AccesToken = oAuthToken?.accessToken else { return }
                if AccesToken != "" {
                    KeychainWrapper.standard.set(AccesToken, forKey: "Kakaotoken")
                    self.kakaoAPICall()
                }
            }
        }
    }
    
    @objc
    func signUpTransform() {
        let Storyboard = UIStoryboard(name: "SignupViewController", bundle: nil)
        let SignView = Storyboard.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let SignVC = SignView else { return }
        self.navigationController?.pushViewController(SignVC, animated: true)
    }

    @objc func receiveLoginAPI() {
        let paramter = LoginParamter(email: self.loginEmailTextFiled.text!, password: self.loginPasswordTextFiled.text!)
        OAuthApi.shared.AuthLoginfetch(LoginParamter: paramter) { result in
            print(result.code)
            if result.code == 200{
                KeychainWrapper.standard.set(result.result!.token, forKey: "token")
                let mainView = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController
                guard  let mainVC =  mainView else { return }
                self.navigationController?.pushViewController(mainVC, animated: true)
            }else{
                // ErrorAlert
            }
        }
    }
    
    @objc
    func showAccountView() {
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let signVC = signUpView else { return }
        self.navigationController?.pushViewController(signVC, animated: false)
    }
    
    @IBAction func HideAlertView(_ sender: Any) {
        self.ErrorAlert.removeFromSuperview()
    }
}
