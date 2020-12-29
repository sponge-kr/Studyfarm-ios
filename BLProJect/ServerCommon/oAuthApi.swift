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
    var token : String = ""
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

//MARK - 닉네임 중복확인 데이터 모델
struct NickNameDataModel {
    var code : Int = 0
    var message : String = ""
    var exist : Bool = false
}

//MARK - KakakoUser 데이터 모델
struct KakaoSingDataModel {
    var code : Int = 0
    var message : String = ""
    var users_seq : Int = 0
    var email : String = ""
    var nickname  : String = ""
}
//MARK - KakaoLogin 데이터 모델
struct KakaoLoginDataModel {
    var code : Int = 0
    var message : String = ""
    var token : String = ""
    var email : String = ""
    var nickname : String = ""
}



struct GIDLoginDataModel {
    var code : Int = 0
    var users_seq : Int = 0
    var message : String = ""
    var token : String = ""
    var email : String = ""
    var nickname : String = ""
}

//MARK - GIDLogin 데이터 모델
struct GIDSignDataModel {
    var code : Int = 0
    var message : String = ""
    var users_seq : Int = 0
    var nickname : String = ""
    var email : String = ""
}


//MARK - 회원가입 데이터
struct SignUpDataModel {
    var code : Int = 0
    var message : String = ""
    var user_seq : Int = 0
    var email : String = ""
    var nickname : String = ""
    var age : Int = 0
    var gender : String = ""
    var interesting_name : String = ""
    var interesting_skill_level : String = ""
    var born_date : String = ""
    var simple_introduce : String = ""
    var profile : String = ""
    var user_active : Bool = false
}

//MARK - 유저 체크 데이터

struct UserCheckDataModel {
    var code : Int = 0
    var message : String = ""
    var check_result : Bool = false
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
    var service_use_agree : Bool
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

//MARK - GIDUser 등록 Paramter
struct GIDUserParamter : Encodable {
    var nickname : String
    var service_use_agree : Bool
}


class oAuthApi {
    static let shared = oAuthApi()
    fileprivate let headers : HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8","Accept" : "application/hal+json"]
    fileprivate let tokenheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Accept":"application/hal+json","Authorization" : "Bearer \(KeychainWrapper.standard.string(forKey: "token"))"]
    fileprivate let Kakaotokenheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Accept":"application/hal+json","access_token" : "\(KeychainWrapper.standard.string(forKey: "Kakaotoken"))"]
    fileprivate let GIDtokenheaders : HTTPHeaders = ["Content-Type" : "application/hal+json;charset=UTF-8","Accept":"application/hal+json","access_token" : "\(KeychainWrapper.standard.string(forKey: "GIDtoken"))"]
    
    
    //MARK - 초기화
    private init(){}
    
    //MARK - DataModel Instace 초기화
    public var LoginModel = LoginDataModel()
    public var oAuthButtonModel = oAuthButtonDataModel()
    public var LogoutModel = LogoutDataModel()
    public var SignUpModel = SignUpDataModel()
    public var KakaoModel = KakaoSingDataModel()
    public var KakaoLoginModel = KakaoLoginDataModel()
    public var NickNameModel = NickNameDataModel()
    public var UserCheckModel = UserCheckDataModel()
    public var GIDSignModel = GIDSignDataModel()
    
    
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
                    print("스터디팜 로그인 토근 값입니다 \(self.LoginModel.token)")
                    print("AuthSignUpCall스터디팜 로그인 status code 값입니다 \(self.LoginModel.code)")
                    print("스터디팜 로그인 email 값입니다 \(self.LoginModel.email)")
                    print("스터디팜 로그인 nickname 값 입니다 \(self.LoginModel.nickname)")
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
                        print("스터디팜 로그아웃 status code 값입니다 \(self.LogoutModel.code)")
                        print("스터디팜 로그아웃 메세지 값입니다 \(self.LogoutModel.message)")
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
                    self.SignUpModel.code = SignJson["code"].intValue
                    self.SignUpModel.message = SignJson["message"].stringValue
                    self.SignUpModel.email = SignJson["result"]["email"].stringValue
                    self.SignUpModel.nickname = SignJson["result"]["nickname"].stringValue
                    self.SignUpModel.gender = SignJson["result"]["gender"].stringValue
                    self.SignUpModel.interesting_name = SignJson["result"]["interesting"]["name"].stringValue
                    self.SignUpModel.interesting_skill_level = SignJson["result"]["interesting"]["skill_level"].stringValue
                    self.SignUpModel.born_date = SignJson["result"]["born_date"].stringValue
                    self.SignUpModel.user_active = SignJson["result"]["user_active"].boolValue
                    print("스터디팜 회원가입 이메일 값입니다 \(self.SignUpModel.email)")
                    print("스터디팜 회원가입 닉네임 값입니다 \(self.SignUpModel.nickname)")
                    print("스터디팜 회원가입 나이 입니다 \(self.SignUpModel.age)")
                    print("스터디팜 회원가입 성별 입니다 \(self.SignUpModel.gender)")
                    print("스터디팜 회원가입 관심기술 정보 입니다 \(self.SignUpModel.interesting_name)")
                    print("스터디팜 회원가입 기술 명 입니다 \(self.SignUpModel.interesting_skill_level)")
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
                debugPrint(response)
                switch response.result {
                case.success(let value):
                    let oAuthButtonJson = JSON(value!)
                    self.oAuthButtonModel.code = oAuthButtonJson["code"].intValue
                    self.oAuthButtonModel.message = oAuthButtonJson["message"].stringValue
                    self.oAuthButtonModel.resultmessage = oAuthButtonJson["result"]["message"].stringValue
                    print("스터디팜 로그인 이메일 인증 버튼 status code 값입니다 \(self.oAuthButtonModel.code)")
                    print("스터디팜 로그인 이메일 인증 버튼 message 값입니다 \(self.oAuthButtonModel.message)")
                    print("스터디팜 로그인 인증 버튼 result messag 값입니다 \(self.oAuthButtonModel.resultmessage)")
                    completionHandler(.success(self.oAuthButtonModel))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
    }
    
    //MARK - 유저 인증 확인 함수 구현(GET)
    public func AuthCheckUserCall(CheckUser : String, completionHandler : @escaping(Result<UserCheckDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/user/check-active?email=\(CheckUser)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    let CheckUserJson = JSON(value!)
                    self.UserCheckModel.code = CheckUserJson["code"].intValue
                    self.UserCheckModel.message = CheckUserJson["message"].stringValue
                    self.UserCheckModel.check_result = CheckUserJson["result"]["check_result"].boolValue
                    completionHandler(.success(self.UserCheckModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    
    //MARK - oAuth Server 닉네임 중복 확인 함수(GET)
    public func AuthNickNameOverlap(Nickname : String, completionHandler : @escaping(Result<NickNameDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/user/check-nickname?nickname=\(Nickname)", method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    let NickNameJson = JSON(value!)
                    self.NickNameModel.code = NickNameJson["code"].intValue
                    self.NickNameModel.message = NickNameJson["message"].stringValue
                    self.NickNameModel.exist = NickNameJson["result"]["exist"].boolValue
                    print("스터디팜 닉네임 중복 확인 status code 값입니다 \(self.NickNameModel.code)")
                    print("스터디팜 닉네임 중복 확인 message 값입니다 \(self.NickNameModel.message)")
                    print("스터디팜 닉네임 중복 확인 exist(존재 여부) 값입니다 \(self.NickNameModel.exist)")
                    completionHandler(.success(self.NickNameModel))
                case .failure(let error):
                print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    
    //MARK - oAuth Server KakaoLogin 함수(POST)
    public func AuthKakaoLoginCall(completionHandler : @escaping(Result<KakaoLoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/login/kakao", method: .post, headers: Kakaotokenheaders)
            .response { response in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let KakaoLoginJson = JSON(value!)
                    self.KakaoLoginModel.code = KakaoLoginJson["code"].intValue
                    self.KakaoLoginModel.message = KakaoLoginJson["message"].stringValue
                    self.KakaoLoginModel.token = KakaoLoginJson["result"]["token"].stringValue
                    self.KakaoLoginModel.email = KakaoLoginJson["result"]["user"]["email"].stringValue
                    self.KakaoLoginModel.nickname = KakaoLoginJson["result"]["user"]["nickname"].stringValue
                    print("카카오 로그인 status code 값입니다\(self.KakaoLoginModel.code)")
                    print("카카오 로그인 토근 값입니다 \(self.KakaoLoginModel.token)")
                    print("카카오 로그인 이메일 값입니다 \(self.KakaoLoginModel.email)")
                    print("카카오 로그인 닉네임 값입니다 \(self.KakaoLoginModel.nickname)")
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
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let KakaoSignJson = JSON(value!)
                    self.KakaoModel.code = KakaoSignJson["code"].intValue
                    self.KakaoModel.message = KakaoSignJson["message"].stringValue
                    self.KakaoModel.users_seq = KakaoSignJson["result"]["users_seq"].intValue
                    self.KakaoModel.email = KakaoSignJson["result"]["email"].stringValue
                    self.KakaoModel.nickname = KakaoSignJson["nickname"].stringValue
                    print("카카오 등록 nickname 값입니다 \(self.KakaoModel.nickname)")
                    print("카카오 등록 email 값입니다 \(self.KakaoModel.email)")
                    print("카카오 등록 Message 값입니다 \(self.KakaoModel.message)")
                    completionHandler(.success(self.KakaoModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    public func AuthGIDLoginCall(completionHandler : @escaping(Result<GIDLoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/auth/login/google", method: .post, headers: GIDtokenheaders)
            .response { response in
                
            }
    }
    
    
    public func AuthGIDSignUp(GIDUserParamter : GIDUserParamter, completionHandler : @escaping(Result<GIDSignDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:8080/api/v1/user/google", method: .post, parameters: GIDUserParamter, encoder: JSONParameterEncoder.default, headers: GIDtokenheaders)
            .response { response in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let GIDSingJson = JSON(value!)
                    self.GIDSignModel.code = GIDSingJson["code"].intValue
                    self.GIDSignModel.message = GIDSingJson["message"].stringValue
                    self.GIDSignModel.email = GIDSingJson["result"]["email"].stringValue
                    self.GIDSignModel.nickname = GIDSingJson["result"]["nickname"].stringValue
                    self.GIDSignModel.users_seq = GIDSingJson["result"]["users_seq"].intValue
                    print("구글 등록 message 값입니다 \(self.GIDSignModel.message)")
                    print("구글 등록 code 값입니다 \(self.GIDSignModel.code)")
                    print("구글 등록 nickname 값입니다\(self.GIDSignModel.nickname)")
                    print("구글 등록 email 값입니다 \(self.GIDSignModel.email)")
                    completionHandler(.success(self.GIDSignModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    
}
