//
//  RepliesApi.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/28.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import Alamofire


struct RepliesResponse : Codable {
    var result : RepliesResult
}
struct RepliesResult : Codable {
    var content: [RepliesContent]
}
struct RepliesContent : Codable {
    let seq: Int?
    let dateFormat, content , reply_created_at , reply_updated_at: String?
    let is_parent, is_my_reply: Bool?
    let writer: RepliesWriterCotainer?
    let children: [RepliesChildrenContainer]?
    
    enum CodingKeys: String , CodingKey {
        case seq
        case content,dateFormat,reply_created_at,reply_updated_at
        case is_parent,is_my_reply
        case writer
        case children
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.seq = try? values.decode(Int.self, forKey: .seq)
        self.content = try? values.decode(String.self, forKey: .content)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.is_parent = try? values.decode(Bool.self, forKey: .is_parent)
        self.is_my_reply = try? values.decode(Bool.self, forKey: .is_my_reply)
        self.reply_created_at = try? values.decode(String.self, forKey: .reply_created_at)
        self.reply_updated_at = try? values.decode(String.self, forKey: .reply_updated_at)
        self.writer = try? values.decode(RepliesWriterCotainer.self, forKey: .writer)
        self.children = try? values.decode([RepliesChildrenContainer].self, forKey: .children)
    }
}

struct RepliesWriterCotainer : Codable {
    var users_seq: Int?
    var email: String?
    var nickname: String?
    var gender: String?
    var age: String?
    var interesting: [RepliesInterestingContainer]?
    var simple_introduce: String?
    var profile: String?
    var user_info_process: Bool?
    var user_city_info: [RepliesCityInfoContainer]?
    var user_created_at: String?
    var user_updated_at: String?
    var user_active: Bool?
}
struct RepliesChildrenContainer : Codable {
    var seq: Int?
    var writer : [RepliesChildrenWriterContainer]?
    var content: String?
    var dateFormat: String?
    var is_parent: Bool?
    var is_my_reply: Bool?
    var reply_created_at: String?
    var reply_updated_at: String?
}

struct RepliesInterestingContainer : Codable {
    var code: Int?
    var name: String?
    var skill_level: Int?
    var parent_code: Int?
}

struct RepliesCityInfoContainer : Codable {
    var state_code: Int?
    var state_name: String?
    var city_code: Int?
    var city_name: String?
}

struct RepliesChildrenWriterContainer : Codable {
    var users_seq : Int?
    var email : String?
    var nickname : String?
    var gender : String?
    var age : String?
    var interesting : [RepliesChildrenInterestingContainer]?
    var simple_introduce : String?
    var profile : String?
    var user_info_process : Bool?
    var user_city_info : [RepliesChildrenCityInfoContainer]?
    var user_created_at : String?
    var user_updated_at : String?
    var user_active : Bool?
}

struct RepliesChildrenInterestingContainer : Codable {
    var code : Int?
    var name : String?
    var skill_level : Int?
    var parent_code : String?
    
}

struct RepliesChildrenCityInfoContainer : Codable {
    var state_code : Int?
    var state_name : String?
    var city_code : Int?
    var city_name : String?
}
struct RepliesParams: Encodable {
    var size: Int
    var page: Int
}



//MARK- 스터디 댓글 단건 조회
struct RepliesSingleResponse : Codable{
    var result : RepliesSingleResult
}

struct RepliesSingleResult : Codable {
    let seq : Int?
    let writer : RepliesSingleWriterContainer?
    let content , dateFormat ,reply_created_at , reply_updated_at: String?
    let is_parent , is_my_reply : Bool?
    let children : [RepliesSingleChildrenContainer]?
    enum CodingKeys : String,CodingKey {
        case seq
        case writer
        case content , dateFormat , reply_created_at ,reply_updated_at
        case is_parent , is_my_reply
        case children
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.seq = try? values.decode(Int.self, forKey: .seq)
        self.writer = try? values.decode(RepliesSingleWriterContainer.self, forKey: .writer)
        self.content = try? values.decode(String.self, forKey: .content)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.reply_created_at = try? values.decode(String.self, forKey: .reply_created_at)
        self.reply_updated_at = try? values.decode(String.self, forKey: .reply_updated_at)
        self.is_parent = try? values.decode(Bool.self, forKey: .is_parent)
        self.is_my_reply = try? values.decode(Bool.self, forKey: .is_my_reply)
        self.children = try? values.decode([RepliesSingleChildrenContainer].self, forKey: .children)
    }
}

struct RepliesSingleWriterContainer : Codable{
    var users_seq : Int?
    var email : String?
    var nickname : String?
    var gender : String?
    var age : String?
    var simple_introduce : String?
    var motto : String?
    var profile : String?
}

struct RepliesSingleChildrenContainer : Codable{
    var seq : Int?
    var writer : RepliesSingleChildrenWriterContainer?
    var content : String?
    var dateFormat : String?
    var is_parent : Bool?
    var is_my_reply : Bool?
    var reply_created_at : String?
    var reply_updated_at : String?
}

struct RepliesSingleChildrenWriterContainer : Codable {
    var users_seq : Int?
    var email : String?
    var nickname : String?
    var gender : String?
    var age : String?
    var simple_introduce : String?
    var motto : String?
    var profile : String?
}


struct RepliesParameter : Encodable {
    var study_seq : Int
    var content : String
    var parent_reply_seq : Int?
}

struct RepliesChildrenParameter : Encodable  {
    var study_seq : Int
    var content : String
    var parent_reply_seq : Int
}


class RepliesApi {
    static let shared = RepliesApi()
    public let TestHeaders : HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8","Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkb3FuZG5mZm8xQGdtYWlsLmNvbSIsImlzcyI6InN0dWR5ZmFybSIsImlhdCI6MTU5NzgwNDkyNCwibmFtZSI6IuyViOyerOyEsTEiLCJzZXEiOjEsImV4cCI6MTg4NTgwNDkyNH0.DxhHnJZ1rUQeyD7fRPhEy3XdngmOeSXno39s8u3YP1Y","Accept":"application/hal+json"]
    public func StudyRepliesCall(study_seq: Int, RepliesParamter:Parameters,completionHandler: @escaping([RepliesContent]) -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study-replies/study/\(study_seq)", method: .get, parameters: RepliesParamter, encoding: URLEncoding.queryString, headers: TestHeaders)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    do {
                        let RepliesData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let RepliesInstace = try JSONDecoder().decode(RepliesResponse.self, from: RepliesData)
                        completionHandler(RepliesInstace.result.content)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    public func StudySingleRepliesCall(study_seq : Int, completionHandler : @escaping(RepliesSingleResult) -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study-replies/\(study_seq)", method: .get, encoding: JSONEncoding.default, headers: TestHeaders)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    do {
                        let RepliesSingleData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let RepliesSingleInstance = try JSONDecoder().decode(RepliesSingleResponse.self, from: RepliesSingleData)
                        completionHandler(RepliesSingleInstance.result)
                    } catch  {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    //MARK -댓글 등록(POST)
    public func studyRepliesPostFetch(RepliesParamter : RepliesParameter , completionHandler : @escaping() -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study-replies", method: .post, parameters: RepliesParamter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    //MARK - 대댓글 등록(POST)
    public func studyRepliesChildrenFetch(RepliesChildrenParameter : RepliesChildrenParameter, completionHandler : @escaping() -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study-replies", method: .post, parameters: RepliesChildrenParameter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


extension Encodable {
    func asParamters() throws -> Parameters? {
        let data = try JSONEncoder().encode(self)
        let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters
        return params
    }
}
