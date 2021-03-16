//
//  PasswordFindViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/15.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class PasswordFindViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordFindTitleLabel: UILabel!
    @IBOutlet weak var passwordFindSubTitleLabel: UILabel!
    @IBOutlet weak var passwordFindEmailTextfiled: UITextField!
    @IBOutlet weak var passwordFindConfirmButton: UIButton!
    @IBOutlet weak var passwordFindIncorrectLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordFindEmailTextfiled.delegate = self
        self.setLayoutInit()
        self.setNavigationLayout()
        self.passwordFindConfirmButton.addTarget(self, action: #selector(isVaildEamil), for: .touchUpInside)
    }
    private func setNavigationLayout(){
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let navigationBackButton = UIImage(named: "Navigation.png")
        self.navigationController?.navigationBar.backIndicatorImage = navigationBackButton
    }
    
    
    private func setLayoutInit(){
        self.passwordFindTitleLabel.text = "이메일 확인"
        self.passwordFindTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.passwordFindTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.passwordFindTitleLabel.textAlignment = .left
        self.passwordFindSubTitleLabel.attributedText = NSAttributedString(string: "비밀번호를 재설정하기 위해 인증 코드를 이메일로 보냅니다.", attributes: [NSAttributedString.Key.kern: -0.77])
        self.passwordFindSubTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.passwordFindSubTitleLabel.textAlignment = .left
        self.passwordFindSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.passwordFindEmailTextfiled.layer.borderWidth = 1
        self.passwordFindEmailTextfiled.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        self.passwordFindEmailTextfiled.leftView = leftView
        self.passwordFindEmailTextfiled.leftViewMode = .always
        self.passwordFindEmailTextfiled.attributedPlaceholder = NSAttributedString(string: "이메일 주소 입력", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.passwordFindEmailTextfiled.clearButtonMode = .whileEditing
        self.passwordFindEmailTextfiled.layer.cornerRadius = 6
        self.passwordFindEmailTextfiled.layer.masksToBounds = true
        self.passwordFindConfirmButton.setAttributedTitle(NSAttributedString(string: "재설정", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.passwordFindConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.passwordFindConfirmButton.layer.cornerRadius = 8
        self.passwordFindConfirmButton.layer.masksToBounds = true
        self.passwordFindConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.passwordFindIncorrectLabel.attributedText = NSAttributedString(string: "올바른 이메일 주소를 입력하세요.", attributes: [NSAttributedString.Key.kern: -0.66])
        self.passwordFindIncorrectLabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
        self.passwordFindIncorrectLabel.textAlignment = .left
        self.passwordFindIncorrectLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.passwordFindIncorrectLabel.isHidden = true
        
    }
    
    
    @objc
    private func isVaildEamil(){
        OAuthApi.shared.AuthEmailOverlap(Email: self.passwordFindEmailTextfiled.text!) { result in
            switch result {
            case .success(let value):
                if value.check_result == true {
                    UserDefaults.standard.set(self.passwordFindEmailTextfiled.text!, forKey: "authEmail")
                } else {
                    self.passwordFindIncorrectLabel.isHidden = false
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.passwordFindEmailTextfiled.resignFirstResponder()
        return true
    }
    
}
