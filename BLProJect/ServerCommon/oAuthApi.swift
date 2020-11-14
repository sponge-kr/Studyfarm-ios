//
//  UserApi.swift
//  BLProJect
//
//  Created by 김도현 on 2020/11/02.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper


//MARK - 로그인 데이터 모델
struct LoginDataModel {
    var code : Int?
    var message : String?
    var token : String?
    var user_seq : Int?
    var email : String?
    var name : String?
    var nickname : String?
    var phone : String?
    var age : Int?
    var state_code : Int?
    var state_name : String?
    var city_code : Int?
    var city_name : String?
    var gender : String?
    var interesting_name : String?
    var interesting_skill_level : String?
    var born_date : String?
    var profile : String?
}

//MARK - 이메일 인증 버튼 데이타 모델
struct oAuthButtonDataModel {
    var code : Int = 0
    var message : String = ""
    var resultmessage : String = ""
    var resultlinks : String = ""
}

//MARK - 로그아웃 데이터 모델
struct LogoutDataModel {
    var code : Int = 0
    var message : String = ""
    var responseTime : String = ""
}

//MARK - KakakoUser 데이터 모델
struct KakaoSingDataModel {
    var code : Int = 0
    var message : String = ""
    var email : String = ""
    var nickname  : String = ""
}

struct KakaoLoginDataModel {
    var code : Int = 0
    var message : String = ""
    var token : String = ""
    var email : String = ""
    var nickname : String = ""
}


//MARK - 회원가입 데이터
struct SignUpDataModel {
    var code : Int = 0
    var message : String = ""
    var user_seq : Int = 0
    var email : String = ""
    var name : String = ""
    var nickname : String = ""
    var phone : String = ""
    var age : Int = 0
    var gender : String = ""
    var interesting_name : String = ""
    var interesting_skill_level : String = ""
    var born_date : String = ""
    var simple_introduce : String = ""
    var profile : String = ""
    var user_active : Bool = false
}

//MARK - 로그인 Paramter
struct LoginParamter : Encodable {
    var email : String
    var password : String
}

//MARK - 회원가입 Paramter
struct SignUpParamter : Encodable {
    var email : String
    var password : String
    var nickname : String
    var name : String
    var city_info : Array<Int>
    var gender : Int
    var born_date : String
    var interesting : [[String : String]]
    var service_use_agree : Bool
    var profile : String?
    var phone : String
    var age : Int
    var simple_introduce : String
    var study_purpose : String
    var service_way : String
}

//MARK - 회원가입 Email 인증 버튼 Paramter
struct oAuthButtonParamter : Encodable {
    var email : String
}


//MARK - KakakoUser 등록 Paramater
struct KakaoUserParamter : Encodable {
    var nickname : String
    var service_use_agree : Bool
}


class oAuthApi {
    static let shared = oAuthApi()
    fileprivate let headers : HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    fileprivate let tokenheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Authorization" : "Bearer \(KeychainWrapper.standard.string(forKey: "token"))","Accept":"application/hal+json"]
    fileprivate let Kakaotokenheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Accept":"application/hal+json","access_token" : "\(KeychainWrapper.standard.string(forKey: "Kakaotoken")!)"]
    
    
    //MARK - 초기화
    private init(){}
    
    //MARK - DataModel Instace 초기화
    public var LoginModel = LoginDataModel()
    public var oAuthButtonModel = oAuthButtonDataModel()
    public var LogoutModel = LogoutDataModel()
    public var SignUpModel = SignUpDataModel()
    public var KakaoModel = KakaoSingDataModel()
    public var KakaoLoginModel = KakaoLoginDataModel()
    
    //MARK - oAtuh Server 로그인 요청 함수(POST)
    public func AuthLoginCall(LoginParamter : LoginParamter, completionHandler : @escaping (Result<LoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/login", method: .post, parameters: LoginParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let LoginJson = JSON(value!)
                    self.LoginModel.code = LoginJson["code"].intValue
                    self.LoginModel.message = LoginJson["message"].stringValue
                    self.LoginModel.token = LoginJson["result"]["token"].stringValue
                    for (_,LoginSubJson):(String,JSON) in LoginJson["result"]["user"] {
                        self.LoginModel.email = LoginSubJson["email"].stringValue
                        self.LoginModel.name = LoginSubJson["name"].stringValue
                        self.LoginModel.nickname = LoginSubJson["nickname"].stringValue
                        self.LoginModel.age = LoginSubJson["age"].intValue
                        self.LoginModel.gender = LoginSubJson["gender"].stringValue
                        self.LoginModel.state_code = LoginSubJson["user_city_info"]["state_code"].intValue
                        self.LoginModel.state_name = LoginSubJson["user_city_info"]["state_name"].stringValue
                        self.LoginModel.city_code = LoginSubJson["user_city_info"]["city_code"].intValue
                        self.LoginModel.city_name = LoginSubJson["user_city_info"]["city_name"].stringValue
                        self.LoginModel.interesting_name = LoginSubJson["interesting"]["name"].stringValue
                        self.LoginModel.interesting_skill_level = LoginSubJson["interesting"]["skill_level"].stringValue
                        self.LoginModel.born_date = LoginSubJson["born_date"].stringValue
                        self.LoginModel.profile = LoginSubJson["profile"].stringValue
                    }
                    print("토근 값입니다  token : \(self.LoginModel.token)")
                    print("파싱 status code 입니다 \(self.LoginModel.code)")
                    completionHandler(.success(self.LoginModel))
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                    
                }
            }
    }
    
    //MARK - oAuth Server 로그아웃 요청 함수(POST)
    public func AuthLogoutCall(completionHandler : @escaping (Result<LogoutDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/logout", method: .post, encoding: JSONEncoding.default, headers: tokenheaders)
            .response { response in
                switch response.result {
                case.success(let value):
                    let LogoutJson = JSON(value!)
                    self.LogoutModel.code = LogoutJson["code"].intValue
                    self.LogoutModel.message = LogoutJson["message"].stringValue
                    self.LogoutModel.responseTime = LogoutJson["responseTime"].stringValue
                    if self.LogoutModel.message == "로그인이 만료되었습니다." || self.LogoutModel.code == 401{
                        KeychainWrapper.standard.removeObject(forKey: "token")
                        print("Logout Code 값:  : \(self.LogoutModel.code)")
                        print("Logout message 값 : \(self.LogoutModel.message)")
                        print("Logout resposeTime : \(self.LogoutModel.responseTime)")
                        completionHandler(.success(self.LogoutModel))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    //MARK - oAtuh Server 프로필 업로드 요청 함수
    public func AuthProfileUploadCall(){
        
    }
    
    
    
    //MARK - oAuth Server 유저 등록 요청 함수(POST)
    public func AuthSignUpCall(SignUpParamter : SignUpParamter, completionHandler : @escaping (Result<SignUpDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:8080/api/v1/user", method: .post, parameters: SignUpParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let SignJson = JSON(value!)
                    for (_,subJson):(String,JSON) in SignJson["results"] {
                        self.SignUpModel.email = subJson["email"].stringValue
                        self.SignUpModel.nickname = subJson["nickname"].stringValue
                        self.SignUpModel.name = subJson["name"].stringValue
                        self.SignUpModel.phone = subJson["phone"].stringValue
                        self.SignUpModel.gender = subJson["gender"].stringValue
                        self.SignUpModel.interesting_name = subJson["interesting"]["name"].stringValue
                        self.SignUpModel.interesting_skill_level = subJson["interesting"]["skill_level"].stringValue
                        self.SignUpModel.born_date = subJson["born_date"].stringValue
                        self.SignUpModel.user_active = subJson["user_active"].boolValue
                        print("스터디팜 회원가입 이메일 입니다 :  \(self.SignUpModel.email)")
                        print("스터디팜 회원가입 닉네임 입니다 : \(self.SignUpModel.nickname)")
                        print("스터디팜 회원가입 이름 입니다 :  \(self.SignUpModel.name)")
                        print("스터디팜 회원가입 핸드폰 번호 입니다 : \(self.SignUpModel.phone)")
                        print("스터디팜 회원가입 나이 입니다 : \(self.SignUpModel.age)")
                        print("스터디팜 회원가입 성별 입니다 : \(self.SignUpModel.gender)")
                        print("스터디팜 회원가입 관심기술 정보 입니다 : \(self.SignUpModel.interesting_name)")
                        print("스터디팜 회원가입 기술 명 입니다 : \(self.SignUpModel.interesting_skill_level)")
                    }
                    completionHandler(.success(self.SignUpModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    //MARK - oAuth Server 이메일 인증 버튼 함수(POST)
    public func AuthEmailCall(oAuthButtonParamter : oAuthButtonParamter, completionHandler : @escaping(Result<oAuthButtonDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/auth-email-button", method: .post, parameters: oAuthButtonParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                switch response.result {
                case.success(let value):
                    let oAuthButtonJson = JSON(value!)
                    self.oAuthButtonModel.code = oAuthButtonJson["code"].intValue
                    self.oAuthButtonModel.message = oAuthButtonJson["message"].stringValue
                    self.oAuthButtonModel.resultmessage = oAuthButtonJson["result"]["message"].stringValue
                    print("이메일 인증 버튼 status code 입니다 : \(self.oAuthButtonModel.code)")
                    print("이메일 인증 버튼 message 입니다 : \(self.oAuthButtonModel.message)")
                    print("이메일 인증 버튼 result message 입니다 : \(self.oAuthButtonModel.resultmessage)")
                    completionHandler(.success(self.oAuthButtonModel))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
    
    
    //MARK - oAuth Server KakaoLogin 등록 함수(POST)
    public func AuthKakaoLoginCall(completionHandler : @escaping(Result<KakaoLoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/login/kakao", method: .post, headers: Kakaotokenheaders)
            .response { response in
                switch response.result{
                case.success(let value):
                let KakaoLoginJson = JSON(value!)
                    self.KakaoLoginModel.code = KakaoLoginJson["code"].intValue
                    self.KakaoLoginModel.message = KakaoLoginJson["message"].stringValue
                    for (_, subJson):(String,JSON) in KakaoLoginJson["result"] {
                        self.KakaoLoginModel.token = KakaoLoginJson["token"].stringValue
                        self.KakaoLoginModel.email = KakaoLoginJson["user"]["email"].stringValue
                        self.KakaoLoginModel.nickname = KakaoLoginJson["user"]["nickname"].stringValue
                    }
                    completionHandler(.success(self.KakaoLoginModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    //MARK - oAuth Server KakaoUser 등록 함수(POST)
    public func AuthkakaoSignUp(KakaoUserParamter : KakaoUserParamter, completionHandler : @escaping(Result<KakaoSingDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/user/kakao", method: .post, parameters: KakaoUserParamter, encoder: JSONParameterEncoder.default, headers: Kakaotokenheaders)
            .response { response in
                switch response.result{
                case.success(let value):
                    let KakaoSignJson = JSON(value!)
                    self.KakaoModel.code = KakaoSignJson["code"].intValue
                    self.KakaoModel.message = KakaoSignJson["message"].stringValue
                    for (_,subJson):(String,JSON) in KakaoSignJson["result"] {
                        self.KakaoModel.email = subJson["email"].stringValue
                        self.KakaoModel.nickname = subJson["nickname"].stringValue
                        print("kakao email 값입니다 \(self.KakaoModel.email)")
                        print("kakao Message 값입니다 \(self.KakaoModel.message)")
                        print("kakao nickname값입니다 \(self.KakaoModel.nickname)")
                    }
                    completionHandler(.success(self.KakaoModel))
                case.failure(let error):
                print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    
    
}
