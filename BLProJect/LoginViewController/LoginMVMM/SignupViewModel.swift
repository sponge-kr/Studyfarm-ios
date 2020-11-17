//
//  SignupViewModel.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/17.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire


protocol SignupViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    var deependency : Dependency {get}
    var disposebag : DisposeBag {get set}

    var input : Input {get}
    var output : Output {get}
    init(deependency : Dependency)
}


final class SignupViewModel : SignupViewModelType {
    struct Input {
        var EmailSubject : BehaviorSubject<String?>
        var PasswordSubject : BehaviorSubject<String?>
    }

    struct Output {
        var isConfirmEnabled : Driver<Bool>
        var setEmailTextEnabled : Driver<UIColor>
        var setPasswordTextEnabled : Driver<UIColor>
    }

    struct Dependency {
        var Email : String?
        var Password : String?
        var NickName : String?
    }
    let deependency: Dependency
    var disposebag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output

    private let setEmailEnabledDriver : Driver<UIColor>
    private let setPasswordEnabledDriver : Driver<UIColor>
  
    
    init(deependency : Dependency = Dependency(Email: nil, Password: nil, NickName: nil)) {
        self.deependency = deependency
        let EmailSubject = BehaviorSubject<String?>(value: nil)
        let PasswordSubject = BehaviorSubject<String?>(value: nil)
        let NickNameSubject = BehaviorSubject<String?>(value: nil)
        let isConfirmEnabled = Observable.combineLatest(EmailSubject, PasswordSubject, NickNameSubject)
            .map(isEmaptyVaildation)
            .asDriver(onErrorJustReturn: false)
        
        self.setEmailEnabledDriver = EmailSubject
            .map(EmailVaildation).asDriver(onErrorJustReturn: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0))
        self.setPasswordEnabledDriver = PasswordSubject.map(PassWordVaildation).asDriver(onErrorJustReturn: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0))
        
        
        self.input = Input(EmailSubject: EmailSubject.asObserver(), PasswordSubject: PasswordSubject.asObserver())
        self.output = Output(isConfirmEnabled: isConfirmEnabled, setEmailTextEnabled: self.setEmailEnabledDriver, setPasswordTextEnabled: self.setPasswordEnabledDriver)
    }
}

private func isEmaptyVaildation(Email : String?, Password : String?, NickName: String?) -> Bool{
    return Email?.isEmpty == false && Password?.isEmpty == false && NickName?.isEmpty == false
}

private func EmailVaildation(Email : String?) -> UIColor {
    let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let EmailVaildation = NSPredicate(format: "SELF MATCHES %@",EmailRegex)
    if EmailVaildation.evaluate(with: Email) == true || Email?.isEmpty == true{
        return UIColor.clear
    }else{
        return UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
    }
}

private func PassWordVaildation(Password : String?) -> UIColor {
    let PasswordRegex = "(?=.*[A-Za-z])(?=.*[0-9]).{8,16}"
    let PasswordVaildation = NSPredicate(format: "SELF MATCHES %@",PasswordRegex)
    if PasswordVaildation.evaluate(with: Password) == true || Password?.isEmpty == true{
        return UIColor.clear
    }else{
        return UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
    }
}

private func NickNameVaildation(NickName : String?) -> UIColor {
    let NicknameRegex = "^[a-zA-Z0-9가-힣 `~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?//s]{0,100}$"
    let NickNameVaildation = NSPredicate(format: "SELF MATCHES %@",NicknameRegex)
    if NickNameVaildation.evaluate(with: NickName) == true || NickName?.isEmpty == true {
        return UIColor.clear
    }else{
        return UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
    }
}

private func EmailisEmpty(Email : String?) -> Bool {
    return Email?.isEmpty == false
}
