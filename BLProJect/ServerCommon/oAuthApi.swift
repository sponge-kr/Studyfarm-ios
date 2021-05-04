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


struct LoginResponse: Codable {
    var code: Int?
    var message: String?
    var result: LoginResult?
}
struct LoginResult: Codable {
    var token: String
    var user: LoginUserContainer?
}
struct LoginUserContainer: Codable {
    let users_seq, age: Int?
    let email,nickname,gender,simple_introduce,profile,user_created_at,user_updated_at: String?
    let user_info_process,user_active: Bool?
    let interesting: [LoginInterestingContainer]?
    let user_city_info: [LoginCiryInfoContainer]?
    enum CodingKeys: String,CodingKey {
        case users_seq,age
        case email,nickname,gender,simple_introduce,profile,user_created_at,user_updated_at
        case user_info_process,user_active
        case interesting
        case user_city_info
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.users_seq = try? values.decode(Int.self, forKey: .users_seq)
        self.age = try? values.decode(Int.self, forKey: .age)
        self.email = try? values.decode(String.self, forKey: .email.self)
        self.nickname = try? values.decode(String.self, forKey: .nickname)
        self.gender = try? values.decode(String.self, forKey: .gender)
        self.simple_introduce = try? values.decode(String.self, forKey: .simple_introduce)
        self.profile = try? values.decode(String.self, forKey: .profile)
        self.user_created_at = try? values.decode(String.self, forKey: .user_created_at)
        self.user_updated_at = try? values.decode(String.self, forKey: .user_updated_at)
        self.user_info_process = try? values.decode(Bool.self, forKey: .user_info_process)
        self.user_active = try? values.decode(Bool.self, forKey: .user_active)
        self.interesting = try? values.decode([LoginInterestingContainer].self, forKey: .interesting)
        self.user_city_info = try? values.decode([LoginCiryInfoContainer].self, forKey: .user_city_info)
    }
}
struct LoginInterestingContainer: Codable {
    var code: Int
    var name: String
    var skill_level: Int
    var parent_code: Int
}
struct LoginCiryInfoContainer: Codable {
    var state_code: Int
    var state_name: String
    var city_code: Int
    var city_name: String
}


// MARK - 이메일 인증 버튼 데이타 모델
struct OAuthButtonDataModel {
    var code: Int = 0
    var message: String = ""
    var resultmessage: String = ""
    var resultlinks: String = ""
}

// MARK - 로그아웃 데이터 모델
struct LogoutDataModel {
    var code : Int = 0
    var message : String = ""
    var responseTime : String = ""
}

struct UserInfoDataModel {
    var code: Int = 0
    var message: String = ""
}

// MARK - 닉네임 중복확인 데이터 모델
struct NickNameOverlapDataModel {
    var code: Int = 0
    var message: String = ""
    var exist: Bool = true
}
struct EmailOverlapDataModel {
    var code: Int = 0
    var message: String = ""
    var check_result: Bool = true
}

//MARK - KakakoUser 데이터 모델
struct KakaoSingDataModel {
    var code: Int = 0
    var message: String = ""
    var users_seq: Int = 0
    var email: String = ""
    var nickname: String = ""
}
//MARK - KakaoLogin 데이터 모델
struct KakaoLoginDataModel {
    var code: Int = 0
    var message: String = ""
    var email: String = ""
    var nickname: String = ""
}


//MARK - GIDLogin 데이터 모델
struct GIDLoginDataModel {
    var code: Int = 0
    var users_seq: Int = 0
    var message: String = ""
    var email: String = ""
    var nickname: String = ""
    var gender: String = ""
}

//MARK - GIDLogin 데이터 모델
struct GIDSignDataModel {
    var code: Int = 0
    var message: String = ""
    var users_seq: Int = 0
    var nickname: String = ""
    var email: String = ""
}

//MARK - NaverLogin 데이터 모델
struct NaverLoginDataModel {
    var code: Int = 0
    var users_seq: Int = 0
    var email: String = ""
    var nickname: String = ""
    var gender: String = ""
    var profile: String = ""
}

//MARK - NaverSign 데이터 모델
struct NaverSignDataModel {
    var code: Int = 0
    var users_seq: Int = 0
    var email: String = ""
    var nickname: String = ""
    var gender: String = ""
    var profile: String = ""
}

//MARK - 회원가입 데이터
struct SignUpDataModel {
    var code: Int = 0
    var message: String = ""
    var user_seq: Int = 0
    var email: String = ""
    var nickname: String = ""
    var age: Int = 0
    var gender: String = ""
    var interesting_name: String = ""
    var interesting_skill_level: String = ""
    var born_date: String = ""
    var simple_introduce: String = ""
    var profile: String = ""
    var user_active: Bool = false
}

// MARK - 유저 체크 데이터
struct UserCheckDataModel {
    var code: Int = 0
    var message: String = ""
    var check_result: Bool = false
}

struct PasswordChageDataModel {
    var code: Int = 0
    var message: String = ""
}

struct EmailAuthCodeDataModel {
    var message: String = ""
    var code: String = ""
    var email: String = ""
    var expired_at: String = ""
}

// MARK - 로그인 Paramter
struct LoginParamter: Encodable {
    var email: String
    var password: String
}

// MARK - 회원가입 Paramter
struct SignUpParamter: Encodable {
    var email : String
    var password: String
    var nickname: String
    var service_use_agree : Bool
}

struct oAuthUserInfoParamter: Encodable {
    var gender: Int
    var birth_year: Int
    var city_info: Array<Int>
    var interesting: Array<Int>
}


// MARK - 회원가입 Email 인증 버튼 Paramter
struct OAuthButtonParamter: Encodable {
    var email: String
}

//MARK - KakakoUser 등록 Paramater
struct KakaoUserParamter: Encodable {
    var nickname: String
    var service_use_agree: Bool
}

//MARK - GIDUser 등록 Paramter
struct GIDUserParamter: Encodable {
    var nickname: String
    var service_use_agree: Bool
}
//MARK - NaverUser 등록 Paramter
struct NaverUserParamter: Encodable {
    var nickname: String
    var service_use_agree: Bool
}
// MARK - Passwrod 변경 Paramter
struct EmailParamter: Encodable{
    var password: String
}
struct EmailAuthCodeParamter: Encodable {
    var email: String
}


class OAuthApi {
    static let shared = OAuthApi()
    fileprivate let headers: HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8", "Accept": "application/hal+json"]
    fileprivate let tokenheaders: HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8", "Accept":"application/hal+json", "Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: "token"))"]
    fileprivate let kakaoTokenHeaders: HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8", "Accept":"application/hal+json","access_token": "\(KeychainWrapper.standard.string(forKey: "kakaoToken")!)"]
    fileprivate let gIdTokenHeaders: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Accept": "application/hal+json","access_token": "\(KeychainWrapper.standard.string(forKey: "googleToken"))","id_token":"\(KeychainWrapper.standard.string(forKey: "googleIDToken"))"]
    fileprivate let naverTokenHeaders : HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Accept": "application/hal+json","access_token": "\(KeychainWrapper.standard.string(forKey: "naverToken"))"]
    
    
    //MARK - 초기화
    private init(){}
    
    //MARK - DataModel Instace 초기화
    public var oAuthButtonModel = OAuthButtonDataModel()
    public var logoutModel = LogoutDataModel()
    public var signUpModel = SignUpDataModel()
    public var kakaoModel = KakaoSingDataModel()
    public var kakaoLoginModel = KakaoLoginDataModel()
    public var nickNameModel = NickNameOverlapDataModel()
    public var userCheckModel = UserCheckDataModel()
    public var gIDSignModel = GIDSignDataModel()
    public var gIDLoginModel = GIDLoginDataModel()
    public var naverLoginModel = NaverLoginDataModel()
    public var naverSignModel = NaverSignDataModel()
    public var passwordChangeModel = PasswordChageDataModel()
    public var emailModel = EmailOverlapDataModel()
    public var AuthEmailCodeModel = EmailAuthCodeDataModel()
    public var UserInfoModel = UserInfoDataModel()
    
    //MARK - oAtuh Server 로그인 요청 함수(POST)
    public func AuthLoginfetch(LoginParamter: LoginParamter, completionHandler : @escaping(LoginResponse) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/auth/login", method: .post, parameters: LoginParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    do {
                        let LoginData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let LoginInstance = try JSONDecoder().decode(LoginResponse.self, from: LoginData)
                        completionHandler(LoginInstance)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    //MARK - oAuth Server 로그아웃 요청 함수(POST)
    public func AuthLogoutCall(completionHandler : @escaping (Result<LogoutDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/auth/logout", method: .post, encoding: JSONEncoding.default, headers: tokenheaders)
            .response { response in
                switch response.result {
                case.success(let value):
                    let LogoutJson = JSON(value!)
                    self.logoutModel.code = LogoutJson["code"].intValue
                    self.logoutModel.message = LogoutJson["message"].stringValue
                    self.logoutModel.responseTime = LogoutJson["responseTime"].stringValue
                    if self.logoutModel.message == "로그인이 만료되었습니다." || self.logoutModel.code == 401{
                        KeychainWrapper.standard.removeObject(forKey: "token")
                        print("스터디팜 로그아웃 status code 값입니다 \(self.logoutModel.code)")
                        print("스터디팜 로그아웃 메세지 값입니다 \(self.logoutModel.message)")
                        completionHandler(.success(self.logoutModel))
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
        AF.request("http://3.214.168.45:3724/api/v1/user", method: .post, parameters: SignUpParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let signJson = JSON(value!)
                    self.signUpModel.code = signJson["code"].intValue
                    self.signUpModel.message = signJson["message"].stringValue
                    self.signUpModel.user_seq = signJson["result"]["users_seq"].intValue
                    self.signUpModel.email = signJson["result"]["email"].stringValue
                    self.signUpModel.nickname = signJson["result"]["nickname"].stringValue
                    self.signUpModel.gender = signJson["result"]["gender"].stringValue
                    self.signUpModel.interesting_name = signJson["result"]["interesting"]["name"].stringValue
                    self.signUpModel.interesting_skill_level = signJson["result"]["interesting"]["skill_level"].stringValue
                    self.signUpModel.born_date = signJson["result"]["born_date"].stringValue
                    self.signUpModel.user_active = signJson["result"]["user_active"].boolValue
                    print("스터디팜 회원가입 이메일 값입니다 \(self.signUpModel.email)")
                    print("스터디팜 회원가입 닉네임 값입니다 \(self.signUpModel.nickname)")
                    print("스터디팜 회원가입 나이 입니다 \(self.signUpModel.age)")
                    print("스터디팜 회원가입 성별 입니다 \(self.signUpModel.gender)")
                    print("스터디팜 회원가입 관심기술 정보 입니다 \(self.signUpModel.interesting_name)")
                    print("스터디팜 회원가입 기술 명 입니다 \(self.signUpModel.interesting_skill_level)")
                    completionHandler(.success(self.signUpModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    public func AuthUserInfo(userSeq:String, oAuthUserInfoParamter: oAuthUserInfoParamter, completionHandler: @escaping(Result<UserInfoDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/user/info/\(userSeq)", method: .post, parameters: oAuthUserInfoParamter, encoder: JSONParameterEncoder.default, headers: tokenheaders)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let UserInfoJson = JSON(value!)
                    self.UserInfoModel.code = UserInfoJson["code"].intValue
                    self.UserInfoModel.message = UserInfoJson["message"].stringValue
                    completionHandler(.success(self.UserInfoModel))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    //MARK - oAuth Server 이메일 인증 버튼 함수(POST)
    public func AuthEmailCall(oAuthButtonParamter : OAuthButtonParamter, completionHandler : @escaping(Result<OAuthButtonDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/auth/auth-email-button", method: .post, parameters: oAuthButtonParamter, encoder: JSONParameterEncoder.default, headers: headers)
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
    public func AuthCheckUserCall(checkUser : String, completionHandler : @escaping(Result<UserCheckDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/user/check-active?email=\(checkUser)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    let checkUserJson = JSON(value!)
                    self.userCheckModel.code = checkUserJson["code"].intValue
                    self.userCheckModel.message = checkUserJson["message"].stringValue
                    self.userCheckModel.check_result = checkUserJson["result"]["check_result"].boolValue
                    completionHandler(.success(self.userCheckModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    //MARK - oAuth Server 닉네임 중복 확인 함수(GET)
    public func AuthNickNameOverlap(Nickname : String, completionHandler : @escaping(Result<NickNameOverlapDataModel,Error>) -> ()){
        let Tempurl = "http://3.214.168.45:3724/api/v1/user/check-nickname?nickname=\(Nickname)"
        let url : URL = URL(string: Tempurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        AF.request(url, method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result{
                case .success(let value):
                    let nickNameJson = JSON(value!)
                    self.nickNameModel.code = nickNameJson["code"].intValue
                    self.nickNameModel.message = nickNameJson["message"].stringValue
                    self.nickNameModel.exist = nickNameJson["result"]["exist"].boolValue
                    print("스터디팜 닉네임 중복 확인 status code 값입니다 \(self.nickNameModel.code)")
                    print("스터디팜 닉네임 중복 확인 message 값입니다 \(self.nickNameModel.message)")
                    print("스터디팜 닉네임 중복 확인 exist(존재 여부) 값입니다 \(self.nickNameModel.exist)")
                    completionHandler(.success(self.nickNameModel))
                case .failure(let error):
                print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    public func AuthEmailOverlap(Email: String, completionHandler: @escaping(Result<EmailOverlapDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/user/check-email/\(Email)", method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let emailJson = JSON(value!)
                    self.emailModel.code = emailJson["code"].intValue
                    self.emailModel.message = emailJson["message"].stringValue
                    self.emailModel.check_result = emailJson["result"]["check_result"].boolValue
                    completionHandler(.success(self.emailModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    
    
    //MARK - oAuth Server KakaoLogin 함수(POST)
    public func AuthKakaoLoginCall(completionHandler : @escaping(Result<KakaoLoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/auth/login/kakao", method: .post, headers: kakaoTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let kakaoLoginJson = JSON(value!)
                    self.kakaoLoginModel.code = kakaoLoginJson["code"].intValue
                    self.kakaoLoginModel.message = kakaoLoginJson["message"].stringValue
                    self.kakaoLoginModel.email = kakaoLoginJson["result"]["user"]["email"].stringValue
                    self.kakaoLoginModel.nickname = kakaoLoginJson["result"]["user"]["nickname"].stringValue
                    print("카카오 로그인 status code 값입니다\(self.kakaoLoginModel.code)")
                    print("카카오 로그인 이메일 값입니다 \(self.kakaoLoginModel.email)")
                    print("카카오 로그인 닉네임 값입니다 \(self.kakaoLoginModel.nickname)")
                    completionHandler(.success(self.kakaoLoginModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    //MARK - oAuth Server KakaoUser 등록 함수(POST)
    public func AuthkakaoSignUp(KakaoUserParamter : KakaoUserParamter, completionHandler : @escaping(Result<KakaoSingDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/user/kakao", method: .post, parameters: KakaoUserParamter, encoder: JSONParameterEncoder.default, headers: kakaoTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let kakaoSignJson = JSON(value!)
                    self.kakaoModel.code = kakaoSignJson["code"].intValue
                    self.kakaoModel.message = kakaoSignJson["message"].stringValue
                    self.kakaoModel.users_seq = kakaoSignJson["result"]["users_seq"].intValue
                    self.kakaoModel.email = kakaoSignJson["result"]["email"].stringValue
                    self.kakaoModel.nickname = kakaoSignJson["nickname"].stringValue
                    print("카카오 등록 nickname 값입니다 \(self.kakaoModel.nickname)")
                    print("카카오 등록 email 값입니다 \(self.kakaoModel.email)")
                    print("카카오 등록 Message 값입니다 \(self.kakaoModel.message)")
                    completionHandler(.success(self.kakaoModel))
                case.failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    
    public func AuthGIDLoginCall(completionHandler : @escaping(Result<GIDLoginDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/auth/login/google", method: .post, headers: gIdTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let gIdLoginJson = JSON(value!)
                    self.gIDLoginModel.code = gIdLoginJson["code"].intValue
                    self.gIDLoginModel.message = gIdLoginJson["message"].stringValue
                    self.gIDLoginModel.email = gIdLoginJson["result"]["user"]["email"].stringValue
                    self.gIDLoginModel.nickname = gIdLoginJson["result"]["user"]["nickname"].stringValue
                    self.gIDLoginModel.users_seq = gIdLoginJson["result"]["user"]["users_seq"].intValue
                    print("구글 로그인 code 값 입니다 \(self.gIDLoginModel.code)")
                    print("구글 로그인 message 값입니다 \(self.gIDLoginModel.message)")
                    print("구글 로그인 email 값입니다 \(self.gIDLoginModel.email)")
                    print("구글 로그인 users_seq \(self.gIDLoginModel.users_seq)")
                    completionHandler(.success(self.gIDLoginModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            
            }
    }
    
    
    public func AuthGIDSignUp(GIDUserParamter : GIDUserParamter, completionHandler : @escaping(Result<GIDSignDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/user/google", method: .post, parameters: GIDUserParamter, encoder: JSONParameterEncoder.default, headers: gIdTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result{
                case.success(let value):
                    let gIdSingJson = JSON(value!)
                    self.gIDSignModel.code = gIdSingJson["code"].intValue
                    self.gIDSignModel.message = gIdSingJson["message"].stringValue
                    self.gIDSignModel.email = gIdSingJson["result"]["email"].stringValue
                    self.gIDSignModel.nickname = gIdSingJson["result"]["nickname"].stringValue
                    self.gIDSignModel.users_seq = gIdSingJson["result"]["users_seq"].intValue
                    print("구글 등록 message 값입니다 \(self.gIDSignModel.message)")
                    print("구글 등록 code 값입니다 \(self.gIDSignModel.code)")
                    print("구글 등록 nickname 값입니다\(self.gIDSignModel.nickname)")
                    print("구글 등록 email 값입니다 \(self.gIDSignModel.email)")
                    completionHandler(.success(self.gIDSignModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    
    public func AuthNaverLoginCall(completionHandler : @escaping(Result<NaverLoginDataModel,Error>) -> () ) {
        AF.request("http://3.214.168.45:3724/api/v1/auth/login/naver", method: .post, headers: naverTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let naverLoginJson = JSON(value!)
                    self.naverLoginModel.code = naverLoginJson["code"].intValue
                    self.naverLoginModel.email = naverLoginJson["result"]["user"]["email"].stringValue
                    self.naverLoginModel.nickname = naverLoginJson["result"]["user"]["nickname"].stringValue
                    self.naverLoginModel.gender = naverLoginJson["result"]["user"]["gender"].stringValue
                    self.naverLoginModel.profile = naverLoginJson["result"]["user"]["profile"].stringValue
                    print("네이버 로그인 Code 값 입니다\(self.naverLoginModel.code)")
                    completionHandler(.success(self.naverLoginModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
                
            }
    }
    public func AuthNaverSignUp(NaverUserParamter : NaverUserParamter, completionHandler : @escaping(Result<NaverSignDataModel,Error>) -> ()){
        AF.request("http://3.214.168.45:3724/api/v1/user/naver", method: .post, parameters: NaverUserParamter, encoder: JSONParameterEncoder.default, headers: naverTokenHeaders)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let naverSingJson = JSON(value!)
                    self.naverSignModel.code = naverSingJson["code"].intValue
                    self.naverSignModel.email = naverSingJson["result"]["email"].stringValue
                    self.naverSignModel.gender = naverSingJson["result"]["gender"].stringValue
                    self.naverSignModel.nickname = naverSingJson["result"]["nickname"].stringValue
                    self.naverSignModel.users_seq = naverSingJson["result"]["users_seq"].intValue
                    self.naverSignModel.profile = naverSingJson["result"]["profile"].stringValue
                    print("네이버 유저 이메일 입니다 \(self.naverSignModel.email)")
                    completionHandler(.success(self.naverSignModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    public func AuthPasswordChange(Email: String, EmailParamter: EmailParamter, completionHandler: @escaping(Result<PasswordChageDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/user/\(Email)/change-password", method: .put, parameters: EmailParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let passwordJson = JSON(value!)
                    self.passwordChangeModel.code = passwordJson["code"].intValue
                    self.passwordChangeModel.message = passwordJson["message"].stringValue
                    completionHandler(.success(self.passwordChangeModel))
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
    public func AuthEmailCode(EmailAuthCodeParamter: EmailAuthCodeParamter, completionHandler: @escaping(Result<EmailAuthCodeDataModel,Error>) -> ()) {
        AF.request("http://3.214.168.45:3724/api/v1/utils/send-mail/code", method: .post, parameters: EmailAuthCodeParamter, encoder: JSONParameterEncoder.default, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let emailCodeJson = JSON(value!)
                    self.AuthEmailCodeModel.message = emailCodeJson["message"].stringValue
                    self.AuthEmailCodeModel.code = emailCodeJson["result"]["code"].stringValue
                    self.AuthEmailCodeModel.email = emailCodeJson["result"]["code"].stringValue
                    self.AuthEmailCodeModel.expired_at = emailCodeJson["result"]["expired_at"].stringValue
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}
