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
    @IBOutlet weak var StudyFilterBtn: UIButton!
    @IBOutlet weak var StudyFilterBtn2: UIButton!
    @IBOutlet weak var StudyFilterBtn3: UIButton!
    @IBOutlet weak var StudyMaptableView: UITableView!
    @IBOutlet weak var StudyContainerView: UIView!
    @IBOutlet weak var StudyContainertitlelabel: UILabel!
    
    
    private var studyList = [StudyContent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StudyMaptableView.delegate = self
        self.StudyMaptableView.dataSource = self
        self.setNavigationLayoutInit()
        self.setStudyFilterView()
        self.setStudyMapLayout()
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
        self.StudyFilterBtn.setAttributedTitle(NSAttributedString(string: "UX/UI", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFilterBtn.setTitleColor(UIColor.white, for: .normal)
        self.StudyFilterBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyFilterBtn.layer.cornerRadius = 4
        self.StudyFilterBtn.layer.masksToBounds = true
        self.StudyFilterBtn2.setAttributedTitle(NSAttributedString(string: "토익", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFilterBtn2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.StudyFilterBtn2.backgroundColor = UIColor(red: 249/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.StudyFilterBtn2.layer.borderWidth = 1
        self.StudyFilterBtn2.layer.borderColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0).cgColor
        self.StudyFilterBtn2.layer.cornerRadius = 4
        self.StudyFilterBtn2.layer.masksToBounds = true
        self.StudyFilterBtn3.setAttributedTitle(NSAttributedString(string: "웹개발", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern : -0.77]), for: .normal)
        self.StudyFilterBtn3.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyFilterBtn3.setTitleColor(UIColor.white, for: .normal)
        self.StudyFilterBtn3.layer.cornerRadius = 4
        self.StudyFilterBtn3.layer.masksToBounds = true
    }
    
    private func setStudyMapLayout(){

        
    }
    private func setContainerView(){
        self.StudyContainerView.layer.cornerRadius = 20
        self.StudyContainerView.layer.masksToBounds = true
        self.StudyContainertitlelabel.attributedText = NSAttributedString(string: "맟춤 스터디 추천", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyContainertitlelabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.StudyContainertitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.studyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let StudyCell = tableView.dequeueReusableCell(withIdentifier: "StudyMapCell", for: indexPath) as? StudyMapTableViewCell
        StudyCell?.StudyMaptitlelabel.text = self.studyList[indexPath.row].title
        StudyCell?.StudyMapContentlabel.text  = self.studyList[indexPath.row].content
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

