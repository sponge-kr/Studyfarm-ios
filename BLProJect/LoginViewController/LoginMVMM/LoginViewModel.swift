//
//  LoginViewModel.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/14.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


protocol LoginViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    
    var dependency : Dependency { get }
    var disposebag : DisposeBag {get set}
    
    var input : Input {get}
    var output : Output {get}
    
    init(dependency : Dependency)
}


final class LoginViewModel : LoginViewModelType{
    
    struct Input {
        var EmailText : BehaviorSubject<String?>
        var PassWordText : BehaviorSubject<String?>
    }
    
    struct  Output {
        var isConfirmEnabled : Driver<Bool>
        var setEmailTextEnabled  : Driver<CGColor>
        var setPasswordTextEnabled : Driver<CGColor>
        var isEmptyEmailText : Driver<Bool>
        
    }
    
    struct Dependency {
        var Email : String?
        var Password : String?
    }
    let dependency: Dependency
    var disposebag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    private let EmailTextDriver : Driver<CGColor>
    private let PasswordTextDriver : Driver<CGColor>
    private let isEmpryTextDrvier : Driver<Bool>
    
    init(dependency : Dependency = Dependency(Email: nil, Password: nil)) {
        self.dependency = dependency
        let EmailText = BehaviorSubject<String?>(value: nil)
        let PasswordText = BehaviorSubject<String?>(value: nil)
        let isConfirmEnabled = Observable.combineLatest(EmailText, PasswordText)
            .map(validation)
            .asDriver(onErrorJustReturn: false)
        
        self.EmailTextDriver = EmailText.map(AddEmailVaildation).asDriver(onErrorJustReturn: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor)
        
        self.PasswordTextDriver = PasswordText.map(AddPassWordVaildation).asDriver(onErrorJustReturn: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor)
        
        self.isEmpryTextDrvier = EmailText.map(isEmptyEmail).asDriver(onErrorJustReturn: false)
        
        
        self.input = Input(EmailText: EmailText.asObserver(), PassWordText: PasswordText.asObserver())
        self.output = Output(isConfirmEnabled: isConfirmEnabled, setEmailTextEnabled: self.EmailTextDriver, setPasswordTextEnabled: self.PasswordTextDriver, isEmptyEmailText: self.isEmpryTextDrvier)
    }
}


private func AddEmailVaildation(Email : String?) -> CGColor {
    let EmailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let EmailVaildation = NSPredicate(format: "SELF MATCHES %@",EmailRegex)
    if EmailVaildation.evaluate(with: Email) == true {
        return UIColor.cyan.cgColor
    }else{
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
    }
}

private func AddPassWordVaildation(Password : String?) -> CGColor {
    let PasswordRegex = "(?=.*[A-Za-z])(?=.*[0-9]).{8,16}"
    let PasswordVaildation = NSPredicate(format: "SELF MATCHES %@",PasswordRegex)
    if PasswordVaildation.evaluate(with: Password) == true {
        return UIColor.cyan.cgColor
    }else{
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
    }
}

private func isEmptyEmail(Email : String?) -> Bool{
    if Email?.isEmpty == true {
        return true
    }else{
        return false
    }
}

private func validation(Email : String? , Password : String?) -> Bool {
    return Email?.isEmpty == false && Password?.isEmpty == false
}
