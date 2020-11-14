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

struct stateCodeData {
    var code : Int?
    var message : String?
    var stateCode : Int?
    var stateName : String?
}

struct stateCityCodeData {
    var code : Int?
    var message : String?
    var stateCityCode : Int?
    var stateCityName : String?
}


class UtilApi{
    
    static let shared = UtilApi()
    
    fileprivate let headers : HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    fileprivate let Privateheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Authorization" : "Bearer \(KeychainWrapper.standard.string(forKey: "token"))","Accept":"application/hal+json"]
    
    public var stateCodeModel = stateCodeData()
    public var stateCityCodeModel = stateCityCodeData()
    
    private init(){}
    
    public func UtilStatesCodeCall(completionHandler : @escaping (Result<stateCodeData,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/utils/states", method: .get, headers: headers)
            .response { response in
                switch response.result {
                case.success(let value):
                    let StateJson = JSON(value)
                    for (_,subJson):(String,JSON) in StateJson["result"]["content"] {
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
    
    public func UtilStateCiteCodeCall(statecode : Int,completionHandler : @escaping (Result<stateCityCodeData,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/utils/cities/\(statecode)", method: .get, headers: headers)
            .response { response in
                switch response.result {
                case.success(let value):
                    let StateCityJson = JSON(value)
                    for (_,subJson):(String,JSON) in StateCityJson["result"]["content"] {
                        self.stateCityCodeModel.stateCityCode = StateCityJson["code"].intValue
                        self.stateCityCodeModel.stateCityName = StateCityJson["name"].stringValue
                        completionHandler(.success(self.stateCityCodeModel))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
}

