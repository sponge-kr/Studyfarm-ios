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
    
    
    struct StudyList {
        var studyseq: [Int]? = []
        var studyDay: Int? = 0
        var studyLimit: [Int?] = []
        var studyCreate: [String?] = []
        var studyUpdate: String? = ""
        var contents: String? = ""
        var title: [String?] = []
        var name: [String?] = []
        var state: String? = ""
        var city: String = ""
        var studycolor: [String?] = []
    }
    
    struct LoginList {
        var code: Int = 0
        var message: String = ""
        var token: String = ""
    }
    
    struct OAuthList {
        var code: Int = 0
        var message: String = ""
        var token: String = ""
        var email: String = ""
    }
    struct LogoutList {
        var code: Int = 0
        var message: String = ""
        var responseTime: String = ""
    }
    
    struct SignList {
        var code: Int = 0
        var message: String = ""
    }
    
    // MARK: - 로그인 Paramter
    struct LoginParamter: Encodable {
        var email: String
        var password: String
    }

    // MARK: - 회원가입 Paramter
    struct SignParamter: Encodable {
        var email: String
        var password: String
        var nickname: String
    }
    
    // MARK: - 회원가입 Email 인증 Paramter
    struct OAuthParamter: Encodable {
        var email: String
    }
   
    class APIService {
        static let shared = APIService()
        fileprivate let headers: HTTPHeaders = ["Content-Type": "application/hal+json;charset=UTF-8", "Accept" : "application/hal+json"]
        
        // MARK: - ServerData
        public var StudyData = StudyList()
        public var LoginData = LoginList()
        public var oAuthData = oAuthList()
        public var LogoutData = LogoutList()
        public var SingData = SignList()
        
        init() {}
        
        // MARK: - LoginServer 요청 함수
        public func RequestLoginServer(LoginParamter: LoginParamter, completionHandler: @escaping (Result<LoginList, Error>)) {
            AF.request("http://3.214.168.45:8080/api/v1/auth/login", method: .post, parameters: LoginParamter, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        do {
                            let LoginJson = JSON(value!)
                            self.LoginData.code = LoginJson["code"].intValue
                            self.LoginData.message = LoginJson["message"].stringValue
                            self.LoginData.token = LoginJson["result"]["token"].stringValue
                            print("토근 값입니다  token :", self.LoginData.token)
                            print("파싱 status code 입니다", self.LoginData.code)
                            completionHandler(.success(self.LoginData))
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completionHandler(.failure(error))
                        
                    }
            }
            
        }
        
        // MARK: - LogoutServer 요청 함수
        public func RequestLogoutServer(headers: HTTPHeaders, completionHandler: @escaping (Result<LogoutList, Error>)) {
            AF.request("http://3.214.168.45:8080/api/v1/auth/logout", method: .post, encoding: JSONEncoding.default, headers: headers)
                .response { response in
                    switch response.result {
                    case.success(let value):
                        do {
                            let LogoutJson = JSON(value!)
                            self.LogoutData.code = LogoutJson["code"].intValue
                            self.LogoutData.message = LogoutJson["message"].stringValue
                            self.LogoutData.responseTime = LogoutJson["responseTime"].stringValue
                            if self.LogoutData.message == "로그인이 만료되었습니다." || self.LogoutData.code == 401 {
                                KeychainWrapper.standard.removeObject(forKey: "token")
                                
                            }
                                 
                            print("Logout Code 값:  : \(self.LogoutData.code)")
                            print("Logout message 값 : \(self.LogoutData.message)")
                            print("Logout resposeTime : \(self.LogoutData.responseTime)")
                            completionHandler(.success(self.LogoutData))
                            
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completionHandler(.failure(error))
                    }
            }
        }
        
        // MARK: - SignServer 요청 함수
        public func RequestSignServer(SignParamter: SignParamter, completionHandler: @escaping (Result<SignList, Error>)) {
            AF.request("http://3.214.168.45:8080/api/v1/user", method: .post, parameters: SignParamter, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        let SingJson = JSON(value!)
                        for (_, subJson):(String, JSON) in SingJson["results"] {
                            print("스터디팜 회원가입 이메일 입니다 :", subJson["email"].stringValue)
                            print("스터디팜 회원가입 닉네임 입니다 :", subJson["nickname"].stringValue)
                        }
                        completionHandler(.success(self.SingData))
                    case.failure(let error):
                        print(error.localizedDescription)
                        completionHandler(.failure(error))
                    }
            }
        }
        
        // MARK: - StudyList 조회 요청 함수
        public func RequestStudyListGet(completionHandler: @escaping ()) {
            AF.request("http://3.214.168.45:8080/api/v1/study", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers)
                .responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        let StudyJson = JSON(value)
                        for (_, subJson):(String, JSON) in StudyJson["result"] {
                            self.StudyData.title.append(subJson["title"].stringValue)
                            self.StudyData.name.append(subJson["name"].stringValue)
                            self.StudyData.studycolor.append(subJson["color"].stringValue)
                            self.StudyData.studyCreate.append(subJson["study_created_at_str"].stringValue)
                            self.StudyData.studyLimit.append(subJson["study_limit"].intValue)
                            self.StudyData.studyseq?.append(subJson["study_seq"].intValue)
                        }
                        completionHandler()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
        }
        
        // MARK: - ProfileUpload 요청 함수
        public func UploadProfileImage() {
            
        }
        
        // MARK: - Email인증 코드 전송 함수
        public func oAuthEmailCodePost(oAuthParamter: oAuthParamter, completionHandler : @escaping ()) {
            AF.request("http://3.214.168.45:8080/api/v1/auth/auth-email", method: .post, parameters: oAuthParamter, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        let oAuthJson = JSON(value)
                        self.oAuthData.code = oAuthJson["code"].intValue
                        self.oAuthData.message = oAuthJson["message"].stringValue
                        self.oAuthData.token = oAuthJson["result"]["token"].stringValue
                        self.oAuthData.email = oAuthJson["result"]["email"].stringValue
                        print("이메일 인증 코드 데이터 입니다 :", self.oAuthData.token)
                        print("이메일 인증 코드 발송 이메일 입니다 : ", self.oAuthData.email)
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
            }
            
        }
    }
