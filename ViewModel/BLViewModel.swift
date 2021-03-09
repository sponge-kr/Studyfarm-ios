//
//  BLViewModel.swift
//  BLProJect
//
//  Created by 김도현 on 27/07/2020.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON

struct Model {
    var contents : [String] = []
    var age : [String] = []
    var title : [String] = []
}

class BLViewModel {

    var BLModel : Model = Model()
    private let ServerURL : URL = URL(string: "http://3.214.168.45:8080/api/v1/study")!
    private let diposeBag = DisposeBag()
    let ContentUI = PublishRelay<String>()
    
    init(Model : Model) {
        self.BLModel = Model
        
    }
    
}
