//
//  StudyMapViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/06.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import NMapsMap


class StudyMapViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var StudyMapView: NMFMapView!
    @IBOutlet weak var StudyFilterView: UIView!
    @IBOutlet weak var StudyFilterfirstbtn: UIButton!
    @IBOutlet weak var StudyFiltersecondbtn: UIButton!
    @IBOutlet weak var StudyFilterthirdbtn: UIButton!
    @IBOutlet weak var StudyFilterbtn: UIButton!
    @IBOutlet weak var StudyMaptableView: UITableView!
    @IBOutlet weak var StudyContainerView: UIView!
    @IBOutlet weak var StudyContainerGestureView: UIView!
    @IBOutlet weak var StudyContainertitlelabel: UILabel!
    
    
    private var studyList = [StudyContent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StudyMaptableView.delegate = self
        self.StudyMaptableView.dataSource = self
        self.setNavigationLayoutInit()
        self.setStudyFilterView()
        self.setContainerView()
        let nib = UINib(nibName: "StudyMapTableViewCell", bundle: nil)
        self.StudyMaptableView.register(nib, forCellReuseIdentifier: "StudyMapCell")
        DispatchQueue.main.async {
            ServerApi.shared.StudyListCall { result in
                self.studyList = result
                self.StudyMaptableView.reloadData()
            }
        }
        
    }
    
    private func setNavigationLayoutInit(){
        let navigationFirstBtn = UIButton()
        let navigationSecondBtn = UIButton()
        let navigationButtonItem = UIBarButtonItem(customView: navigationFirstBtn)
        let navigationButtonItemtwo = UIBarButtonItem(customView: navigationSecondBtn)
        navigationFirstBtn.setAttributedTitle(NSAttributedString(attributedString: NSAttributedString(string: "서울시 송파구", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16),NSAttributedString.Key.kern : -0.88])), for: .normal)
        navigationFirstBtn.setTitleColor(UIColor.black, for: .normal)
        navigationSecondBtn.setAttributedTitle(NSAttributedString(string: "성남시 분당구", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)]), for: .normal)
        navigationSecondBtn.setTitleColor(UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0), for: .normal)
        self.navigationItem.leftBarButtonItems = [navigationButtonItem,navigationButtonItemtwo]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        let BottomView = UIView()
        BottomView.frame.origin = CGPoint(x: 0, y: 31)
        BottomView.frame.size = CGSize(width: 88, height: 2)
        BottomView.backgroundColor = UIColor.black
        navigationFirstBtn.addSubview(BottomView)
    }
    
    private func setStudyFilterView(){
        self.StudyFilterView.backgroundColor = UIColor(red: 249/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.StudyFilterView.layer.borderWidth = 1
        self.StudyFilterView.layer.borderColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0).cgColor
        self.StudyFilterfirstbtn.setAttributedTitle(NSAttributedString(string: "UX/UI", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFilterfirstbtn.setTitleColor(UIColor.white, for: .normal)
        self.StudyFilterfirstbtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyFilterfirstbtn.layer.cornerRadius = 4
        self.StudyFilterfirstbtn.layer.masksToBounds = true
        self.StudyFiltersecondbtn.setAttributedTitle(NSAttributedString(string: "토익", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFiltersecondbtn.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.StudyFiltersecondbtn.backgroundColor = UIColor(red: 249/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.StudyFiltersecondbtn.layer.borderWidth = 1
        self.StudyFiltersecondbtn.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        self.StudyFiltersecondbtn.layer.cornerRadius = 4
        self.StudyFiltersecondbtn.layer.masksToBounds = true
        self.StudyFilterthirdbtn.setAttributedTitle(NSAttributedString(string: "웹개발", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFilterthirdbtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyFilterthirdbtn.setTitleColor(UIColor.white, for: .normal)
        self.StudyFilterthirdbtn.layer.cornerRadius = 4
        self.StudyFilterthirdbtn.layer.masksToBounds = true
        self.StudyFilterbtn.setImage(UIImage(named: "filter.png"), for: .normal)
        self.StudyFilterbtn.setTitle("", for: .normal)
    }
    private func setContainerView(){
        self.StudyContainerView.layer.cornerRadius = 20
        self.StudyContainerView.layer.masksToBounds = true
        self.StudyContainertitlelabel.attributedText = NSAttributedString(string: "맟춤 스터디 추천", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyContainertitlelabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.StudyContainertitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyContainerGestureView.backgroundColor = UIColor(red: 215/255, green: 218/255, blue: 221/255, alpha: 1.0)
        self.StudyContainerGestureView.layer.cornerRadius = 4
        self.StudyContainerGestureView.layer.masksToBounds = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.studyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let StudyCell = tableView.dequeueReusableCell(withIdentifier: "StudyMapCell", for: indexPath) as? StudyMapTableViewCell
        StudyCell?.StudyMaptitlelabel.text = self.studyList[indexPath.row].title
        StudyCell?.StudyMapContentlabel.text  = self.studyList[indexPath.row].content
        if self.studyList[indexPath.row].steps?.startIndex == 0 && self.studyList[indexPath.row].steps?.endIndex == 1 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 초급 ~ 초중급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        } else if self.studyList[indexPath.row].steps?.startIndex == 0 && self.studyList[indexPath.row].steps?.endIndex == 2 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 초급 ~ 중급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        } else if self.studyList[indexPath.row].steps?.startIndex == 0 && self.studyList[indexPath.row].steps?.endIndex == 3 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 초급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        }
        if self.studyList[indexPath.row].steps?.startIndex == 1 && self.studyList[indexPath.row].steps?.endIndex == 2 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 초중급 ~ 중급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        } else if self.studyList[indexPath.row].steps?.startIndex == 1 && self.studyList[indexPath.row].steps?.endIndex == 3 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 초중급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        }
        if self.studyList[indexPath.row].steps?.startIndex == 2 && self.studyList[indexPath.row].steps?.endIndex == 3 {
            StudyCell?.StudyMapranklabel.attributedText = NSAttributedString(string: "모집 등급: 중급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.6])
            StudyCell?.StudyMapranklabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        }
        StudyCell?.StudyMapInterestingbtn.setTitle("\(self.studyList[indexPath.row].tags![0])", for: .normal)
        StudyCell?.StudyMaponOfflinebtn.setTitle("\(self.studyList[indexPath.row].tags![1])", for: .normal)
        DispatchQueue.global(qos: .default).async {
        var StudyMarker = [NMFMarker]()
        for index in 0...self.studyList.count {
            let position = NMGLatLng(lat: self.studyList[indexPath.row].lng!, lng: self.studyList[indexPath.row].lat!)
            let marker = NMFMarker(position: position)
            marker.captionText = "test"
            marker.isHideCollidedMarkers = true
            StudyMarker.append(marker)
        }
        DispatchQueue.main.async { [weak self] in
            for marker in StudyMarker {
                marker.mapView = self?.StudyMapView
            }
        }
    }
        
        return StudyCell!
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
}

