//
//  LoginViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import SnapKit



class LoginViewController: UIViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var AccountLabel: UILabel!
    @IBOutlet weak var AccountAddBtn: UIButton!
    @IBOutlet weak var AccountFindBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetLoginLayout()
        self.SetAutoLayout()
        self.AccountAddBtn.addTarget(self, action: #selector(showAccountView), for: .touchUpInside)
    }
    
    
    // MARK - 초기 Layout 세팅
    private func SetLoginLayout(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true
        
        
        self.EmailTextField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.EmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.EmailTextField.layer.borderWidth = 1.0
        self.EmailTextField.textContentType = .emailAddress
        self.EmailTextField.borderStyle = .line
        self.EmailTextField.frame = CGRect(x: self.EmailTextField.frame.origin.x, y: self.EmailTextField.frame.origin.y, width: self.EmailTextField.frame.size.width, height: self.EmailTextField.frame.size.height)
        
        self.PasswordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(1.0)), NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.PasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.PasswordTextField.layer.borderWidth = 1.0
        self.PasswordTextField.textContentType = .password
        self.PasswordTextField.borderStyle = .line
        self.PasswordTextField.frame = CGRect(x: self.PasswordTextField.frame.origin.x, y: self.PasswordTextField.frame.origin.y, width: self.PasswordTextField.frame.size.width, height: self.PasswordTextField.frame.size.height)
        
        self.ConfirmButton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.ConfirmButton.tintColor = UIColor.white
        self.ConfirmButton.backgroundColor = UIColor.black
        self.ConfirmButton.layer.borderColor = UIColor.clear.cgColor
        self.ConfirmButton.layer.cornerRadius = 12
        self.ConfirmButton.layer.masksToBounds = true
        
        self.AccountLabel.attributedText = NSAttributedString(string: "계졍이 없으신가요?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 1.0))])
        self.AccountLabel.textColor = UIColor.lightGray
        self.AccountLabel.textAlignment = .center
        self.AccountLabel.frame = CGRect(x: self.AccountLabel.frame.origin.x, y: self.AccountLabel.frame.origin.y, width: self.AccountLabel.frame.size.width, height: self.AccountLabel.frame.size.height)
        
        let UnderLineAttributed = NSMutableAttributedString(string: "가입하기")
        UnderLineAttributed.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, UnderLineAttributed.string.count))
        UnderLineAttributed.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 1.0)), range: NSMakeRange(0, UnderLineAttributed.string.count))
        self.AccountAddBtn.setAttributedTitle(UnderLineAttributed, for: .normal)
        self.AccountAddBtn.layer.borderColor = UIColor.clear.cgColor
        self.AccountAddBtn.tintColor = UIColor.lightGray
        self.AccountAddBtn.frame = CGRect(x: self.AccountAddBtn.frame.origin.x, y: self.AccountAddBtn.frame.origin.y, width: self.AccountAddBtn.frame.size.width, height: self.AccountAddBtn.frame.size.height)
        
        let FindAccoundUnderLine = NSMutableAttributedString(string: "비밀번호를잊으셨나요?")
        FindAccoundUnderLine.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, FindAccoundUnderLine.string.count))
        FindAccoundUnderLine.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 1.0)), range: NSMakeRange(0, FindAccoundUnderLine.string.count))
        
        self.AccountFindBtn.setAttributedTitle(FindAccoundUnderLine, for: .normal)
        self.AccountFindBtn.layer.borderColor = UIColor.clear.cgColor
        self.AccountFindBtn.tintColor = UIColor.lightGray
        self.AccountFindBtn.frame = CGRect(x: self.AccountFindBtn.frame.origin.x, y: self.AccountFindBtn.frame.origin.y, width: self.AccountFindBtn.frame.size.width, height: self.AccountFindBtn.frame.size.height)
        

    }
    
    private func SetAutoLayout(){
        self.EmailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(256)
            make.left.equalTo(self.view).offset(47)
            make.right.equalTo(self.view).offset(-47)
            
            
        }
        self.PasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.EmailTextField.snp.bottom).offset(65)
            make.left.equalTo(self.view).offset(47)
            make.right.equalTo(self.view).offset(-47)
            
        }
        
        self.ConfirmButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(47)
            make.right.equalTo(self.view).offset(-47)
            make.bottom.equalTo(self.view).offset(-220)
            make.size.equalTo(CGSize(width: 320, height: 30))
        }
        
        self.AccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.ConfirmButton.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(100)
            make.bottom.equalTo(self.view).offset(-170)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        self.AccountAddBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.AccountLabel.snp.right).offset(5)
            make.right.equalTo(self.view).offset(-94)
            make.bottom.equalTo(self.view).offset(-170)
            make.size.equalTo(CGSize(width: 65, height: 20))
        }
        self.AccountFindBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(100)
            make.right.equalTo(self.view).offset(-100)
            make.bottom.equalTo(self.view).offset(-64)
            make.top.equalTo(self.AccountAddBtn.snp.bottom).offset(75)
            make.size.equalTo(CGSize(width: 214, height: 30))
        }
    }
    
    @objc func showAccountView(){
          let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "SignView") as? SignupViewController
        guard let SignVC = signUpView else { return }
        self.navigationController?.pushViewController(SignVC, animated: false)
    }
}
