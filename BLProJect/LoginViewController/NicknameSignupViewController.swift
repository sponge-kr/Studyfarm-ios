//
//  NicknameSignupViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/21.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit


class NicknameSignupViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var nicknameTitleLabel: UILabel!
    @IBOutlet weak var nicknameExampleLabel: UILabel!
    @IBOutlet weak var nicknameSubTitleLabel: UILabel!
    @IBOutlet weak var nicknameTextFiled: UITextField!
    @IBOutlet weak var nicknameConfirmButton: UIButton!
    @IBOutlet weak var nicknameErrorTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
        self.nicknameTextFiled.delegate = self
        self.nicknameConfirmButton.addTarget(self, action: #selector(didTapNicknameConfirmButton), for: .touchUpInside)
    }
    
    private func setInitLayout() {
        self.nicknameTitleLabel.text = "닉네임 설정하기"
        self.nicknameTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.nicknameTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.nicknameTitleLabel.textAlignment = .left
        self.nicknameExampleLabel.attributedText = NSAttributedString(string: "다른 사람이 부르기 쉬운 닉네임을 권장합니다.\n한 번 설정한 닉네임은 변경할 수 없습니다.", attributes: [NSAttributedString.Key.kern: -0.82])
        self.nicknameExampleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.nicknameExampleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.nicknameExampleLabel.textAlignment = .left
        self.nicknameExampleLabel.numberOfLines = 0
        self.nicknameSubTitleLabel.text = "닉네임"
        self.nicknameSubTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.nicknameSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.nicknameSubTitleLabel.textAlignment = .left
        self.nicknameTextFiled.layer.borderWidth = 1
        self.nicknameTextFiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.nicknameTextFiled.layer.cornerRadius = 6
        self.nicknameTextFiled.layer.masksToBounds = true
        self.nicknameTextFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.nicknameTextFiled.leftViewMode = .always
        self.nicknameTextFiled.clearButtonMode = .always
        self.nicknameTextFiled.attributedPlaceholder = NSAttributedString(string: "10자 이내로 입력해주세요.", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.nicknameConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.nicknameConfirmButton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.nicknameConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.nicknameConfirmButton.layer.cornerRadius = 8
        self.nicknameConfirmButton.layer.masksToBounds = true
        self.nicknameConfirmButton.isEnabled = false
        self.nicknameErrorTitleLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.66])
        self.nicknameErrorTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.nicknameErrorTitleLabel.textAlignment = .left
        self.nicknameErrorTitleLabel.isHidden = true
        
    }
    @objc
    private func didTapNicknameConfirmButton(){
        OAuthApi.shared.AuthNickNameOverlap(Nickname: self.nicknameTextFiled.text!) { result in
            switch result {
            case .success(let value):
                if value.exist == false {
                    UserDefaults.standard.set(self.nicknameTextFiled.text, forKey: "oAuth_Nickname")
                } else {
                    UIView.animate(withDuration: 0.2) {
                        self.nicknameErrorTitleLabel.isHidden = false
                        self.nicknameConfirmButton.isEnabled = false
                        self.nicknameSubTitleLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                        self.nicknameTextFiled.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                        self.nicknameErrorTitleLabel.text = "이미 사용 중 입니다."
                        self.nicknameErrorTitleLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                        self.nicknameConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
                        self.nicknameConfirmButton.setNeedsLayout()
                        self.nicknameErrorTitleLabel.setNeedsLayout()
                        self.nicknameTextFiled.setNeedsLayout()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
        }
    }
    @objc
    private func keyboardWillHide(_ notificaiton: Notification) {
        if let keyboardFrame: NSValue = notificaiton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nicknameTextFiled.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.nicknameTextFiled.text!.count >= 10 {
            self.nicknameConfirmButton.isEnabled = false
            self.nicknameErrorTitleLabel.isHidden = false
            self.nicknameConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
            self.nicknameTextFiled.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
            self.nicknameSubTitleLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.nicknameErrorTitleLabel.attributedText = NSAttributedString(string: "10자 이내로 입력해주세요", attributes: [NSAttributedString.Key.kern: -0.66])
            self.nicknameErrorTitleLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
        } else {
            self.nicknameConfirmButton.isEnabled = true
            self.nicknameErrorTitleLabel.isHidden = true
            self.nicknameConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.nicknameSubTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.nicknameTextFiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
            self.nicknameConfirmButton.setNeedsLayout()
        }
        
        return true
    }
}


class AgreementView: UIView {
    @IBOutlet weak var agreementTitleLabel: UILabel!
    @IBOutlet weak var agreementFullButton: UIButton!
    @IBOutlet weak var agreementFullTitleLabel: UILabel!
    @IBOutlet weak var agreementLineView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
