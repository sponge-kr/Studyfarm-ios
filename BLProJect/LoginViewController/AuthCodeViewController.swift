//
//  AuthCodeViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/17.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class AuthCodeViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var authCodeTitleLabel: UILabel!
    @IBOutlet weak var authCodeSubTitleLabel: UILabel!
    @IBOutlet weak var authCodeTextFiled: UITextField!
    @IBOutlet weak var authCodeIncorrectLabel: UILabel!
    @IBOutlet weak var authCodeConfirmButton: UIButton!
    @IBOutlet weak var authResendCodeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var authResendCodeButton: UIButton!
    @IBOutlet weak var authcodeExampleLabel: UILabel!
    var timer : Timer?
    var timeLeft = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayoutInit()
        self.isCorrectCode()
        self.authCodeTextFiled.delegate = self
        self.authCodeConfirmButton.addTarget(self, action: #selector(shouldReturnCode), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerdecrease), userInfo: nil, repeats: true)
    }
    
    private func setLayoutInit(){
        self.authCodeTitleLabel.text = "6자리 인증 코드 입력"
        self.authCodeTitleLabel.textAlignment = .left
        self.authCodeTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.authCodeTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.authCodeSubTitleLabel.attributedText = NSAttributedString(string: "\(UserDefaults.standard.string(forKey: "authEmail")!) 로 인증 코드를 전송했습니다.", attributes: [NSAttributedString.Key.kern: -0.77])
        self.authCodeSubTitleLabel.textAlignment = .left
        self.authCodeSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.authCodeSubTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        let authCodeLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        self.authCodeTextFiled.leftView = authCodeLeftView
        self.authCodeTextFiled.leftViewMode = .always
        self.authCodeTextFiled.layer.borderWidth = 1
        self.authCodeTextFiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.authCodeTextFiled.layer.cornerRadius = 6
        self.authCodeTextFiled.layer.masksToBounds = true
        self.authCodeTextFiled.attributedPlaceholder = NSAttributedString(string: "인증 코드 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.authCodeIncorrectLabel.text = "잘못된 코드 입니다."
        self.authCodeIncorrectLabel.textAlignment = .left
        self.authCodeIncorrectLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.authCodeIncorrectLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
        self.authCodeIncorrectLabel.isHidden = true
        
        self.authCodeConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.authCodeConfirmButton.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.authCodeConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.authCodeConfirmButton.layer.cornerRadius = 8
        self.authCodeConfirmButton.layer.masksToBounds = true
        self.authResendCodeButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.authResendCodeButton.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 12)]), for: .normal)
        self.authResendCodeButton.isEnabled = false
        self.authcodeExampleLabel.attributedText = NSAttributedString(string: "메일을 받지 못하셨다면 스펨 메일함을 확인해주세요.", attributes: [NSAttributedString.Key.kern: -0.66])
        self.authcodeExampleLabel.textAlignment = .left
        self.authcodeExampleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.authcodeExampleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)

    }
    
    private func isCorrectCode() {
        if self.authCodeIncorrectLabel.isHidden == true {
            UIView.animate(withDuration: 0.2) {
                self.authResendCodeTopConstraint.constant = -14
            }
        }
    }
    
    @objc
    public func onTimerdecrease() {
        timeLeft -= 1
        self.authResendCodeButton.setTitle("코드 재전송  \(timeLeft)s", for: .normal)
        if timeLeft == 0 {
            self.authResendCodeButton.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .normal)
            self.authResendCodeButton.setTitle("코드 재전송", for: .normal)
            self.authResendCodeButton.setNeedsLayout()
            self.authResendCodeButton.isEnabled = true
            self.authResendCodeButton.addTarget(self, action: #selector(resendAuthCode), for: .touchUpInside)
            timer?.invalidate()
            timer = nil
        }
        
    }
    @objc
    public func shouldReturnCode() {
        if UserDefaults.standard.string(forKey: "authCode")! == self.authCodeTextFiled.text! {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let passwordDefineView = storyBoard.instantiateViewController(withIdentifier: "PasswordDefineView") as? PasswordDefineViewController
            guard let PasswordDefineVC = passwordDefineView else { return }
            self.navigationController?.pushViewController(PasswordDefineVC, animated: true)
        } else {
            UIView.animate(withDuration: 0.2) {
                self.authCodeIncorrectLabel.isHidden = false
                self.authResendCodeTopConstraint.constant = 14
                self.authCodeTextFiled.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                self.authResendCodeButton.setNeedsLayout()
                self.authCodeTextFiled.setNeedsLayout()
            }
        }
    }
    @objc
    public func resendAuthCode(){
        UserDefaults.standard.removeObject(forKey: "authCode")
        self.timeLeft = 60
        UIView.animate(withDuration: 0.2) {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerdecrease), userInfo: nil, repeats: true)
            self.authResendCodeButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
            self.authResendCodeButton.setNeedsLayout()
            
        }
        let resendCodeParamter = ResetEmailParamter(email: UserDefaults.standard.string(forKey: "authEmail")!)
        UtilApi.shared.UtilsendResetEmailCode(ResetEmailParamter: resendCodeParamter) { result in
            switch result {
            case .success(let value):
                if value.message == "성공하였습니다." {
                    UserDefaults.standard.set(value.code, forKey: "authCode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.authCodeTextFiled.resignFirstResponder()
        return true
    }
}
