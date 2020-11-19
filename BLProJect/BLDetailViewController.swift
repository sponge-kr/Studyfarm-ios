//
//  BLDetailViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/12.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import SwiftyJSON
import Alamofire







class BLDetailViewController: UIViewController {
    @IBOutlet weak var Detailtitle: UILabel!
    @IBOutlet weak var Detailname: UILabel!
    var Index : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("스터디팜 디테일 index 데스트 입니다 \(self.Index)")
        ServerApi.shared.StudyListOneCall(study_seq: Index!) { reulst in
            switch reulst{
            case .success(let value):
                self.initLayout()
                self.Detailname.text = value.nickname
                self.Detailtitle.text = value.contents
            case .failure(let error):
                print(error.localizedDescription)
            }
             
        }
    }
    public func initLayout(){
        self.Detailtitle.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 1.0))
        self.Detailtitle.textColor = UIColor.black
        self.Detailtitle.textAlignment = .center
        self.Detailtitle.frame = CGRect(x: self.Detailtitle.frame.origin.x, y: self.Detailtitle.frame.origin.y, width: self.Detailtitle.frame.size.width, height: self.Detailtitle.frame.size.height)
        
        self.Detailname.font = UIFont.systemFont(ofSize: 16)
        self.Detailname.textColor = UIColor(red: 87/255, green: 88/255, blue: 80/255, alpha: 1.0)
        self.Detailname.textAlignment = .left
        self.Detailname.frame = CGRect(x: self.Detailname.frame.origin.x, y: self.Detailname.frame.origin.y, width: self.Detailname.frame.size.width, height: self.Detailname.frame.size.height)
    }
    
        
}
