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
struct StudyResponse: Codable {
    var result : StudyResults
}


//MARK - 메인 스터디 콘텐츠 데이터
struct StudyResults: Codable {
    var content: [StudyContent]
}

// MARK: - 메인스터디 리스트 데이터
struct StudyContent: Codable {
    let study_seq,recruit_number,views,member_check_type,progress_type : Int?
    let title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat,study_created_at_str,study_updated_at_str: String?
    let end_yn,is_my_study: Bool?
    let lat,lng: Double?
    let steps: [Int]?
    let tags: [String]?
    let study_leader: StudyContainer?
    let study_in_place: StudyPlaceContainer?
    enum CodingKeys: String, CodingKey {
        case study_seq,recruit_number,views,member_check_type,progress_type
        case title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat,study_created_at_str,study_updated_at_str
        case end_yn,is_my_study
        case lat,lng
        case steps
        case tags
        case study_leader
        case study_in_place
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.study_seq = try? values.decode(Int.self, forKey: .study_seq)
        self.recruit_number = try? values.decode(Int.self, forKey: .recruit_number)
        self.views = try? values.decode(Int.self, forKey: .views)
        self.member_check_type = try? values.decode(Int.self, forKey: .member_check_type)
        self.progress_type = try? values.decode(Int.self, forKey: .progress_type)
        self.title = try? values.decode(String.self, forKey: .title)
        self.content = try? values.decode(String.self, forKey: .content)
        self.category_name = try? values.decode(String.self, forKey: .category_name)
        self.topic_name = try? values.decode(String.self, forKey: .topic_name)
        self.state_name = try? values.decode(String.self, forKey: .state_name)
        self.city_name = try? values.decode(String.self, forKey: .city_name)
        self.member_check_type_str = try? values.decode(String.self, forKey: .member_check_type_str)
        self.progress_type_str = try? values.decode(String.self, forKey: .progress_type_str)
        self.start_date = try? values.decode(String.self, forKey: .start_date)
        self.end_date = try? values.decode(String.self, forKey: .end_date)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.study_created_at_str = try? values.decode(String.self, forKey: .study_created_at_str)
        self.study_updated_at_str = try? values.decode(String.self, forKey: .study_updated_at_str)
        self.end_yn = try? values.decode(Bool.self, forKey: .end_yn)
        self.is_my_study = try? values.decode(Bool.self, forKey: .is_my_study)
        self.lat = try? values.decode(Double.self, forKey: .lat)
        self.lng = try? values.decode(Double.self, forKey: .lng)
        self.steps = try? values.decode([Int].self, forKey: .steps)
        self.tags = try? values.decode([String].self, forKey: .tags)
        self.study_leader = try? values.decode(StudyContainer.self, forKey: .study_leader)
        self.study_in_place = try? values.decode(StudyPlaceContainer.self, forKey: .study_in_place)
    }
}

// MARK - 메인 스터디 유저관련 리스트 데이터
struct StudyContainer: Codable {
    var users_seq: Int?
    var email: String?
    var nickname: String?
    var simple_introduce: String?
    var profile: String?
    var user_created_at: String?
    var user_updated_at: String?
}

// MARK - 메인 스터디 장소관련 리스트 데이터
struct StudyPlaceContainer : Codable {
    var studycafe_seq: Int?
    var name: String?
    var x_location: Double?
    var y_location: Double?
}


struct StudyDetailResponse : Codable {
    var code: Int
    var message: String
    var result: StudyDetailResults
}

struct StudyDetailResults: Codable {
    let study_seq, recruit_number, views, member_check_type, progress_type, step: Int?
    let title, content, category_name, topic_name, state_name, city_name, member_check_type_str, progress_type_str, start_date, end_date, dateFormat, study_created_at_str, study_updated_at_str: String?
    let end_yn, is_my_study: Bool?
    let tags: [String]?
    let study_leader: StudyDetailContainer?
    let study_in_place: StudyDetailPlaceContainer?
    let member_results: [StudyDetailMemberResultsContainer]?

    enum CodingKeys: String, CodingKey {
        case study_seq, recruit_number, views, member_check_type, progress_type, step
        case title, content, category_name, topic_name, state_name, city_name, member_check_type_str, progress_type_str
        case start_date, end_date, dateFormat, study_created_at_str, study_updated_at_str
        case end_yn, is_my_study
        case tags
        case study_leader
        case study_in_place
        case member_results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.study_seq = try? values.decode(Int.self, forKey: .study_seq)
        self.recruit_number = try? values.decode(Int.self, forKey: .recruit_number)
        self.views = try? values.decode(Int.self, forKey: .views)
        self.member_check_type = try? values.decode(Int.self, forKey: .member_check_type)
        self.progress_type = try? values.decode(Int.self, forKey: .progress_type)
        self.step = try? values.decode(Int.self, forKey: .step)
        self.title = try? values.decode(String.self, forKey: .title)
        self.content = try? values.decode(String.self, forKey: .content)
        self.category_name = try? values.decode(String.self, forKey: .category_name)
        self.topic_name = try? values.decode(String.self, forKey: .topic_name)
        self.state_name = try? values.decode(String.self, forKey: .state_name)
        self.city_name = try? values.decode(String.self, forKey: .city_name)
        self.member_check_type_str = try? values.decode(String.self, forKey: .member_check_type_str)
        self.progress_type_str = try? values.decode(String.self, forKey: .progress_type_str)
        self.start_date = try? values.decode(String.self, forKey: .start_date)
        self.end_date = try? values.decode(String.self, forKey: .end_date)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.study_created_at_str = try? values.decode(String.self, forKey: .study_created_at_str)
        self.study_updated_at_str = try? values.decode(String.self, forKey: .study_updated_at_str)
        self.end_yn = try? values.decode(Bool.self, forKey: .end_yn)
        self.is_my_study = try? values.decode(Bool.self, forKey: .is_my_study)
        self.tags = try? values.decode([String].self, forKey: .tags)
        self.study_leader = try? values.decode(StudyDetailContainer.self, forKey: .study_leader)
        self.study_in_place = try? values.decode(StudyDetailPlaceContainer.self, forKey: .study_in_place)
        self.member_results = try? values.decode([StudyDetailMemberResultsContainer].self, forKey: .member_results)
    }
}

struct StudyDetailContainer: Codable {
    var users_seq: Int
    var email: String
    var nickname: String
    var gender: String
    var age: Int
    var interesting: [StudyDetailInterestingContainer]
    var simple_introduce: String
    var profile: String
    var user_info_process: Bool
    var user_city_info: [StudyDetailCityInfoContainer]
    var user_created_at: String
    var user_updated_at: String
    var user_active: Bool
}

struct StudyDetailInterestingContainer: Codable {
    var code: Int
    var name: String
    var skill_level: Int
    var parent_code: Int
}

struct StudyDetailCityInfoContainer: Codable {
    var state_code: Int
    var state_name: String
    var city_code: Int
    var city_name: String
}
struct StudyDetailPlaceContainer: Codable {
    var studycafe_seq: Int
    var name: String
    var phone: String
    var description: String
    var full_address: String
    var road_address: String
    var x_location: String
    var y_location: String
    var city_code: Int
    var city_name: String
    var bizhour: [StudyDetailbizhourContainer]
    var thumbnail: String
    var images: [String]
    var menu_info: [StudyDetailMenuInfoContainer]
    var options: [String]
    
    
}
struct StudyDetailbizhourContainer: Codable {
    var type: String
    var startTime: String
    var endTime: String
    var description: String
    var isDayOff: Bool
}
struct StudyDetailMenuInfoContainer: Codable {
    var name: String
    var price: String
    var isRecommended: Bool
    var change: Bool
}

struct StudyDetailMemberResultsContainer: Codable {
    var created_at: String
    var updated_at: String
    var actived_at: String
    var is_study_leader: Bool
    var status: Int
    var users_seq: Int
    var nickname: String
    var email: String
    var gender: String
    var age: Int
    var profile: String
    var simple_introduce: String
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

struct StudyEnrollmentResponse: Codable {
    var result : StudyEnrollment
}


struct StudyEnrollment: Codable {
    let study_seq,recruit_number,views,member_check_type,progress_type: Int?
    let title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat,study_created_at_str,study_updated_at_str: String?
    let end_yn,is_my_study: Bool?
    let steps: [Int]?
    let tags: [String]?
    enum CodingKeys: String,CodingKey {
        case study_seq,recruit_number,views,member_check_type,progress_type
        case title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat,study_created_at_str,study_updated_at_str
        case end_yn,is_my_study
        case steps
        case tags
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.study_seq = try? values.decode(Int.self, forKey: .study_seq)
        self.recruit_number = try? values.decode(Int.self, forKey: .recruit_number)
        self.views = try? values.decode(Int.self, forKey: .views)
        self.member_check_type = try? values.decode(Int.self, forKey: .member_check_type)
        self.progress_type = try? values.decode(Int.self, forKey: .progress_type)
        self.title = try? values.decode(String.self, forKey: .title)
        self.content = try? values.decode(String.self, forKey: .content)
        self.category_name = try? values.decode(String.self, forKey: .category_name)
        self.topic_name = try? values.decode(String.self, forKey: .topic_name)
        self.state_name = try? values.decode(String.self, forKey: .state_name)
        self.city_name = try? values.decode(String.self, forKey: .city_name)
        self.member_check_type_str = try? values.decode(String.self, forKey: .member_check_type_str)
        self.progress_type_str = try? values.decode(String.self, forKey: .progress_type_str)
        self.start_date = try? values.decode(String.self, forKey: .start_date)
        self.end_date = try? values.decode(String.self, forKey: .end_date)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.study_created_at_str = try? values.decode(String.self, forKey: .study_created_at_str)
        self.study_updated_at_str = try? values.decode(String.self, forKey: .study_updated_at_str)
        self.end_yn = try? values.decode(Bool.self, forKey: .end_yn)
        self.is_my_study = try? values.decode(Bool.self, forKey: .is_my_study)
        self.steps = try? values.decode([Int].self, forKey: .steps)
        self.tags = try? values.decode([String].self, forKey: .tags)
    }
}

struct StudyModifiedResponse: Codable {
    var result : StudyModifiedResult
}

struct StudyModifiedResult: Codable {
    let study_seq,recruit_number,views,member_check_type,progress_type: Int?
    let title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat: String?
    let end_yn: Bool?
    let steps: [Int]?
    let study_leader: ModifiedContainer?
    let study_in_place: [ModifiedStudyPlaceContainer]?
    enum CodingKeys: String,CodingKey {
        case study_seq,recruit_number,views,member_check_type,progress_type
        case title,content,category_name,topic_name,state_name,city_name,member_check_type_str,progress_type_str,start_date,end_date,dateFormat
        case end_yn
        case steps
        case study_leader
        case study_in_place
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.study_seq = try? values.decode(Int.self, forKey: .study_seq)
        self.recruit_number = try? values.decode(Int.self, forKey: .recruit_number)
        self.views = try? values.decode(Int.self, forKey: .views)
        self.member_check_type = try? values.decode(Int.self, forKey: .member_check_type)
        self.progress_type = try? values.decode(Int.self, forKey: .progress_type)
        self.title = try? values.decode(String.self, forKey: .title)
        self.content = try? values.decode(String.self, forKey: .content)
        self.category_name = try? values.decode(String.self, forKey: .category_name)
        self.topic_name = try? values.decode(String.self, forKey: .topic_name)
        self.state_name = try? values.decode(String.self, forKey: .state_name)
        self.city_name = try? values.decode(String.self, forKey: .city_name)
        self.member_check_type_str = try? values.decode(String.self, forKey: .member_check_type_str)
        self.progress_type_str = try? values.decode(String.self, forKey: .progress_type_str)
        self.start_date = try? values.decode(String.self, forKey: .start_date)
        self.end_date = try? values.decode(String.self, forKey: .end_date)
        self.dateFormat = try? values.decode(String.self, forKey: .dateFormat)
        self.end_yn = try? values.decode(Bool.self, forKey: .end_yn)
        self.steps = try? values.decode([Int].self, forKey: .steps)
        self.study_leader = try? values.decode(ModifiedContainer.self, forKey: .study_leader)
        self.study_in_place = try? values.decode([ModifiedStudyPlaceContainer].self, forKey: .study_in_place)
        
    }
}
struct ModifiedContainer: Codable {
    var users_seq: Int
    var email: String
    var nickname: String
    var gender: String
    var age: Int
    var interesting: [ModifiedInterestingContainer]
    var simple_introduce: String
    var profile: String
    var user_info_process: Bool
    var user_city_info : [ModifiedUserInfoContainer]
    var user_created_at: String
    var user_updated_at: String
    var user_active: Bool
    var member: [ModifiedStudyMembersContainer]
    var tags: [String]
    var is_my_study: Bool
    var study_created_at_str: String
    var study_updated_at_str: String

}
struct ModifiedInterestingContainer: Codable {
    var code: Int
    var name: String
    var skill_level: Int
    var parent_code: Int
}
struct ModifiedUserInfoContainer: Codable {
    var state_code: Int
    var state_name: String
    var city_code: Int
    var city_name: String
}
struct ModifiedStudyPlaceContainer: Codable {
    var studycafe_seq: Int
    var name: String
    var phone: String
    var description: String
    var full_address: String
    var road_address: String
    var x_location: Double
    var y_location: Double
    var city_code: Int
    var city_name: String
    var bizhour: [ModifiedStudybizhourContainer]
    var thumbnail: String
    var images: [String]
    var menu_info: [ModifiedStudyMenuInfoContainer]
    var options: [String]
}
struct ModifiedStudybizhourContainer: Codable {
    var type: String
    var startTime: String
    var endTime: String
    var description: String
    var isDayOff: Bool
}
struct ModifiedStudyMenuInfoContainer: Codable {
    var name: String
    var price: String
    var isRecommended: Bool
    var change: Bool
}
struct ModifiedStudyMembersContainer: Codable {
    var created_at: String
    var updated_at: String
    var actived_at: String
    var is_study_leader: Bool
    var status: Int
    var users_seq: Int
    var nickname: String
    var email: String
    var gender: String
    var age: Int
    var profile: String
    var simple_introduce: String
}

struct StudyMyInfoResponse: Codable {
    var reuslt: [StudyMyInfoReuslt]
    struct StudyMyInfoReuslt: Codable {
        var content: [StduyMyContent]
        struct StduyMyContent: Codable{
            var study_seq: Int
            var title: String
            var study_leader: [StduyMyContainer]
            var recruit_number: Int
            var content: String
            var category_name: String
            var topic_name: String
            var state_name: String
            var city_name: String
            var end_yn: Bool
            var views: Int
            var member_check_type: Int
            var member_check_type_str: String
            var progress_type: Int
            var progress_type_str: String
            var step: Int
            var start_date: String
            var end_date: String
            var dateFormat: String
            var tags: [String]
            var is_my_study: Bool
            var study_created_at_str: String
            var study_updated_at_str: String
            struct StduyMyContainer: Codable {
                var users_seq: Int
                var email: String
                var nickname: String
                var gender: String
                var age: Int
                var interesting: [StudyMyInterestingContainer]
                var simple_introduce: String
                var profile: String
                var user_info_process: String
                var user_city_info: [StudyMyUserCityInfoContainer]
                var user_created_at: String
                var user_updated_at: String
                var user_active: Bool
                struct StudyMyInterestingContainer: Codable{
                    var code: Int
                    var name: String
                    var skill_level: Int
                    var parent_code: Int
                }
                struct StudyMyUserCityInfoContainer: Codable{
                    var state_code: Int
                    var state_name: String
                    var city_code: Int
                    var city_name: String
                }
            }
        }
    }

}

struct EnrollParamater : Encodable {
    var title: String
    var content: String
    var recruit_number: Int
    var state: Int
    var city: Int
    var topic: Int
    var member_check_type: Int
    var progress_type: Int
    var steps: [Int]?
    var start_date: String
    var end_date: String
    var studycafe_seq: Int
}

struct ModifiedParamater : Encodable {
    var title: String
    var content: String
    var recruit_number: Int
    var state: Int
    var city: Int
    var topic: Int
    var member_check_type: Int
    var progress_type: Int
    var steps: [Int]?
    var start_date: String
    var end_date: String
    var studycafe_seq: Int
}

class ServerApi {
    static let shared = ServerApi()
    
    
    
    fileprivate let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    public let Privateheaders: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: "token"))", "Accept": "application/hal+json"]
    public let TestHeaders : HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8","Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkb3FuZG5mZm8xQGdtYWlsLmNvbSIsImlzcyI6InN0dWR5ZmFybSIsImlhdCI6MTU5NzgwNDkyNCwibmFtZSI6IuyViOyerOyEsTEiLCJzZXEiOjEsImV4cCI6MTg4NTgwNDkyNH0.DxhHnJZ1rUQeyD7fRPhEy3XdngmOeSXno39s8u3YP1Y","Accept":"application/hal+json"]

    // MARK: - DataModel Instace 초기화
    public var CommnetModel = CommentDataModel()
    
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
    
    public func StudyModifiedCall(ModifiedParamter: ModifiedParamater, completionHandler: @escaping(StudyModifiedResult) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/study/1", method: .put, parameters: ModifiedParamter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
        .responseJSON {  response in
            debugPrint(response)
            switch response.result{
            case .success(let value):
                do {
                    let ModifiedData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let ModifiedInstance = try JSONDecoder().decode(StudyModifiedResponse.self, from: ModifiedData)
                    completionHandler(ModifiedInstance.result)
                }catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    public func StudyEnrollmentCall(EnrollParamter: EnrollParamater, completionHandler: @escaping (StudyEnrollment) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/study", method: .post, parameters: EnrollParamter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
            .responseJSON { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    do {
                        let EnrollData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let EnrollInstace = try JSONDecoder().decode(StudyEnrollmentResponse.self, from: EnrollData)
                        completionHandler(EnrollInstace.result)
                    } catch  {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    public func StudyMyListCall(completionHandler: @escaping ([StudyMyInfoResponse.StudyMyInfoReuslt.StduyMyContent]) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/study/my", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: TestHeaders)
        .responseJSON { response in
            debugPrint(response)
            switch response.result{
            case .success(let value):
                do {
                    let MyStudyData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let MyStudyInstance = try JSONDecoder().decode(StudyMyInfoResponse.StudyMyInfoReuslt.self, from: MyStudyData)
                    completionHandler(MyStudyInstance.content)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
    
    // MARK: - Server StudyList 조회 요청 함수
    public func StudyListCall(completionHandler:  @escaping ([StudyContent]) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/study", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { response in
//                debugPrint(response)
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
    
    public func StudyDetailCall(study_seq: Int, completionHandler: @escaping (StudyDetailResults) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/study/\(study_seq)", method: .get, headers: TestHeaders)
        .responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                do {
                    let StudyDetailData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let StudyDetailInstance = try JSONDecoder().decode(StudyDetailResponse.self, from: StudyDetailData)
                    completionHandler(StudyDetailInstance.result)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
