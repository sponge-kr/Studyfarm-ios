# Sponge 스터디가 Fun해지는 지금
![Icon-App-76x76@2x](https://user-images.githubusercontent.com/23008224/116726180-e6ed0a80-aa1d-11eb-9aa0-f6ddd5046112.png)


Sponge App



## 기술 스택



### Design Patterns



![다운로드](https://user-images.githubusercontent.com/23008224/116726720-a17d0d00-aa1e-11eb-8f37-80320860fcda.png)

### - MVC(Modle-View-Controller) with Singleton pattern


### Server Networking



![다운로드 (1)](https://user-images.githubusercontent.com/23008224/116727694-db024800-aa1f-11eb-847e-7c59afb29e23.png)

![다운로드 (2)](https://user-images.githubusercontent.com/23008224/116727798-ff5e2480-aa1f-11eb-9bf2-a547d3fa8d36.png)

![7774181](https://user-images.githubusercontent.com/23008224/116728821-5d3f3c00-aa21-11eb-8166-02368869b322.png)




##### Sponge 앱은 Swift에서 지원하는 기존 Framework 기반인 Codable을 사용하여 JsonParsing을 하려 Refactoring 중이며<br>추후 SwiftyJson의 라이브러리를 pod uninstall 계획입니다.



##### SNS 로그인(Naver,Kakao,Google) 및 Sponge 자체 이메일 인증 서버 통신



## 로그인 화면



![KakaoTalk_Photo_2021-05-01-02-15-13](https://user-images.githubusercontent.com/23008224/116730295-50234c80-aa23-11eb-8973-7f8a28a5a78d.jpeg)


## 회원가입 화면 


![KakaoTalk_Photo_2021-05-01-02-20-39](https://user-images.githubusercontent.com/23008224/116730897-fff8ba00-aa23-11eb-95f2-196b0fe040c2.jpeg)


## 지역선택 화면 



![KakaoTalk_Photo_2021-05-01-02-24-44](https://user-images.githubusercontent.com/23008224/116731325-82817980-aa24-11eb-9a8a-9f6d85bf5e85.jpeg)     ![KakaoTalk_Photo_2021-05-01-02-24-36](https://user-images.githubusercontent.com/23008224/116731387-96c57680-aa24-11eb-8d1e-9b9448d3dc35.jpeg)




#### Multiple CollectionView를 이용하여 시도 및 시군구 UI 구현
#### 비활성화 지역은 AreaEmptyCollectionViewCell을 호출하여 지역 신청 Button을 통하여 API 호출


<pre>
<code>

// MARK - 시도 코드 API 호출
public func getApiCityCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStatesCiteCodeCall { result in
                
                self.cityChildrenData = result[self.selectItem].children!
                self.areaCityCollectionView.reloadData()
            }
        }
    }
    
// MARK - 시군구 코드 API 호출     
    public func getApiAreaCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStatesCiteCodeCall { result in
                self.CityData = result
                self.areaSearchCollectionView.reloadData()
            }
        }
    }
    </code>
</pre>






