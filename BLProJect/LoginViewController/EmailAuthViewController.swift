//
//  EmailAuthViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/27.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class EmailAuthViewController: UIViewController {
    
    @IBOutlet weak var SendEmailLabel: UILabel!
    @IBOutlet weak var SendEmailSubLabel: UILabel!
    @IBOutlet weak var SendEmailConfirmView: UIView!
    @IBOutlet weak var SendEmailExampleView: UIView!
    @IBOutlet weak var SendEmailIconImage: UIImageView!
    @IBOutlet weak var SendEmailExampleLabel: UILabel!
    @IBOutlet weak var SendEmailConfirmButton: UIButton!
    @IBOutlet weak var SendEmailResetLabel: UILabel!
    @IBOutlet weak var SendEmailResetButton: UIButton!
    @IBOutlet weak var SendEmailQuestionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Layoutinit()
    }
    
    private func Layoutinit() {
        self.SendEmailLabel.text = "인증메일 발송 완료"
        self.SendEmailLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.SendEmailLabel.tintColor = UIColor(red: 61/255, green: 61/266, blue: 61/255, alpha: 1.0)
        self.SendEmailSubLabel.attributedText = NSAttributedString(string: "\(UserDefaults.standard.string(forKey: "oAuth_Email")!)으로 인증 메일을 발송했습니다.", attributes: [NSAttributedString.Key.kern: -0.7])
        self.SendEmailSubLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.SendEmailSubLabel.textAlignment = .left
        self.SendEmailSubLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        
        self.SendEmailConfirmView.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1.0)
        self.SendEmailConfirmView.layer.masksToBounds = true
        self.SendEmailConfirmView.layer.cornerRadius = 4
        self.SendEmailConfirmView.layer.borderWidth = 1
        self.SendEmailConfirmView.layer.borderColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0).cgColor
        self.SendEmailIconImage.image = UIImage(named: "spongeEmail.png")
        self.SendEmailIconImage.contentMode = .scaleAspectFill
    
        self.SendEmailExampleView.backgroundColor = UIColor(red: 255/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.SendEmailExampleView.layer.cornerRadius = self.SendEmailExampleView.frame.size.height / 2
        self.SendEmailExampleView.layer.masksToBounds = true
        self.SendEmailExampleLabel.textColor = UIColor(red: 251/255, green: 112/255, blue: 112/255, alpha: 1.0)
        self.SendEmailExampleLabel.textAlignment = .left
        self.SendEmailExampleLabel.attributedText = NSAttributedString(string: "메일함에서 [이메일 인증하기] 버튼을 눌러주세요.", attributes: [NSAttributedString.Key.kern: -0.6])
        self.SendEmailExampleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)

        self.SendEmailConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.SendEmailConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.SendEmailConfirmButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        self.SendEmailConfirmButton.setTitle("다음", for: .normal)
        self.SendEmailConfirmButton.layer.cornerRadius = 8.0
        self.SendEmailConfirmButton.layer.masksToBounds = true
        self.SendEmailConfirmButton.addTarget(self, action: #selector(UserAuchConfirmAction), for: .touchUpInside)
        
        self.SendEmailResetLabel.textAlignment = .left
        self.SendEmailResetLabel.attributedText = NSAttributedString(string: "메일을 받지 못하셨나요?", attributes: [NSAttributedString.Key.kern: -0.66])
        self.SendEmailResetLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.SendEmailResetLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        
        self.SendEmailResetButton.titleLabel?.textAlignment = .left
        self.SendEmailResetButton.setTitleColor(UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0), for: .normal)
        self.SendEmailResetButton.setAttributedTitle(NSAttributedString(string: "인증 메일 다시 받기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14),NSAttributedString.Key.kern: -0.77]), for: .normal)
        self.SendEmailResetButton.addTarget(self, action: #selector(SelectSendEmail), for: .touchUpInside)
        
        self.SendEmailQuestionButton.setAttributedTitle(NSAttributedString(string: "문의하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14)]), for: .normal)
        self.SendEmailQuestionButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        
    }
        
    @objc private func SelectSendEmail() {
        let EmailParamter = AuthEmailSendParamter(email: UserDefaults.standard.string(forKey: "oAuth_Email")!)
        print(UserDefaults.standard.value(forKey: "oAuth_Email"))
        UtilApi.shared.UtilSendResetEmailCall(EmailParamter: EmailParamter) { result in
            switch result {
            case .success(let value):
                if value.code == 200 {
                    print("확인되었습니다.")
                } else {
                    print("실패했습니다.")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func UserAuchConfirmAction(){
        
        OAuthApi.shared.AuthCheckUserCall(checkUser: UserDefaults.standard.string(forKey: "oAuth_Email")!) { result in
            switch result {
            case .success(let value):
                if value.code == 200 && value.check_result == false {
                    let Storyboard = UIStoryboard(name: "UserInformationViewController", bundle: nil)
                    let informView = Storyboard.instantiateViewController(withIdentifier: "UserInformation") as? UserInformationViewController
                    guard let InformVC = informView else {return}
                    self.navigationController?.pushViewController(InformVC, animated: true)
                    print("유저 체크 성공")
                } else {
                    print("유저 체크 실패")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
