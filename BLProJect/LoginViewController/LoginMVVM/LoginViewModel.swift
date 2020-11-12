//
//  LoginViewModel.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/13.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


protocol LoginViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    var dependecy : Dependency {get}
    var disposeBag : DisposeBag {get set}
    
    var input : Input {get}
    var output : Output {get}
    
    
}


class LoginViewModel: LoginViewModelType {
    struct Input {
        var emailText : BehaviorSubject<String?>
        var passwordText : BehaviorSubject<String?>
    }
    struct Output {
        var isConfirmEnabled: Driver<Bool>
    }
    struct Dependency {
        var email : String?
        var password : String?
    }
    
    let dependecy: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    private let emailText : BehaviorSubject<String?>
    private let passwordText : BehaviorSubject<String?>
    
    init(dependency : Dependency = Dependency(email: nil, password: nil)) {
        self.dependecy = dependency
        
        let emailText = BehaviorSubject<String?>(value: nil)
        let PasswordText = BehaviorSubject<String?>(value: nil)
        let isConfirmEnalbed = Observable.combineLatest(emailText, PasswordText)
            .map(vaildation)
            .asDriver(onErrorJustReturn: false)
        self.input = Input(emailText: emailText.asObserver(), passwordText: PasswordText.asObserver())
        self.output = Output(isConfirmEnabled: isConfirmEnalbed)
        
        self.emailText = emailText
        self.passwordText = PasswordText
    }
    
}

private func vaildation(email : String?, password : String?) -> Bool {
    return email?.isEmpty == false && password?.isEmpty == false
}
