//
//  StudyMapViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/06.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import NMapsMap


class StudyMapViewController: UIViewController {
    
    
    @IBOutlet weak var StudyMapView: NMFMapView!
    @IBOutlet weak var StudyFilterView: UIView!
    @IBOutlet weak var StudyFilterBtn: UIButton!
    @IBOutlet weak var StudyFilterBtn2: UIButton!
    @IBOutlet weak var StudyFilterBtn3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationLayoutInit()
        self.setStudyFilterView()
        self.setStudyMapLayout()
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
        let StudyMarker = NMFMarker()
        StudyMarker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        StudyMarker.mapView = self.StudyMapView
    }
}
