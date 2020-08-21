//
//  ViewController.swift
//  BLProJect
//
//  Created by 김도현 on 19/07/2020.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import SnapKit
import Hero
import Alamofire
import SwiftyJSON


struct MainData {
    var studyseq : [String]? = []
    var studyDay : Int? = 0
    var studyLimit : [String?] = []
    var studyCreate : [String?] = []
    var studyUpdate : String? = ""
    var contents : String? = ""
    var title : [String?] = []
    var name : [String?] = []
    var state : String? = ""
    var city : String = ""
    var iscolor : [String?] = []
    
}




class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    private let URL = "http://3.214.168.45:8080/api/v1/study"
    private let headers: HTTPHeaders = ["Accept" : "application/hal+json","Content-Type": "application/hal+json;charset=UTF-8"]
    var MainBLData = MainData()
    @IBOutlet weak var BLSubjectView: UIView!
    @IBOutlet weak var LeftNaviButton: UIButton!
    @IBOutlet weak var BLSubject: UILabel!
    @IBOutlet weak var BLMainCollectionView: UICollectionView!
    @IBOutlet weak var BLSignButton: UIButton!
    
    
    lazy var HeaderView: BLMainCollectionViewHeader = {
        let HeaderView = self.BLMainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BLHeaderCell", for: IndexPath(item: 0, section: 0)) as? BLMainCollectionViewHeader
        HeaderView?.backgroundColor = UIColor.white
        return HeaderView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ServerReqeust(URL: URL, headers: headers)
        // Do any additional setup after loading the view.
        self.LayoutSetUP()
        self.BLMainCollectionView.delegate = self
        self.BLMainCollectionView.dataSource = self
        self.BLMainCollectionView.register(UINib(nibName: "BLMainCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BLHeaderCell")
        self.BLMainCollectionView.register(UINib(nibName: "BLMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BLMainCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    
    private func LayoutSetUP(){
        
        //MARK - NavigationBar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isHeroEnabled = true
        
        // MARK - BLSignButton
        self.BLSignButton.setImage(UIImage(named: "icon.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0), resizingMode: .stretch), for: .normal)
        self.BLSignButton.setTitle("", for: .normal)
        self.BLSignButton.tintColor = UIColor.black
        self.BLSignButton.addTarget(self, action: #selector(BLRightAnimation), for: .touchUpInside)
        
        
        
        // MARK - BLSubjectView
        self.BLSubjectView.frame = CGRect(x: self.BLSubjectView.frame.origin.x, y: self.BLSubjectView.frame.origin.y, width: self.BLSubjectView.frame.size.width, height: self.BLSubjectView.frame.size.height)
        self.BLSubjectView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
        
        
        
        // MARK - BLSubject Label
        self.BLSubject.text = "BL과 함께 새로운 \n스터디 그룹을 만들어 보새요"
        self.BLSubject.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(1.0))
        self.BLSubject.frame = CGRect(x: self.BLSubject.frame.origin.x, y: self.BLSubject.frame.origin.y, width: self.BLSubject.frame.size.width, height: self.BLSubject.frame.size.height)
        self.BLSubject.textColor = UIColor.black
        self.BLSubject.textAlignment = .center
        self.BLSubject.numberOfLines = 2
        let titleAttribute = NSMutableAttributedString(string: self.BLSubject.text!)
        titleAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 102/255, green: 102/255, blue: 255/255, alpha: 1.0), range:(self.BLSubject.text as! NSString).range(of: "BL"))
        self.BLSubject.attributedText = titleAttribute
        
        // MARK - NavigtaionButton
        self.LeftNaviButton.setAttributedTitle(NSAttributedString(string: "B.L.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.LeftNaviButton.tintColor = UIColor.black
        
        
    }
    
    //MARK - SlideMenuBarAction
    @objc private func BLRightAnimation(){
        self.BLSignButton.hero.id = "BLSlideMain"
        let SlideViewController = self.storyboard?.instantiateViewController(withIdentifier: "BLSlideView") as? BLSlideViewController
        UIView.animate(withDuration: 0.2, animations: {
            self.BLSignButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            SlideViewController?.isHeroEnabled = true
            SlideViewController?.heroModalAnimationType = .zoomOut
            self.navigationController?.pushViewController(SlideViewController!, animated: false)
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailSegue = segue.destination as? BLDetailViewController else { return  }
        let ViewCell = BLMainCollectionView.dequeueReusableCell(withReuseIdentifier: "BLMainCell", for: IndexPath(item: 0, section: 0)) as? BLMainCollectionViewCell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.MainBLData.studyseq!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BLMainCell", for: indexPath) as? BLMainCollectionViewCell
        
        DispatchQueue.main.async {
          
            
            
            MainCell?.CellHuman.text = self.MainBLData.studyLimit[indexPath.row]
            MainCell?.CellWriter.text = self.MainBLData.name[indexPath.row]
            MainCell?.CellSubject.text = self.MainBLData.title[indexPath.row]
            MainCell?.CellStartDate.text = self.MainBLData.studyCreate[indexPath.row]
            MainCell?.CellColorView.backgroundColor = UIColor(hex: self.MainBLData.iscolor[indexPath.row]!)
        }
        
        return MainCell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let SelctedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BLMainCell", for: indexPath) as? BLMainCollectionViewCell {
            let DetailVC = self.storyboard?.instantiateViewController(identifier: "DetailVC") as? BLDetailViewController
            
            
            
            self.performSegue(withIdentifier: "BLDetailVC", sender: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let HeaderView = self.BLMainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BLHeaderCell", for: IndexPath(item: 0, section: 0)) as? BLMainCollectionViewHeader
            HeaderView?.layer.borderColor = UIColor.lightGray.cgColor
            HeaderView?.layer.borderWidth = 1.0
            HeaderView?.reusableState.layer.borderColor = UIColor.lightGray.cgColor
            HeaderView?.reusableState.layer.borderWidth = 1.0
            HeaderView?.reusableState.setAttributedTitle(NSAttributedString(string: "지역", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(1.0))]), for: .normal)
            HeaderView?.reusableState.tintColor = UIColor.black
            
            HeaderView?.reusableTitle.backgroundColor = UIColor.white
            HeaderView?.reusableTitle.layer.borderColor = UIColor.lightGray.cgColor
            HeaderView?.reusableTitle.layer.borderWidth = 1.0
            HeaderView?.reusableTitle.setAttributedTitle(NSAttributedString(string: "주제", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(1.0))]), for: .normal)
            HeaderView?.reusableTitle.tintColor = UIColor.black
            return HeaderView!
        default:
            fatalError("Kind BL HeaderView Error")
        }
    }


    
    func ServerReqeust(URL : String , headers : HTTPHeaders){
        AF.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
//                    print(value)
                    let Json = JSON(value)
                    for (key,subJson):(String,JSON) in Json["result"]{
//                        debugPrint(key)
//                        debugPrint(subJson)
                        
                        self.MainBLData.contents?.append(contentsOf: subJson["contents"].stringValue)
                        self.MainBLData.studyCreate.append(subJson["study_created_at_str"].stringValue)
                        self.MainBLData.title.append(subJson["title"].stringValue)
                        self.MainBLData.name.append(subJson["name"].stringValue)
                        self.MainBLData.studyLimit.append(subJson["study_limit"].stringValue)
                        self.MainBLData.studyseq?.append(subJson["study_seq"].stringValue)
                        self.MainBLData.iscolor.append(subJson["color"].stringValue)
//                        self.MainBLData.studyCreate?.append(contentsOf: subJson[""])
//                        print("테스트 Contents입니다 \(subJson["contents"])")
                    }
                    DispatchQueue.main.async {
                        self.BLMainCollectionView.reloadData()
                    }
                    
                    
                case .failure(let error):
                    print(error.errorDescription)
                }
                
        }
    }
    
}



extension UIColor {
    public convenience init?(hex : String){
        let redColor,greenColor,blueColor,alphaColor: CGFloat
        if hex.hasPrefix("#"){
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner  = Scanner(string: hexColor)
                var hexNumber : UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber){
                    redColor = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    greenColor = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blueColor = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alphaColor = CGFloat((hexNumber & 0x000000ff) >> 24) / 255
                    
                    self.init(red :redColor , green : greenColor, blue : blueColor, alpha : alphaColor)
                        return
                }
            }
        }
        return nil
    }
    
}
