//
//  APIService.swift
//  BLProJect
//
//  Created by 김도현 on 2020/09/07.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper


//MARK - 메인 스터디 최종 데이터
struct StudyResponse: Codable{
    var result : StudyResults
}

//MARK - 메인 스터디 콘텐츠 데이터
struct StudyResults: Codable {
    var content: [StudyContent]
}

// MARK: - 메인스터디 리스트 데이터
struct StudyContent: Codable {
    var study_seq: Int?
    var title: String?
    var study_leader: StudyCotainer
    var recruit_number: Int?
    var content: String?
    var category_name: String?
    var topic_name: String?
    var state_name: String?
    var city_name: String?
    var end_yn: Bool?
    var views: Int?
    var member_check_type: Int?
    var member_check_type_str: String?
    var progress_type: Int?
    var progress_type_str: String?
    var step: Int?
    var start_date: String?
    var end_date: String?
    var dateFormat: String?
    var study_in_place: StudyPlaceAttachment
    var tags: [String?]
    var is_my_study: Bool?
    var lat: Double?
    var lng: Double?
    var study_created_at_str: String?
    var study_updated_at_str: String?
}

// MARK - 메인 스터디 유저관련 리스트 데이터
struct StudyCotainer: Codable {
    var users_seq: Int?
    var email: String?
    var nickname: String?
    var simple_introduce: String?
    var profile: String?
    var user_created_at: String?
    var user_updated_at: String?
}

// MARK - 메인 스터디 장소관련 리스트 데이터
struct StudyPlaceAttachment : Codable {
    var studycafe_seq: Int?
    var name: String?
    var x_location: Double?
    var y_location: Double?
}

// MARK: - 스터디 디테일 데이터
struct StudyOneDataModel {
    var code: Int = 0
    var message: String = ""
    var study_seq: Int = 0
    var user_seq: Int = 0
    var title: String = ""
    var email: String = ""
    var name: String = ""
    var phone: String = ""
    var age: Int = 0
    var nickname: String = ""
    var state_code: Int = 0
    var state_name: String = ""
    var city_code: Int = 0
    var city_name: String = ""
    var gender: String = ""
    var interesting_name: String = ""
    var interesting_skill_level: String = ""
    var contents: String = ""
    var category_name: String = ""
    var topic_name: String = ""
}
    
// MARK: - 댓글 등록 데이터
struct CommentDataModel {
    var code: Int = 0
    var message: String = ""
}

// MARK: - 대댓글 등록 데이터
struct SubCommentDataModel {
    var code: Int = 0
    var message: String = ""
}

// MARK: - 메인 스터디 등록 Paramter
struct StudyRegisterParamter: Encodable {
    var title: String
    var study_limit: Int
    var week: String
    var week_type: Int
    var state: Int
    var city: Int
    var contents: String
    var category: String
    var topic: Int
    var color: String
    var study_day: Int
}
    
// MARK: - 댓글 등록 Paramter
struct CommentParamter: Encodable {
    var study_seq: Int
    var content: String
    var parent_reply_seq: Int
}

// MARK: - 대댓글 등록 Paramter
struct SubCommnetParamter : Encodable {
    var study_seq: Int
    var content: String
    var parent_reply_seq: Int
}

struct StudyEnrollment: Codable {
    var study_seq: Int?
    var title: String?
    var recruit_number: Int?
    var content: String?
    var category_name: String?
    var topic_name: String?
    var state_name: String?
    var city_name: String?
    var end_yn: Bool?
    var views: Int?
    var member_check_type: Int?
    var member_check_type_str: String?
    var progress_type: Int?
    var progress_type_str: String?
    var step: String?
    var start_date: String?
    var end_date: String?
    var dateFormat: String?
    var tags: [String?]
    var is_my_study: Bool?
    var study_created_at_str: String?
    var study_updated_at_str: String?
}


struct EnrollParamater : Encodable{
    var title: String
    var content: String
    var recruit_number: Int
    var state: Int
    var city: Int
    var topic: Int
    var member_check_type: Int
    var progress_type: Int
    var step: Int
    var start_date: String
    var end_date: String
    var studycafe_seq: Int
}

class ServerApi {
    static let shared = ServerApi()
    
    
    
    fileprivate let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    public let Privateheaders: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: "token"))", "Accept": "application/hal+json"]
    // MARK: - DataModel Instace 초기화
    public var StudyModel = [StudyResponse]()
    public var StudyOneModel = StudyOneDataModel()
    public var CommnetModel = CommentDataModel()
    public var SubCommentModel = SubCommentDataModel()
    
    private init() {}

    // MARK: - Server Comment 댓글 등록 함수
    public func StudyCommentCall(CommentParamter: CommentParamter, completionHandler: @escaping (Result<CommentDataModel, Error>) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/study-replies", method: .post, parameters: CommentParamter, encoder: JSONParameterEncoder.default, headers: Privateheaders)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let CommentJson = JSON(value)
                    for (_, subJson):(String, JSON) in CommentJson["result"] {
                        print("스터디팜 댓글 번호 입니다", subJson["seq"].intValue)
                        print("스터디팜 작성자 입니다 ", subJson["writer"].arrayValue)
                        print("스터디팜 부모 댓글 번호 입니다", subJson["parent_reply_seq"].intValue)
                    }
                    completionHandler(.success(self.CommnetModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    public func StudyEnrollmentCall(EnrollParamter: EnrollParamater, completionHandler : @escaping ([StudyEnrollment]) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/study", method: .post, parameters: EnrollParamter, encoder: JSONParameterEncoder.default, headers: Privateheaders)
            .responseJSON { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    do {
                        let EnrollData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let EnrollInstace = try JSONDecoder().decode(StudyEnrollment.self, from: EnrollData)
                        completionHandler([EnrollInstace])
                        print(EnrollInstace.title ,"성하였습니다")
                    } catch  {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    // MARK: - Server StudyList 조회 요청 함수
    public func StudyListCall(completionHandler :  @escaping ([StudyContent]) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/study", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    do {
                        let dataJson = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let InstanceData = try JSONDecoder().decode(StudyResponse.self, from: dataJson)
                        completionHandler(InstanceData.result.content)
                    } catch  {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    // MARK: - Server studyList 한건 조회 요청 함수
    public func StudyListOneCall(study_seq: Int, completionHandler: @escaping(Result<StudyOneDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/study\(study_seq)", method: .get, headers: Privateheaders)
            .response { response in
                switch response.result {
                case .success(let value):
                    let StudyOneJson = JSON(value)
                    self.StudyOneModel.message = StudyOneJson["message"].stringValue
                    for (_, subJson): (String, JSON) in StudyOneJson["result"] {
                        self.StudyOneModel.study_seq = StudyOneJson["study_seq"].intValue
                        self.StudyOneModel.user_seq = StudyOneJson["user_seq"].intValue
                        self.StudyOneModel.title = StudyOneJson["title"].stringValue
                        self.StudyOneModel.email = StudyOneJson["email"].stringValue
                        self.StudyOneModel.name = StudyOneJson["name"].stringValue
                        self.StudyOneModel.nickname = StudyOneJson["nickname"].stringValue
                        self.StudyOneModel.phone = StudyOneJson["phone"].stringValue
                        self.StudyOneModel.age = StudyOneJson["age"].intValue
                        self.StudyOneModel.gender = StudyOneJson["gender"].stringValue
                        self.StudyOneModel.interesting_name = StudyOneJson["interesting"]["name"].stringValue
                        self.StudyOneModel.interesting_skill_level = StudyOneJson["interesting"]["skill_level"].stringValue
                        self.StudyOneModel.contents = StudyOneJson["contents"].stringValue
                        self.StudyOneModel.category_name = StudyOneJson["category_name"].stringValue
                        self.StudyOneModel.topic_name = StudyOneJson["topic_name"].stringValue
                    }
                    print("스터디팜 스터디 한건 제목 입니다 \(self.StudyOneModel.contents) ")
                    print("스터디팜 스터디 한건 이메일 입니다 \(self.StudyOneModel.email)")
                    print("스터디팜 스터디 한건 닉네임 입니다 \(self.StudyOneModel.nickname)")
                    print("스터디팜 스터디 한건 오류 메세지 입니다 \(self.StudyOneModel.message)")
                    completionHandler(.success(self.StudyOneModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
}
