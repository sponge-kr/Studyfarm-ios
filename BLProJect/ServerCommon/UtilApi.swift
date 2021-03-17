//
//  UtilApi.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/08.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SwiftyJSON
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

struct ResetEamilCodeData {
    var code: String?
    var message: String?
    var email: String?
    var expired_at: String?
}

struct StudyCategoryResponse: Codable {
    var result: StudyCategoryReuslts
}

struct StudyCategoryReuslts: Codable {
    var content: [StudyContentsContainer]
}
struct StudyContentsContainer: Codable {
    let code: Int?
    let name: String?
    let children:[StudyChildrenContainer]?
    enum CodingKeys : String,CodingKey {
        case code
        case name
        case children
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try? values.decode(Int.self, forKey: .code)
        self.name = try? values.decode(String.self, forKey: .name)
        self.children = try? values.decode([StudyChildrenContainer].self, forKey: .children)
    }
}
struct StudyChildrenContainer: Codable {
    var code: Int
    var name: String
}
struct ResetEmailParamter: Encodable{
    var email: String
}


class UtilApi {
    
    static let shared = UtilApi()
    
    fileprivate let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Accept": "application/hal+json"]
    fileprivate let Privateheaders: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: "token"))", "Accept": "application/hal+json"]
    
    public var stateCodeModel = StateCodeData()
    public var stateCityCodeModel = StateCityCodeData()
    public var resetEmailModel = ResetEmailData()
    public var resetEmailCodeModel = ResetEamilCodeData()
    
    private init() {}
    
    // MARK: - 스터디 시도 리스트 조회 함수 구현(GET)
    public func UtilStatesCiteCodeCall(completionHandler: @escaping (Result<StateCodeData,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/utils/states", method: .get, headers: headers)
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
    
    public func UtilStudyCategoryCall(completionHandler: @escaping([StudyContentsContainer]) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/utils/categories", method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { (response) in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    do {
                        let CategoryData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let CateogryInstance = try JSONDecoder().decode(StudyCategoryResponse.self, from: CategoryData)
                        completionHandler(CateogryInstance.result.content)
                    } catch {
                        print(error.localizedDescription)
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    // MARK: - 이메일 전송 함수 구현(POST)
    public func UtilSendResetEmailCall(EmailParamter: Parameters, completionHandler: @escaping (Result<ResetEmailData,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/utils/send-mail", method: .post, parameters: EmailParamter, encoding: URLEncoding.queryString, headers: headers)
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
    public func UtilsendResetEmailCode(ResetEmailParamter: ResetEmailParamter, completionHandler: @escaping(Result<ResetEamilCodeData,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/utils/send-mail/code", method: .post, parameters: ResetEmailParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let resetCodeJson = JSON(value)
                    self.resetEmailCodeModel.message = resetCodeJson["message"].stringValue
                    self.resetEmailCodeModel.code = resetCodeJson["result"]["code"].stringValue
                    self.resetEmailCodeModel.email = resetCodeJson["result"]["email"].stringValue
                    self.resetEmailCodeModel.expired_at = resetCodeJson["result"]["expired_at"].stringValue
                    completionHandler(.success(self.resetEmailCodeModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
}
