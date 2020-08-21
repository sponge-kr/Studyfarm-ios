//
//  BLDetailViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/12.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import SwiftyJSON
import Alamofire



struct DetailData {
    var Detailstudyseq : [String]? = []
    var DetailstudyDay : Int? = 0
    var DetailstudyLimit : [String?] = []
    var DetailstudyCreate : String? = ""
    var DetailstudyUpdate : String? = ""
    var Detailcontents : [String?] = []
    var Detailtitle : [String?] = []
    var Detailname : [String?] = []
    var Detailstate : String? = ""
    var Detailcity : String = ""
    var Detailstudyage : [String] = []
    var Detailiscolor : [String?] = []
}



class BLDetailViewController: UIViewController {
    @IBOutlet weak var Detailtitle: UILabel!
    @IBOutlet weak var Detailname: UILabel!
    var DetailText : String = ""
    private let DiseposedBag = DisposeBag()
    private var DetailModel = DetailData()
    private let headers: HTTPHeaders = ["Accept" : "application/hal+json","Content-Type": "application/hal+json;charset=UTF-8"]
    private let ServerUrl : URL = URL(string: "http://localhost:8080/api/v1/study/1")!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Detailtitle.text = DetailText
        self.ApiServerReqeuset(url: ServerUrl, header: headers)
    }
    
    
    private func ApiServerReqeuset(url : URL , header : HTTPHeaders){
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: header, interceptor: nil, requestModifier: .none)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let Data = JSON(value)
                    for (key,jsonData):(String,JSON) in Data["results"] {
                        self.DetailModel.Detailcontents.append(jsonData["contents"].stringValue)
                        self.DetailModel.Detailname.append(jsonData["name"].stringValue)
                        self.DetailModel.Detailstudyage.append(jsonData["age"].stringValue)
                        self.DetailModel.Detailstudyseq?.append(jsonData["study_seq"].stringValue)
                        print("테스트 value값 입니다 \(jsonData["contents"].stringValue)")
                    }
                    
                case .failure(let Error):
                    print(Error.localizedDescription)
                }
                
        }
        
    }
        
}
