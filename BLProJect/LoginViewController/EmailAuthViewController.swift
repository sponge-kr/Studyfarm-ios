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
    @IBOutlet weak var SendEmailConfirmView: UIView!
    @IBOutlet weak var SendEmailIconImage: UIImageView!
    @IBOutlet weak var SendEmailExampleLabel: UILabel!
    @IBOutlet weak var SendEmailConfirmButton: UIButton!
    @IBOutlet weak var SendEmailResetLabel: UILabel!
    @IBOutlet weak var SendEmailResetButton: UIButton!
    @IBOutlet weak var SendEmailQuestionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Layoutinit()
        self.EmailViewAutoLayout()
    }
    
    private func Layoutinit() {
        self.SendEmailLabel.text = "인증메일 발송 완료"
        self.SendEmailLabel.font = UIFont(name: "Roboto-Bold", size: 26)
        self.SendEmailLabel.tintColor = UIColor(red: 65/255, green: 61/266, blue: 61/255, alpha: 1.0)
        self.SendEmailConfirmView.clipsToBounds = false
        self.SendEmailConfirmView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.09).cgColor
        self.SendEmailConfirmView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.SendEmailConfirmView.layer.shadowRadius = 16
        self.SendEmailConfirmView.layer.shadowOpacity = 1
        
        self.SendEmailIconImage.image = UIImage(named: "Email@1x.png")
        self.SendEmailIconImage.contentMode = .scaleAspectFill
    
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.46
        self.SendEmailExampleLabel.tintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        self.SendEmailExampleLabel.textAlignment = .center
        self.SendEmailExampleLabel.text = "메일함에서 인증 확인 버튼을 눌러주세요."
        self.SendEmailExampleLabel.font = UIFont(name: "Roboto-Bold", size: 14)

        self.SendEmailConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.SendEmailConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.SendEmailConfirmButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        self.SendEmailConfirmButton.setTitle("가입하기", for: .normal)
        self.SendEmailConfirmButton.layer.cornerRadius = 8.0
        self.SendEmailConfirmButton.addTarget(self, action: #selector(UserAuchConfirmAction), for: .touchUpInside)
        
        self.SendEmailResetLabel.textAlignment = .left
        self.SendEmailResetLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        self.SendEmailResetLabel.attributedText = NSAttributedString(string: "메일을 받지 못하셨나요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)])
        
        self.SendEmailResetButton.titleLabel?.textAlignment = .left
        self.SendEmailResetButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 24)
        self.SendEmailResetButton.setAttributedTitle(NSAttributedString(string: "인증 메일 다시 받기", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)]), for: .normal)
        self.SendEmailResetButton.addTarget(self, action: #selector(SelectSendEmail), for: .touchUpInside)
        
        
        self.SendEmailQuestionButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 16)
        self.SendEmailQuestionButton.setAttributedTitle(NSAttributedString(string: "문의하기", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)]), for: .normal)
        
    }
    
    //MARK - 인증발송 화면 AutoLayout 코드3
    private func EmailViewAutoLayout() {
        self.SendEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(112)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.bottom.equalTo(self.SendEmailConfirmView.snp.top).offset(-107)
            make.width.equalTo(205)
            make.height.equalTo(35)
        }
        self.SendEmailConfirmView.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailLabel.snp.bottom).offset(107)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(40)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-39)
            make.width.equalTo(335)
            make.height.equalTo(184)
        }
        self.SendEmailIconImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailLabel.snp.bottom).offset(136)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(137)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-137)
            make.bottom.equalTo(self.SendEmailExampleLabel.snp.top).offset(-17)
            make.height.equalTo(79)
        }
        self.SendEmailExampleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailIconImage.snp.bottom).offset(17)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(71)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-69)
            make.height.equalTo(24)
        }
        self.SendEmailResetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailConfirmView.snp.bottom).offset(44)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(131)
            make.bottom.equalTo(self.SendEmailResetButton.snp.top).offset(-4)
            make.width.equalTo(153)
            make.height.equalTo(24)
        }
        self.SendEmailResetButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailResetLabel.snp.bottom).offset(4)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(103)
            make.bottom.equalTo(self.SendEmailConfirmButton.snp.top).offset(-44)
            make.width.equalTo(188)
            make.height.equalTo(22)
        }
        self.SendEmailConfirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailResetButton.snp.bottom).offset(44)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(48)
        }
        self.SendEmailQuestionButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.SendEmailConfirmButton.snp.bottom).offset(45)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(157)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-159)
            make.width.equalTo(59)
            make.height.equalTo(24)
            
        }
    }
    
    @objc private func SelectSendEmail() {
        
        let EmailParamter: Parameters = [
            "email": UserDefaults.standard.value(forKey: "service_use_email") as? String
        ]
        print(UserDefaults.standard.value(forKey: "service_use_email"))
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
        
        OAuthApi.shared.AuthCheckUserCall(CheckUser: UserDefaults.standard.value(forKey: "service_use_email") as? String ?? "") { result in
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
