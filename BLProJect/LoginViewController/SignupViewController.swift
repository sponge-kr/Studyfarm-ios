//
//  SignupViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/15.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit



class SignupViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    @IBOutlet weak var signEmailtextfield: UITextField!
    @IBOutlet weak var signPasswordtextfield: UITextField!
    @IBOutlet weak var signConforbutton: UIButton!
    @IBOutlet weak var signSubtitlelabel: UILabel!
    @IBOutlet weak var signSubheadlabel: UILabel!
    @IBOutlet weak var signEmaillabel: UILabel!
    @IBOutlet weak var signEmailSubLabel: UILabel!
    @IBOutlet weak var signPasswordlabel: UILabel!
    @IBOutlet weak var signEmailerrorlabel: UILabel!
    @IBOutlet weak var signPassworderrorlabel: UILabel!
    @IBOutlet var AgreementView: UIView!
    @IBOutlet weak var signEmailerrorLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signScrollView: UIScrollView!
    
    lazy var signPasswordRightView: UIView = {
        let signRightView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        signRightView.addSubview(self.singPasswordRightButton)
        signRightView.tag = 0
        return signRightView
    }()
    
    lazy var singPasswordRightButton: UIButton = {
        let signRightButton = UIButton(type: .custom)
        signRightButton.frame = CGRect(x: 0, y: 10, width: 24, height: 12)
        signRightButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
        signRightButton.addTarget(self, action: #selector(ispasswordSecurity(sender:)), for: .touchUpInside)
        return signRightButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetSingViewLayout()
        self.signConforbutton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        self.signEmailtextfield.delegate = self
        self.signPasswordtextfield.delegate = self
        self.signScrollView.delegate = self
        self.signScrollView.isScrollEnabled = false
        self.addKeyboardNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK - 초기 회원가입 Layout 구현
    public func SetSingViewLayout(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let Navigationimage = UIImage(named: "Navigation.png")
        self.navigationController?.navigationBar.backIndicatorImage = Navigationimage
        
        self.signEmailerrorlabel.text = "올바른 형식의 이메일을 입력하세요."
        self.signEmailerrorlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.signEmailerrorlabel.textAlignment = .left
        self.signEmailerrorlabel.numberOfLines = 1
        self.signEmailerrorlabel.textColor = UIColor.clear

        self.signPassworderrorlabel.text = "비밀번호가 너무 짧습니다."
        self.signPassworderrorlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.signPassworderrorlabel.textAlignment = .left
        self.signPassworderrorlabel.numberOfLines = 1
        self.signPassworderrorlabel.textColor = UIColor.clear
        
        self.signSubtitlelabel.text = "이메일로 시작하기"
        self.signSubtitlelabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        self.signSubtitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signSubtitlelabel.textAlignment = .left
        self.signSubtitlelabel.numberOfLines = 1
        
        self.signSubheadlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signSubheadlabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.signSubheadlabel.attributedText = NSAttributedString(string: "입력하신 메일로 본인인증을 위한 인증번호가 전송됩니다.\n비밀번호는 1번만 입력하니 정확히 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.77])
        self.signSubheadlabel.textAlignment = .left
        self.signSubheadlabel.numberOfLines = 0
        
        self.signEmaillabel.text = "이메일"
        self.signEmaillabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signEmaillabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signEmaillabel.textAlignment = .left
        self.signEmailSubLabel.attributedText = NSAttributedString(string: "메일 인증을 받을 수 있는 주소를 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.66])
        self.signEmailSubLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.signEmailSubLabel.textAlignment = .left
        self.signEmailSubLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        
        self.signPasswordlabel.text = "비밀번호"
        self.signPasswordlabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.signPasswordlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.signPasswordlabel.textAlignment = .left
        
        self.signEmailtextfield.attributedPlaceholder = NSAttributedString(string: "이메일 주소 입력", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.signEmailtextfield.layer.borderWidth = 1.0
        self.signEmailtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signEmailtextfield.leftViewMode = .always
        self.signEmailtextfield.textContentType = .emailAddress
        self.signEmailtextfield.layer.cornerRadius = 6
        self.signEmailtextfield.layer.masksToBounds = true
        
        self.signPasswordtextfield.attributedPlaceholder = NSAttributedString(string: "영문, 숫자 포함 6~16자로 조합해주세요.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)])
        self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.signPasswordtextfield.layer.borderWidth = 1.0
        self.signPasswordtextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 0))
        self.signPasswordtextfield.rightView = self.signPasswordRightView
        self.signPasswordtextfield.rightViewMode = .always
        self.signPasswordtextfield.leftViewMode = .always
        self.signPasswordtextfield.textContentType = .password
        self.signPasswordtextfield.isSecureTextEntry = true
        self.signPasswordtextfield.layer.cornerRadius = 6
        self.signPasswordtextfield.layer.masksToBounds = true
        
        self.signConforbutton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        self.signConforbutton.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        self.signConforbutton.isEnabled = false
        self.signConforbutton.layer.cornerRadius = 8
    }
    
    public func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    private func ispasswordSecurity( sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.singPasswordRightButton.setImage(UIImage(named: "secureeye.png"), for: .normal)
            self.signPasswordtextfield.rightView = self.signPasswordRightView
            self.signPasswordtextfield.rightViewMode = .always
            self.signPasswordtextfield.isSecureTextEntry = true
            self.signPasswordtextfield.setNeedsLayout()
        } else {
            sender.isSelected = true
            self.singPasswordRightButton.setImage(UIImage(named: "eye.png"), for: .selected)
            self.signPasswordtextfield.rightView = self.signPasswordRightView
            self.signPasswordtextfield.rightViewMode = .always
            self.signPasswordtextfield.isSecureTextEntry = false
            self.signPasswordtextfield.setNeedsLayout()
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification : Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.signScrollView.isScrollEnabled = true
            let keyboardShowFrame = keyboardFrame.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.signConforbutton.frame.origin.y - self.signConforbutton.frame.size.height - keyboardShowFrame.height - self.view.safeAreaInsets.bottom, right: 0.0)
            signScrollView.contentInset = contentInsets
            signScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification : Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.signScrollView.isScrollEnabled = false
            let keyboardHideFrame = keyboardFrame.cgRectValue
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self.signConforbutton.frame.origin.y + self.signConforbutton.frame.size.height + keyboardHideFrame.height, right: 0.0)
            self.signScrollView.contentOffset.y = 0
            self.signScrollView.contentInset = contentInsets
            self.signScrollView.scrollIndicatorInsets = contentInsets
        }
        
    }
    @objc
    private func didTapConfirmButton() {
        self.signEmailtextfield.resignFirstResponder()
        self.signPasswordtextfield.resignFirstResponder()
        OAuthApi.shared.AuthEmailOverlap(Email: self.signEmailtextfield.text!) { result in
            switch result {
            case .success(let value):
                if value.check_result == false {
                    UserDefaults.standard.set(self.signEmailtextfield.text, forKey: "oAuth_Email")
                    UserDefaults.standard.set(self.signPasswordtextfield.text, forKey: "oAuth_Password")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let NickView = storyboard.instantiateViewController(withIdentifier: "NicknameView") as? NicknameSignupViewController
                    guard let NickVC = NickView else { return }
                    self.navigationController?.pushViewController(NickVC, animated: true)
                } else {
                    UIView.animate(withDuration: 0.2) {
                        self.signEmaillabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                        self.signEmailerrorlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                        self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                        self.signEmailerrorLabelTopConstraint.constant = 44
                        self.signEmaillabel.setNeedsLayout()
                        self.signEmailtextfield.setNeedsLayout()
                        self.signPasswordlabel.setNeedsLayout()
                        self.signEmailerrorlabel.setNeedsLayout()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.signPasswordtextfield.resignFirstResponder()
        self.signEmailtextfield.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let EmailVaildation = NSPredicate(format: "SELF MATCHES %@",EmailRegex)
        if EmailVaildation.evaluate(with: self.signEmailtextfield.text) == false {
            UIView.animate(withDuration: 0.2) {
                self.signEmaillabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signEmailerrorlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                self.signEmailerrorLabelTopConstraint.constant = 44
                self.signEmaillabel.setNeedsLayout()
                self.signEmailtextfield.setNeedsLayout()
                self.signPasswordlabel.setNeedsLayout()
                self.signEmailerrorlabel.setNeedsLayout()
            }
            
        } else {
            UIView.animate(withDuration: 0.2) {
                self.signEmaillabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
                self.signEmailerrorlabel.textColor = UIColor.clear
                self.signEmailtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
                self.signEmailerrorLabelTopConstraint.constant = 24
                self.signEmaillabel.setNeedsLayout()
                self.signEmailtextfield.setNeedsLayout()
                self.signPasswordlabel.setNeedsLayout()
                self.signEmailerrorlabel.setNeedsLayout()
            }
        }
        if self.signPasswordtextfield.text!.count < 5 {
            UIView.animate(withDuration: 0.2) {
                self.signPasswordlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signPassworderrorlabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
                self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
                self.signPasswordlabel.setNeedsLayout()
                self.signPasswordtextfield.setNeedsLayout()
                self.signPassworderrorlabel.setNeedsLayout()
            }
        } else {
            self.signPasswordlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.signPassworderrorlabel.textColor = UIColor.clear
            self.signPasswordtextfield.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
            self.signPasswordlabel.setNeedsLayout()
            self.signPasswordtextfield.setNeedsLayout()
            self.signPassworderrorlabel.setNeedsLayout()
        }
        
        if EmailVaildation.evaluate(with: self.signEmailtextfield.text) == true && self.signPasswordtextfield.text!.count >= 6 {
            self.signConforbutton.isEnabled = true
            self.signConforbutton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        }
 
        return true
    }
    
    
}

extension UIButton {
    
    func customEnableLayout() {
        if isSelected == true {
            self.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.layer.cornerRadius = 4
            let Checkimage = UIImage(named: "check@1x.png")
            self.layer.borderColor = UIColor.white.cgColor
            self.setImage(Checkimage, for: .normal)
            self.setTitle("", for: .normal)
        }else{
            self.backgroundColor = UIColor.white
            self.setBackgroundImage(#imageLiteral(resourceName: "unCheckGray-1"), for: .normal)
        }
    }
    
    func checkboxAnimation(closure : @escaping () -> Void) {
        guard let image = self.imageView else {return}
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear) {
            self.setTitle("", for: .selected)
        } completion: { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                closure()
            }, completion: nil)
            
        }
    }
}
