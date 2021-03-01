//
//  FavoriteApi.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/28.
//  Copyright © 2021 김도현. All rights reserved.
//

import Alamofire

struct FavoriteResponse : Codable {
    var result : FavoriteResults
}

struct FavoriteResults : Codable {
    var count : Int
    var is_favorite : Bool
    enum CodingKeys : String,CodingKey {
        case count
        case is_favorite
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        self.is_favorite = try values.decode(Bool.self, forKey: .is_favorite)
    }
}



struct FavoriteParamter : Encodable {
    var study_seq : Int
}

struct FavoriteDismantlingParamter : Encodable {
    var study_seq : Int
}


class FavoriteApi {
    static let shared = FavoriteApi()
    public let TestHeaders : HTTPHeaders = ["Content-Type":"application/hal+json;charset=UTF-8","Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkb3FuZG5mZm8xQGdtYWlsLmNvbSIsImlzcyI6InN0dWR5ZmFybSIsImlhdCI6MTU5NzgwNDkyNCwibmFtZSI6IuyViOyerOyEsTEiLCJzZXEiOjEsImV4cCI6MTg4NTgwNDkyNH0.DxhHnJZ1rUQeyD7fRPhEy3XdngmOeSXno39s8u3YP1Y","Accept":"application/hal+json"]
    
    //MARK - 스터디 찜등록(POST)
    public func FavoriteModifedFetch(FavoriteParamter : FavoriteParamter, completionHandler : @escaping(FavoriteResults) -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study/favorite", method: .post, parameters: FavoriteParamter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    print(value)
                    do {
                        let FavoriteData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let FavoriteInstance = try JSONDecoder().decode(FavoriteResponse.self, from: FavoriteData)
                        completionHandler(FavoriteInstance.result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                
                }
            }
    }
    //MARK - 스터디 찜해체(DELETE)
    public func FavoriteDismantlingFetch(FavoriteDismantlingParamter : FavoriteDismantlingParamter, completionHandler : @escaping() -> Void) {
        AF.request("http://3.214.168.45:8080/api/v1/study/favorite", method: .delete, parameters: FavoriteDismantlingParamter, encoder: JSONParameterEncoder.default, headers: TestHeaders)
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

