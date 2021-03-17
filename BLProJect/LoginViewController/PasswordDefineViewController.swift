//
//  PasswordDefineViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/17.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit


class PasswordDefineViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordDefineTitleLabel: UILabel!
    @IBOutlet weak var passwordDefineSubTitleLabel: UILabel!
    @IBOutlet weak var definePasswordTextfiled: UITextField!
    @IBOutlet weak var passwordIncorrectTitleLabel: UILabel!
    @IBOutlet weak var passwordConfirmButton: UIButton!
    
    lazy var defineView : UIView = {
        let defineRightView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        defineRightView.addSubview(self.defineRightButton)
        defineRightView.tag = 0
        return defineRightView
    }()
    
    lazy var defineRightButton: UIButton = {
        let defineButton = UIButton(type: .custom)
        defineButton.frame = CGRect(x: 0, y: 10, width: 24, height: 12)
        defineButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
        defineButton.addTarget(self, action: #selector(isSecureTextEntryEnabled(sender:)), for: .touchUpInside)
        defineButton.tag = 1
        return defineButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definePasswordTextfiled.delegate = self
        self.setLayoutInit()
    }
    
    public func setLayoutInit() {
        self.passwordDefineTitleLabel.text = "비밀번호 재설정"
        self.passwordDefineTitleLabel.textAlignment = .left
        self.passwordDefineTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.passwordDefineTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.passwordDefineSubTitleLabel.textAlignment = .left
        self.passwordDefineSubTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.passwordDefineSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.passwordDefineSubTitleLabel.attributedText = NSAttributedString(string: "비밀번호는 1번만 입력하니 정확히 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.77])
        let defineLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        self.definePasswordTextfiled.rightView = self.defineView
        self.definePasswordTextfiled.rightViewMode = .always
        self.definePasswordTextfiled.leftView = defineLeftView
        self.definePasswordTextfiled.leftViewMode = .always
        self.definePasswordTextfiled.layer.borderWidth = 1
        self.definePasswordTextfiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.definePasswordTextfiled.layer.cornerRadius = 6
        self.definePasswordTextfiled.layer.masksToBounds = true
        self.definePasswordTextfiled.isSecureTextEntry = true
        self.definePasswordTextfiled.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.passwordIncorrectTitleLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
        self.passwordIncorrectTitleLabel.textAlignment = .left
        self.passwordIncorrectTitleLabel.attributedText = NSAttributedString(string: "비밀번호가 너무 짧습니다.", attributes: [NSAttributedString.Key.kern: -0.66])
        self.passwordIncorrectTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.passwordIncorrectTitleLabel.isHidden = true
        self.passwordConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.passwordConfirmButton.setTitle("확인", for: .normal)
        self.passwordConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.passwordConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.passwordConfirmButton.layer.cornerRadius = 8
        self.passwordConfirmButton.layer.masksToBounds = true
        self.passwordConfirmButton.isEnabled = false
    }
    @objc
    private func isSecureTextEntryEnabled( sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.defineRightButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
            self.definePasswordTextfiled.rightView = self.defineView
            self.definePasswordTextfiled.rightViewMode = .always
            self.definePasswordTextfiled.isSecureTextEntry = true
            self.definePasswordTextfiled.setNeedsLayout()
        } else {
            sender.isSelected = true
            self.defineRightButton.setImage(UIImage(named: "eye.png"), for: .selected)
            self.definePasswordTextfiled.rightView = self.defineView
            self.definePasswordTextfiled.rightViewMode = .always
            self.definePasswordTextfiled.isSecureTextEntry = false
            self.definePasswordTextfiled.setNeedsLayout()
        }
    }
    
    
    @objc
    private func shouldChangePassword() {
        let ChageEmailParamter = EmailParamter(password: self.definePasswordTextfiled.text!)
        OAuthApi.shared.AuthPasswordChange(Email: UserDefaults.standard.string(forKey: "authEmail")!, EmailParamter: ChageEmailParamter) { result in
            switch result {
            case .success(let value):
                if value.code == 200 {
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count > 6 {
            self.passwordConfirmButton.isEnabled = true
            self.passwordIncorrectTitleLabel.isHidden = true
            self.definePasswordTextfiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
            self.passwordConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.passwordIncorrectTitleLabel.setNeedsLayout()
            self.definePasswordTextfiled.setNeedsLayout()
            self.passwordConfirmButton.setNeedsLayout()
        } else {
            self.passwordIncorrectTitleLabel.isHidden = false
            self.definePasswordTextfiled.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
            self.passwordConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.passwordIncorrectTitleLabel.setNeedsLayout()
            self.definePasswordTextfiled.setNeedsLayout()
            self.passwordConfirmButton.setNeedsLayout()
        }
        return true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.definePasswordTextfiled.resignFirstResponder()
        
        return true
    }
    
}
