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
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var BLSubjectView: UIView!
    @IBOutlet weak var BLSubject: UILabel!
    @IBOutlet weak var BLMainCollectionView: UICollectionView!
    @IBOutlet weak var BLSignButton: UIButton!
    public var StudyModel = [StudyContent]()
    var index : Int?
    
    lazy var HeaderView: BLMainCollectionViewHeader = {
        let HeaderView = self.BLMainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BLHeaderCell", for: IndexPath(item: 0, section: 0)) as? BLMainCollectionViewHeader
        HeaderView?.backgroundColor = UIColor.white
        return HeaderView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerApi.shared.StudyListCall { data in
            DispatchQueue.main.async {
                self.StudyModel = data
                self.BLMainCollectionView.reloadData()
            }
        }
        
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

        self.BLSignButton.setImage(UIImage(named: "icon.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0), resizingMode: .stretch), for: .normal)
        self.BLSignButton.setTitle("", for: .normal)
        self.BLSignButton.tintColor = UIColor.black
//        self.BLSignButton.addTarget(self, action: #selector(LogoutAction), for: .touchUpInside)
        
        
        self.BLSubjectView.frame = CGRect(x: self.BLSubjectView.frame.origin.x, y: self.BLSubjectView.frame.origin.y, width: self.BLSubjectView.frame.size.width, height: self.BLSubjectView.frame.size.height)
        self.BLSubjectView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
        self.BLSubject.text = "BL과 함께 새로운 \n스터디 그룹을 만들어 보새요"
        self.BLSubject.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(1.0))
        self.BLSubject.frame = CGRect(x: self.BLSubject.frame.origin.x, y: self.BLSubject.frame.origin.y, width: self.BLSubject.frame.size.width, height: self.BLSubject.frame.size.height)
        self.BLSubject.textColor = UIColor.black
        self.BLSubject.textAlignment = .center
        self.BLSubject.numberOfLines = 2
        // kys force_cast 때문에 일단 주석처리 했습니다. 수정예정
//        let titleAttribute = NSMutableAttributedString(string: self.BLSubject.text!)
//        titleAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 102/255, green: 102/255, blue: 255/255, alpha: 1.0), range:(self.BLSubject.text as! NSString).range(of: "BL"))
//        self.BLSubject.attributedText = titleAttribute
        

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let DetailSegue = segue.destination as? BLDetailViewController else { return  }
        DetailSegue.Index = self.index!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.StudyModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let MainCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BLMainCell", for: indexPath) as? BLMainCollectionViewCell
        
        DispatchQueue.main.async {
            MainCell?.CellSubject.text = self.StudyModel[indexPath.row].title
            MainCell?.CellHuman.text = self.StudyModel[indexPath.row].study_leader?.nickname
            MainCell?.CellWriter.text = self.StudyModel[indexPath.row].study_leader?.email
            MainCell?.CellState.text =  self.StudyModel[indexPath.row].content
            MainCell?.CellStartDate.text = self.StudyModel[indexPath.row].study_created_at_str
        }
        
        return MainCell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let StudyFarmView = BLMainCollectionView.cellForItem(at: indexPath) as? BLMainCollectionViewCell  else { return  }
        self.index = indexPath.row
        self.performSegue(withIdentifier: "BLDetailVC", sender: nil)
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
    
//    @objc private func LogoutAction(){
//        OAuthApi.shared.AuthLogoutCall { [weak self] result in
//            switch result {
//            case .success(let value):
//                if value.code == 200 {
//                    print("Logut 성공")
//                    self?.navigationController?.popToRootViewController(animated: true)
//                }else{
//                    self?.navigationController?.popToRootViewController(animated: true)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
}

