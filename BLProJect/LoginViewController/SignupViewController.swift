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
    
    public var ViewModel = SignViewModel()
    public let disposedBag = DisposeBag()
    private let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    private let SignupURL : URL = URL(string: "http://3.214.168.45:8080/api/v1/user")!
    
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
    
    public func SetSingViewLayout(){
        
        self.SubjectLabel.attributedText = NSAttributedString(string: "스터디를 찾거나 참가하려면\n 가입하세요", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.SubjectLabel.textAlignment = .center
        self.SubjectLabel.numberOfLines = 2
        
        self.SignEmailTextField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0))])
        self.SignEmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.SignEmailTextField.layer.borderWidth = 1.0
        self.SignEmailTextField.textContentType = .emailAddress
        self.SignEmailTextField.borderStyle = .line
        self.SignEmailTextField.frame = CGRect(x: self.SignEmailTextField.frame.origin.x, y: self.SignEmailTextField.frame.origin.y, width: self.SignEmailTextField.frame.size.width, height: self.SignEmailTextField.frame.size.height)
        self.SignEmailTextField.UnderLine()
        
        self.SignNicknamTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0))])
        self.SignNicknamTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.SignNicknamTextField.layer.borderWidth = 1.0
        self.SignNicknamTextField.textContentType = .name
        self.SignNicknamTextField.borderStyle = .line
        self.SignNicknamTextField.frame = CGRect(x: self.SignNicknamTextField.frame.origin.x, y: self.SignNicknamTextField.frame.origin.y, width: self.SignNicknamTextField.frame.size.width, height: self.SignNicknamTextField.frame.size.height)
        self.SignNicknamTextField.UnderLine()
        
        self.SignPasswordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0))])
        self.SignPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.SignPasswordTextField.layer.borderWidth = 1.0
        self.SignPasswordTextField.textContentType = .password
        self.SignPasswordTextField.borderStyle = .line
        self.SignPasswordTextField.frame = CGRect(x: self.SignPasswordTextField.frame.origin.x, y: self.SignPasswordTextField.frame.origin.y, width: self.SignPasswordTextField.frame.size.width, height: self.SignPasswordTextField.frame.size.height)
        self.SignPasswordTextField.UnderLine()
        
        self.SignJoinButton.backgroundColor = UIColor.black
        self.SignJoinButton.setAttributedTitle(NSAttributedString(string: "가입하기", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        self.SignJoinButton.layer.borderColor = UIColor.clear.cgColor
        self.SignJoinButton.layer.cornerRadius = 12
        self.SignJoinButton.frame = CGRect(x: self.SignJoinButton.frame.origin.x, y: self.SignJoinButton.frame.origin.y, width: self.SignJoinButton.frame.size.width, height: self.SignJoinButton.frame.size.height)
        
    }
    
    public func SignViewAutoLayout(){
        self.SubjectLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 374, height: 100))
            make.top.equalTo(self.view).offset(156)
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.SignEmailTextField.snp.top).offset(-48)
            
        }
        self.SignEmailTextField.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.SignNicknamTextField.snp.top).offset(-70)
            make.top.equalTo(self.SubjectLabel.snp.bottom).offset(48)
            make.size.equalTo(CGSize(width: 374, height: 30))
        }
        self.SignNicknamTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.SignEmailTextField.snp
                .bottom).offset(70)
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.SignPasswordTextField.snp.top).offset(-70)
            make.size.equalTo(CGSize(width: 374, height: 30))
        }
        self.SignPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.SignNicknamTextField.snp.bottom).offset(70)
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.SignJoinButton.snp.top).offset(-83)
            make.size.equalTo(CGSize(width: 374, height: 30))
        }
        self.SignJoinButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.SignPasswordTextField.snp.bottom).offset(83)
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-149)
            make.size.equalTo(CGSize(width: 374, height: 40))
        }
    }
    
    
    private func AddUserServiceApi(Url : URL, header : HTTPHeaders, paramter : Parameters){
        
        AF.request(Url, method: .post, parameters: paramter, encoding: JSONEncoding.default, headers: header)
            .responseJSON { (response) in
                if response.response?.statusCode == 200 {
                    print("Succes")
                }else if response.response?.statusCode == 404 {
                    print("error")
                }
                
                switch response.result {
                case .success(let value):
                    print(value)
                    let value = String(bytes: response.data!, encoding: .utf8)
                    print(value)
                    let JsonData = JSON(value)
                    for (key,subJson):(String,JSON) in JsonData["results"] {
                        print(subJson["email"].stringValue)
                        print(subJson["nickname"].stringValue)
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
        
        
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
        let paramter : Parameters = [
            "email" : self.SignEmailTextField.text!,
            "password" : self.SignPasswordTextField.text!,
            "nickname" : self.SignNicknamTextField.text!,
        ]
        let OauthEmailParamter = oAuthParamter(email: self.SignEmailTextField.text!)
        
        self.AddUserServiceApi(Url: SignupURL, header: headers, paramter: paramter)
        APIService.shared.oAuthEmailCodePost(oAuthParamter: OauthEmailParamter) {
            print("성공")
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
