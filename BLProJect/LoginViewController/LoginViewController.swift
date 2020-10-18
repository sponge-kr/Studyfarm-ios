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




class LoginViewController: UIViewController {
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var MainSubject: UILabel!
    @IBOutlet weak var ContourLine: UIView!
    @IBOutlet weak var ContourLine2: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var KakaoLoginBtn: UIButton!
    
    
    private var LoginURL : URL = URL(string: "http://3.214.168.45:8080/api/v1/auth/login")!
    public var ErrorAlert : LoginAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetLoginLayout()
        self.SetAutoLayout()
        self.ConfirmButton.addTarget(self, action: #selector(ReceiveLoginAPI), for: .touchUpInside)
        self.KakaoLoginBtn.addTarget(self, action: #selector(KakaoLogin), for: .touchUpInside)
        let TokenKeyChain = KeychainWrapper.standard.string(forKey: "token")
        print("TokenkeyChain 값 입니다",TokenKeyChain)
        if TokenKeyChain != nil {
            let MainViewCall = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
            guard let MainVC = MainViewCall else { return }
            self.navigationController?.pushViewController(MainVC, animated: true)
        }else{
            //ErrorAlert
            
            
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.KeyboardAddObserver()
    }
    
    
    // MARK - 초기 Layout 세팅
    private func SetLoginLayout(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        
    
        
        
        self.ConfirmButton.setAttributedTitle(NSAttributedString(string: "이메일로 회원가입", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.ConfirmButton.tintColor = UIColor.white
        self.ConfirmButton.backgroundColor = UIColor(red: 73/255, green: 72/255, blue: 75/255, alpha: 1.0)
        self.ConfirmButton.layer.borderColor = UIColor.clear.cgColor
        self.ConfirmButton.layer.cornerRadius = 30
        self.ConfirmButton.layer.masksToBounds = true
        
        self.MainSubject.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight(rawValue: 1.0))
        self.MainSubject.text = "스터디모임을 손쉽게 찾아 함께 공부해요!"
        self.MainSubject.textColor = UIColor.black
        self.MainSubject.textAlignment = .left
        self.MainSubject.frame = CGRect(x: self.MainSubject.frame.origin.x, y: self.MainSubject.frame.origin.y, width: self.MainSubject.frame.size.width, height: self.MainSubject.frame.size.height)
        self.MainSubject.numberOfLines = 2
        
        
        self.ContourLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.ContourLine.frame = CGRect(x: self.ContourLine.frame.origin.x, y: self.ContourLine.frame.origin.y, width: self.ContourLine.frame.size.width, height: self.ContourLine.frame.size.height)
        self.ContourLine2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.13)
        self.ContourLine2.frame = CGRect(x: self.ContourLine2.frame.origin.x, y: self.ContourLine2.frame.origin.y, width: self.ContourLine2.frame.size.width, height: self.ContourLine2.frame.size.height)
        
        
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.descriptionLabel.text = "또는"
        self.descriptionLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.frame = CGRect(x: self.descriptionLabel.frame.origin.x, y: self.descriptionLabel.frame.origin.y, width: self.descriptionLabel.frame.size.width, height: self.descriptionLabel.frame.size.height)
        
    
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
        AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            
            //do something
            _ = oauthToken
           }
        }
    }
    
    @objc func ReceiveLoginAPI(){
//        let Paramter = LoginParamter(email: self.EmailTextField.text!, password: self.PasswordTextField.text!)
        
//        APIService.shared.RequestLoginServer(LoginParamter: Paramter) { [weak self] result in
//            switch result {
//            case .success(let value):
//                print("테스트 status code 값입니다 : " ,value.message)
//                if value.code == 200 {
//                    KeychainWrapper.standard.set(APIService.shared.LoginData.token, forKey: "token")
//                    let MainView = self?.storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController
//                    guard let MainVC = MainView else { return }
//                    self?.navigationController?.pushViewController(MainVC, animated: true)
//                }else{
//                    self?.ErrorAlert = LoginAlertView(frame: self!.view.frame)
//                    self?.ErrorAlert.LoginTitle.text = value.message
//                    self?.view.addSubview(self!.ErrorAlert)
//                    self?.ErrorAlert.LoginConfirmBtn.addTarget(self, action: #selector(self?.HideAlertView(_:)), for: .touchUpInside)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
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




