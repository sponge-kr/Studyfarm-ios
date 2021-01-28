//
//  RepliesApi.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/28.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


struct RepliesResponse: Codable {
    var result: RepliesResult
}
struct RepliesResult: Codable {
    var content: [RepliesContent]
}
struct RepliesContent: Codable {
    var seq: Int
    var writer: RepliesContainer
    var content: String
    var dateFormat: String
    var is_parent: Bool
    var is_my_reply: Bool
    var children: [RepliesChildrenCotainer]
}
struct RepliesContainer: Codable {
    var users_seq: Int
    var email: String
    var nickname: String
    var gender: String
    var age: Int
    var interesting: [RepliesInterestingContainer]
    var simple_introduce: String
    var profile: String
    var user_info_process: Bool
    var user_city_info: [RepliesCityInfoContainer]
    var user_created_at: String
    var user_updated_at: String
    var user_active: Bool
    
}

struct RepliesChildrenCotainer:Codable {
    var seq: Int
    var writer: RepliesChildreninWriterContainer
}
struct RepliesChildreninWriterContainer: Codable {
    var users_seq: Int
    var email: String
    var nickname: String
    var gender: String
    var age: Int
    var interesting: [RepliesChildreninInterestingContainer]
    var simple_introduce: String
    var profile: String
    var user_info_process: Bool
    var user_city_info: [RepliesChildreninCityInfoContainer]
    var user_created_at: String
    var user_updated_at: String
    var user_active: String
    
}
struct RepliesChildreninInterestingContainer: Codable {
    var name: String
    var skill_level: Int
    
}

struct RepliesChildreninCityInfoContainer: Codable {
    var state_code: Int
    var state_name: String
    var city_code: Int
    var city_name: String
}

struct RepliesInterestingContainer: Codable {
    var code: Int
    var name: String
    var skill_level: Int
    var parent_code: Int
}
struct RepliesCityInfoContainer: Codable {
    var state_code: Int
    var state_name: String
    var city_code: Int
    var city_name: String
}

struct ReplysParamter: Encodable {
    var size: Int?
    var page: Int?
}

class RepliesApi {
    let data = ReplysParamter(size: 10, page: 20)
    public let TestHeaders : HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8","Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkb3FuZG5mZm8xQGdtYWlsLmNvbSIsImlzcyI6InN0dWR5ZmFybSIsImlhdCI6MTU5NzgwNDkyNCwibmFtZSI6IuyViOyerOyEsTEiLCJzZXEiOjEsImV4cCI6MTg4NTgwNDkyNH0.DxhHnJZ1rUQeyD7fRPhEy3XdngmOeSXno39s8u3YP1Y","Accept":"application/hal+json"]
    public func StudyReplysCall(){
        
    }
    
    
}
