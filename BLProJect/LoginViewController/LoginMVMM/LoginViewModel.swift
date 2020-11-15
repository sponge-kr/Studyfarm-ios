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
//        var setEmailTextEnabled  : Driver<String>
    }
    
    struct Dependency {
        var Email : String?
        var Password : String?
    }
    let dependency: Dependency
    var disposebag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    private let EmailTextInput = BehaviorSubject<String?>(value: nil)
    private let PasswordTextInput = BehaviorSubject<String?>(value: nil)
    
    
    init(dependency : Dependency = Dependency(Email: nil, Password: nil)) {
        self.dependency = dependency
        let EmailText = BehaviorSubject<String?>(value: nil)
        let PasswordText = BehaviorSubject<String?>(value: nil)
        let isConfirmEnabled = Observable.combineLatest(EmailText, PasswordText)
            .map(validation)
            .asDriver(onErrorJustReturn: false)
        
//        let setEmailTextEnabled =
            
        
        self.input = Input(EmailText: EmailText.asObserver(), PassWordText: PasswordText.asObserver())
        self.output = Output(isConfirmEnabled: isConfirmEnabled)
    }
}




private func validation(Email : String? , Password : String?) -> Bool {
    return Email?.isEmpty == false && Password?.isEmpty == false
}
