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
    @IBOutlet var UserAgreementView: AgreementView!
    
    lazy var agreementViewContainerView: UIView = {
        let containerView = UIView(frame: self.view.frame)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        containerView.tag = 1
        return containerView
    }()
    
    public var isCheck: Bool = false
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
    
    private func didShowAgreementView() {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds
        self.setInitAgreementViewLayout()
        window?.addSubview(self.agreementViewContainerView)
        window?.addSubview(self.UserAgreementView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.agreementViewContainerView.alpha = 0.5
            self.UserAgreementView.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.9, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
        })
    }
    
    private func setInitAgreementViewLayout() {
        let screenSize = UIScreen.main.bounds.size
        self.UserAgreementView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2)
        self.UserAgreementView.agreementTitleLabel.text = "약관 동의"
        self.UserAgreementView.agreementTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.UserAgreementView.agreementTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementTitleLabel.textAlignment = .left
        self.UserAgreementView.agreementFullButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        self.UserAgreementView.agreementFullButton.addTarget(self, action: #selector(didTapFullAgreementCheck(_:)), for: .touchUpInside)
        self.UserAgreementView.agreementFullTitleLabel.attributedText = NSAttributedString(string: "전체 동의", attributes: [NSAttributedString.Key.kern: -0.88])
        self.UserAgreementView.agreementFullTitleLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementFullTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        self.UserAgreementView.agreementFullTitleLabel.textAlignment = .left
        self.UserAgreementView.agreementLineView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.UserAgreementView.agreementServiceButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        self.UserAgreementView.agreementServiceButton.addTarget(self, action: #selector(didTapServiceAgreementCheck(_:)), for: .touchUpInside)
        self.UserAgreementView.agreementServiceLabel.attributedText = NSAttributedString(string: "스터디팜 이용약관 동의 [필수]", attributes: [NSAttributedString.Key.kern: -0.77])
        self.UserAgreementView.agreementServiceLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementServiceLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.UserAgreementView.agreementServiceDetailButton.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.kern: -0.66]), for: .normal)
        self.UserAgreementView.agreementServiceDetailButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.UserAgreementView.agreementPrivacyButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        self.UserAgreementView.agreementPrivacyButton.addTarget(self, action: #selector(didTapPrivacyAgreementCheck(_:)), for: .touchUpInside)
        self.UserAgreementView.agreementPrivacyLabel.attributedText = NSAttributedString(string: "개인정보 수집이용 동의 [필수]", attributes: [NSAttributedString.Key.kern: -0.77])
        self.UserAgreementView.agreementPrivacyLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementPrivacyLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.UserAgreementView.agreementPrivacyDetailButton.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: -0.66]), for: .normal)
        self.UserAgreementView.agreementPrivacyDetailButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.UserAgreementView.agreementPrivacyPrivateButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        self.UserAgreementView.agreementPrivacyPrivateButton.addTarget(self, action: #selector(didTapPrivacePrivateAgreementCheck(_:)), for: .touchUpInside)
        self.UserAgreementView.agreementPrivacyPrivateLabel.attributedText = NSAttributedString(string: "개인정보 수집이용 동의 [선택]", attributes: [NSAttributedString.Key.kern: -0.77])
        self.UserAgreementView.agreementPrivacyPrivateLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementPrivacyPrivateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.UserAgreementView.agreementPrivacyPrivateDetailButton.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: -0.66]), for: .normal)
        self.UserAgreementView.agreementPrivacyPrivateDetailButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.UserAgreementView.agreementMarketingButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        self.UserAgreementView.agreementMarketingButton.addTarget(self, action: #selector(didTapMarketingAgreementCheck(_:)), for: .touchUpInside)
        self.UserAgreementView.agreementMarketingLabel.attributedText = NSAttributedString(string: "마케팅 정보 수신 동의 [선택]", attributes: [NSAttributedString.Key.kern: -0.77])
        self.UserAgreementView.agreementMarketingLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.UserAgreementView.agreementMarketingLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.UserAgreementView.agreementMarketingDetailButton.setAttributedTitle(NSAttributedString(string: "자세히", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.kern: -0.66]), for: .normal)
        self.UserAgreementView.agreementMarketingDetailButton.setTitleColor(UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0), for: .normal)
        self.UserAgreementView.agreementConfirmButton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.UserAgreementView.agreementConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.UserAgreementView.agreementConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.UserAgreementView.agreementConfirmButton.layer.cornerRadius = 8
        self.UserAgreementView.agreementConfirmButton.layer.masksToBounds = true
        self.UserAgreementView.agreementConfirmButton.addTarget(self, action: #selector(didRemoveAgreementView), for: .touchUpInside)
        self.UserAgreementView.layer.cornerRadius = 8
        self.UserAgreementView.layer.masksToBounds = true
        self.UserAgreementView.backgroundColor = .white
        self.UserAgreementView.tag = 2
    }
    public func isAllSelect() {
        if isCheck == true {
            UserDefaults.standard.set(true, forKey: "oAuth_service_check")
            self.UserAgreementView.agreementFullButton.isSelected = true
            self.UserAgreementView.agreementServiceButton.isSelected = true
            self.UserAgreementView.agreementPrivacyButton.isSelected = true
            self.UserAgreementView.agreementPrivacyPrivateButton.isSelected = true
            self.UserAgreementView.agreementMarketingButton.isSelected = true
            self.UserAgreementView.agreementConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.UserAgreementView.agreementConfirmButton.isEnabled = true
        } else {
            UserDefaults.standard.set(false, forKey: "oAuth_service_check")
            self.UserAgreementView.agreementFullButton.isSelected = false
            self.UserAgreementView.agreementServiceButton.isSelected = false
            self.UserAgreementView.agreementPrivacyButton.isSelected = false
            self.UserAgreementView.agreementPrivacyPrivateButton.isSelected = false
            self.UserAgreementView.agreementMarketingButton.isSelected = false
            self.UserAgreementView.agreementConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
            self.UserAgreementView.agreementConfirmButton.isEnabled = false
        }
    }
    public func isEnabledConfrimButton() {
        if self.UserAgreementView.agreementServiceButton.isSelected == true && self.UserAgreementView.agreementPrivacyButton.isSelected == true {
            self.UserAgreementView.agreementConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            UserDefaults.standard.set(true, forKey: "oAuth_service_check")
            self.UserAgreementView.agreementConfirmButton.isEnabled = true
        } else {
            UserDefaults.standard.set(false, forKey: "oAuth_service_check")
            self.UserAgreementView.agreementConfirmButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
            self.UserAgreementView.agreementConfirmButton.isEnabled = false
        }
    }
    
    public func isCheckFullAgreement() {
        if self.UserAgreementView.agreementServiceButton.isSelected == false || self.UserAgreementView.agreementPrivacyButton.isSelected == false || self.UserAgreementView.agreementPrivacyPrivateButton.isSelected == false || self.UserAgreementView.agreementMarketingButton.isSelected == false {
            self.UserAgreementView.agreementFullButton.isSelected = false
            self.UserAgreementView.agreementFullButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        }
    }
    
    public func isCheckInit() {
        self.UserAgreementView.agreementFullButton.isSelected = false
        self.UserAgreementView.agreementServiceButton.isSelected = false
        self.UserAgreementView.agreementPrivacyButton.isSelected = false
        self.UserAgreementView.agreementPrivacyPrivateButton.isSelected = false
        self.UserAgreementView.agreementMarketingButton.isSelected = false
    }
    
    @objc
    private func didTapFullAgreementCheck(_ sender: UIButton) {
        if sender.isSelected {
            self.isCheck = false
            self.isAllSelect()
            self.UserAgreementView.agreementFullButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.UserAgreementView.agreementServiceButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.UserAgreementView.agreementPrivacyButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.UserAgreementView.agreementPrivacyPrivateButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.UserAgreementView.agreementMarketingButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        } else {
            self.isCheck = true
            self.isAllSelect()
            self.UserAgreementView.agreementFullButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
            self.UserAgreementView.agreementServiceButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
            self.UserAgreementView.agreementPrivacyButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
            self.UserAgreementView.agreementPrivacyPrivateButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
            self.UserAgreementView.agreementMarketingButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
        }
    }
    
    @objc
    private func didTapServiceAgreementCheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.isEnabledConfrimButton()
            self.isCheckFullAgreement()
            self.UserAgreementView.agreementServiceButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        } else {
            sender.isSelected = true
            self.isEnabledConfrimButton()
            self.UserAgreementView.agreementServiceButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
        }
    }
    
    @objc func didTapPrivacyAgreementCheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.isEnabledConfrimButton()
            self.isCheckFullAgreement()
            self.UserAgreementView.agreementPrivacyButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        } else {
            sender.isSelected = true
            self.isEnabledConfrimButton()
            self.UserAgreementView.agreementPrivacyButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
        }
    }
    
    @objc func didTapPrivacePrivateAgreementCheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.isCheckFullAgreement()
            self.UserAgreementView.agreementPrivacyPrivateButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        } else {
            sender.isSelected = true
            self.UserAgreementView.agreementPrivacyPrivateButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
        }
    }
    
    @objc func didTapMarketingAgreementCheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.isCheckFullAgreement()
            self.UserAgreementView.agreementMarketingButton.setImage(UIImage(named: "Rectangle.png"), for: .normal)
        } else {
            sender.isSelected = true
            self.UserAgreementView.agreementMarketingButton.setImage(UIImage(named: "selectbox.png"), for: .selected)
        }
    }
    
    @objc
    private func didTapNicknameConfirmButton() {
        OAuthApi.shared.AuthNickNameOverlap(Nickname: self.nicknameTextFiled.text!) { result in
            switch result {
            case .success(let value):
                if value.exist == false {
                    UserDefaults.standard.set(self.nicknameTextFiled.text, forKey: "oAuth_Nickname")
                    self.nicknameTextFiled.resignFirstResponder()
                    self.didShowAgreementView()
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
    private func didRemoveAgreementView() {
        let screenSize = UIScreen.main.bounds
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.agreementViewContainerView.alpha = 0
            self.UserAgreementView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.9)
            self.isCheckInit()
            let signUpParamter = SignUpParamter(email: UserDefaults.standard.string(forKey: "oAuth_Email")!, password: UserDefaults.standard.string(forKey: "oAuth_Password")!, nickname: self.nicknameTextFiled.text!, service_use_agree: UserDefaults.standard.bool(forKey: "oAuth_service_check"))
            OAuthApi.shared.AuthSignUpCall(SignUpParamter: signUpParamter) { result in
                switch result {
                case .success(let value):
                    if value.code == 200 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let EmailView = storyboard.instantiateViewController(withIdentifier: "EmailView") as? EmailAuthViewController
                        guard let EamilVC = EmailView else { return }
                        self.navigationController?.pushViewController(EamilVC, animated: true)
                    } else {
                        self.nicknameErrorTitleLabel.text = value.message
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
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
    @IBOutlet weak var agreementServiceButton: UIButton!
    @IBOutlet weak var agreementServiceLabel: UILabel!
    @IBOutlet weak var agreementServiceDetailButton: UIButton!
    @IBOutlet weak var agreementPrivacyButton: UIButton!
    @IBOutlet weak var agreementPrivacyLabel: UILabel!
    @IBOutlet weak var agreementPrivacyDetailButton: UIButton!
    @IBOutlet weak var agreementPrivacyPrivateButton: UIButton!
    @IBOutlet weak var agreementPrivacyPrivateLabel: UILabel!
    @IBOutlet weak var agreementPrivacyPrivateDetailButton: UIButton!
    @IBOutlet weak var agreementMarketingButton: UIButton!
    @IBOutlet weak var agreementMarketingLabel: UILabel!
    @IBOutlet weak var agreementMarketingDetailButton: UIButton!
    @IBOutlet weak var agreementConfirmButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
