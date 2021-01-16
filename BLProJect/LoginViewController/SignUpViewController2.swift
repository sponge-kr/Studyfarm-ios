//
//  SignUpViewController2.swift
//  BLProJect
//
//  Created by Yeseul Kim on 1/16/21.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import RxSwift

class SignUpViewController2: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailInfoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordInfoLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameInfoLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var activeTextField = UITextField()
    var viewModel = SignupViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.nickNameTextField.delegate = self
        
        setKeyboardNotification()
        checkTextFieldValue()
    }
    
    public func checkTextFieldValue() {
        emailTextField.rx.text.bind(to: viewModel.input.EmailSubject).disposed(by: disposedBag)
        viewModel.output.setEmailTextEnabled.drive { isVailed in self.emailInfoLabel.rx.base.textColor = isVailed
        }.disposed(by: disposedBag)
        passwordTextField.rx.text.bind(to: viewModel.input.PasswordSubject).disposed(by: disposedBag)
        viewModel.output.setPasswordTextEnabled.drive { isVailed in
            self.passwordInfoLabel.rx.base.textColor = isVailed
        }.disposed(by: disposedBag)
    }
    
    func checkNextBtnAvailable() {
        var correct: UInt8 = 0
        if emailTextField.text!.count > 0 && emailInfoLabel.textColor == UIColor.clear {
            correct += 1
        }
        if passwordTextField.text!.count > 0 && passwordInfoLabel.textColor == UIColor.clear {
            correct += 1
        }
        if nickNameTextField.text!.count > 0 {
            correct += 1
        }
        
        if correct == 3 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
        if textField == nickNameTextField {
            self.view.frame.origin.y = -160
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkNextBtnAvailable()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        return true
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        // Code
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
