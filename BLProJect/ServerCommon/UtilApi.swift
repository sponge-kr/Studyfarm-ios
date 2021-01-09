//
//  UtilApi.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/08.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SwiftyJSON
import Combine
import Alamofire
import SwiftKeychainWrapper

struct StateCodeData {
    var code: Int?
    var message: String?
    var stateCode: Int?
    var stateName: String?
}

struct StateCityCodeData {
    var code: Int?
    var message: String?
    var stateCityCode: Int?
    var stateCityName: String?
}

struct ResetEmailData {
    var code: Int?
    var message: String?
}

struct StudyCategoryData {
    var code: Int?
    var message: String?
    var contentCode: Int?  // 카테고리 코드
    var contentName: String? // 카테고리 명
    var childrenCode: Int?  // 주제 코드
    var childrenName: String? // 주제 명
}

class UtilApi {
    
    static let shared = UtilApi()
    
    fileprivate let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Accept": "application/hal+json"]
    fileprivate let Privateheaders: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: "token"))", "Accept": "application/hal+json"]
    
    public var stateCodeModel = StateCodeData()
    public var stateCityCodeModel = StateCityCodeData()
    public var resetEmailModel = ResetEmailData()
    public var studyCategoryModel = StudyCategoryData()
    
    private init() {
        
    }
    
    // MARK: - 스터디 시도 리스트 조회 함수 구현(GET)
    public func UtilStatesCiteCodeCall(completionHandler: @escaping (Result<StateCodeData,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/utils/states", method: .get, headers: headers)
            .response { response in
                switch response.result {
                case.success(let value):
                    let StateJson = JSON(value)
                    for (_, subJson):(String,JSON) in StateJson["result"]["content"] {
                        self.stateCodeModel.stateCode = StateJson["code"].intValue
                        self.stateCodeModel.stateName = StateJson["name"].stringValue
                        completionHandler(.success(self.stateCodeModel))
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    // MARK: - 스터디 리스트 조회 함수 구현(GET)
    public func UtilStudyCategoryCall(completionHandler: @escaping(Result<StudyCategoryData, Error>) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/utils/categories", method: .get, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let CategoryJson = JSON(value)
                    self.studyCategoryModel.code = CategoryJson["code"].intValue
                    self.studyCategoryModel.message = CategoryJson["message"].stringValue
                    for (_, subJson):(String, JSON) in CategoryJson["result"]["content"] {
                        self.studyCategoryModel.contentCode = CategoryJson["code"].intValue
                        self.studyCategoryModel.contentName = CategoryJson["name"].stringValue
                        self.studyCategoryModel.childrenCode = CategoryJson["children"]["code"].intValue
                        self.studyCategoryModel.childrenName = CategoryJson["children"]["name"].stringValue
                        completionHandler(.success(self.studyCategoryModel))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    // MARK: - 이메일 전송 함수 구현(POST)
    public func UtilSendResetEmailCall(EmailParamter: Parameters, completionHandler: @escaping (Result<ResetEmailData,Error>) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/utils/send-mail", method: .post, parameters: EmailParamter, encoding: URLEncoding.queryString, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case.success(let value):
                    let ResetEmailJson = JSON(value)
                    for (_, subJson):(String, JSON) in ResetEmailJson {
                        self.resetEmailModel.code = ResetEmailJson["code"].intValue
                        self.resetEmailModel.message = ResetEmailJson["message"].stringValue
                        completionHandler(.success(self.resetEmailModel))
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
}
