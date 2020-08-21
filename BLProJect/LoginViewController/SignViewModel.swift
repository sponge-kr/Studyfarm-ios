//
//  SignViewModel.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/17.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class SignViewModel {
    var EmailText : PublishSubject<String> = PublishSubject<String>()
    var PasswordText : PublishSubject<String> = PublishSubject<String>()
    var NickNameText : PublishSubject<String> = PublishSubject<String>()
    
    
    func isVaild() -> Observable<Bool> {
        return Observable.combineLatest(EmailText.asObservable(), PasswordText.asObservable()).map{ UserEamil, UserPassword in
            
            return UserEamil.count > 10 && UserPassword.count > 4
        }
    }
    
    
    
}
