//
//  EnrollMentViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/30.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class EnrollMentViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var RecruitmentInfolabel: UILabel!
    @IBOutlet weak var RecruitmentInfoLine: UIView!
    @IBOutlet weak var Participantlabel: UILabel!
    @IBOutlet weak var FirstComeBtn: UIButton!
    @IBOutlet weak var FirstComeLabel: UILabel!
    @IBOutlet weak var FirstComeExampleLabel: UILabel!
    @IBOutlet weak var ReviewLabel: UILabel!
    @IBOutlet weak var ReviewExampleLabel: UILabel!
    @IBOutlet weak var ReviewBtn: UIButton!
    @IBOutlet weak var RecruitmentBtn: UIButton!
    @IBOutlet weak var Recruitmentlabel: UILabel!
    @IBOutlet weak var LimitBtn: UIButton!
    @IBOutlet weak var Limitlabel: UILabel!
    @IBOutlet weak var DetailInfolabel: UILabel!
    @IBOutlet weak var DetailInfoLine: UIView!
    @IBOutlet weak var Progresslabel: UILabel!
    @IBOutlet weak var OfflineCheckbtn: UIButton!
    @IBOutlet weak var OnlineCheckbtn: UIButton!
    @IBOutlet weak var Offlinelabel: UILabel!
    @IBOutlet weak var Onlinelabel: UILabel!
    @IBOutlet weak var Recruitmentarealabel: UILabel!
    @IBOutlet weak var EnrollMentscrollview: UIScrollView!
    @IBOutlet weak var Recruitmentareabtn: UIButton!
    @IBOutlet weak var Studyarealabel: UILabel!
    @IBOutlet weak var StudyCafesearchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EnrollMentscrollview.isScrollEnabled = true
        self.EnrollMentscrollview.delegate = self
        self.NavigationLayou()
        self.SetupInitLayout()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.EnrollMentscrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2270)
    }
    
    
    public func NavigationLayou() {
        self.navigationItem.title = "스터디 만들기"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "NavigationBackbutton@1x.jpg")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "NavigationBackbutton@1x.jpg")
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    public func SetupInitLayout() {
        self.RecruitmentInfolabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.RecruitmentInfolabel.attributedText = NSAttributedString(string: "모집 정보", attributes: [NSAttributedString.Key.kern: -1.21])
        self.RecruitmentInfolabel.textAlignment = .left
        self.Participantlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Participantlabel.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.32
        self.Participantlabel.attributedText = NSMutableAttributedString(string: "참가자 모집 유형", attributes: [NSAttributedString.Key.kern: -0.88, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.Participantlabel.numberOfLines = 1
        self.FirstComeLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.FirstComeLabel.numberOfLines = 1
        var paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineHeightMultiple = 1.66
        self.FirstComeLabel.attributedText = NSAttributedString(string: "선착순 모집", attributes: [NSAttributedString.Key.kern:-0.77, NSAttributedString.Key.paragraphStyle: paragraphStyle2])
        self.FirstComeLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.FirstComeExampleLabel.textAlignment = .left
        self.FirstComeExampleLabel.numberOfLines = 1
        var paragraphStyle3 = NSMutableParagraphStyle()
        paragraphStyle3.lineHeightMultiple = 1.54
        self.FirstComeExampleLabel.attributedText = NSAttributedString(string: "선착순으로 모집 인원이 다 차면 모임이 생성돼요.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle3, NSAttributedString.Key.kern: -0.66])
        self.FirstComeBtn.setTitle("", for: .normal)
        self.FirstComeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.ReviewLabel.textAlignment = .left
        self.ReviewLabel.numberOfLines = 1
        self.ReviewLabel.attributedText = NSAttributedString(string: "검토 후 승인", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle2,NSAttributedString.Key.kern:-0.77])
        self.ReviewLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.ReviewExampleLabel.textAlignment = .left
        self.ReviewExampleLabel.numberOfLines = 1
        self.ReviewExampleLabel.attributedText = NSAttributedString(string: "가입 신청한 사람을 검토하고, 승인된 사람들과 모임을 진행해요.", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle3,NSAttributedString.Key.kern:-0.66])
        self.ReviewBtn.setTitle("", for: .normal)
        self.ReviewBtn.translatesAutoresizingMaskIntoConstraints = false
        self.Recruitmentlabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Recruitmentlabel.textAlignment = .left
        self.Recruitmentlabel.numberOfLines = 1
        self.Recruitmentlabel.attributedText = NSAttributedString(string: "모집 인원", attributes: [NSAttributedString.Key.kern : -0.88])
        self.RecruitmentBtn.setAttributedTitle(NSAttributedString(string: "6 명", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)]), for: .normal)
        self.RecruitmentBtn.layer.borderWidth = 1.0
        self.RecruitmentBtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.RecruitmentBtn.layer.cornerRadius = 4
        self.RecruitmentBtn.layer.masksToBounds = true
        self.RecruitmentBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.RecruitmentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.RecruitmentBtn.tintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        self.RecruitmentBtn.setImage(UIImage(named: "triangle@1x.png"), for: .normal)
        self.RecruitmentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 310, bottom: 0, right: 0)
        self.Limitlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Limitlabel.numberOfLines = 1
        self.Limitlabel.attributedText = NSAttributedString(string: "제한 없음", attributes: [NSAttributedString.Key.kern: -0.77])
        self.DetailInfolabel.textAlignment = .left
        self.DetailInfolabel.attributedText = NSAttributedString(string: "상세 정보", attributes: [NSAttributedString.Key.kern: -1.21])
        self.DetailInfolabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Progresslabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Progresslabel.textAlignment = .left
        self.Progresslabel.attributedText = NSAttributedString(string: "진행 유형", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern : -0.88])
        self.Offlinelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Offlinelabel.textAlignment = .left
        self.Offlinelabel.numberOfLines = 1
        var paragraphStyle4 = NSMutableParagraphStyle()
        paragraphStyle4.lineHeightMultiple = 1.20
        self.Offlinelabel.attributedText = NSAttributedString(string: "오프라인", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle4,NSAttributedString.Key.kern : -0.77])
        self.OfflineCheckbtn.setTitle("", for: .normal)
        self.Onlinelabel.textAlignment = .left
        self.Onlinelabel.numberOfLines = 1
        self.Onlinelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Onlinelabel.attributedText = NSAttributedString(string: "온라인", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle4,NSAttributedString.Key.kern: -0.77])
        self.OfflineCheckbtn.setTitle("", for: .normal)
        self.Recruitmentarealabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Recruitmentarealabel.textAlignment = .left
        self.Recruitmentarealabel.numberOfLines = 1
        self.Recruitmentarealabel.attributedText = NSAttributedString(string: "모집 지역", attributes: [NSAttributedString.Key.kern :-0.88])
        self.Recruitmentareabtn.setAttributedTitle(NSAttributedString(string: "서울시 강동구", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)]), for: .normal)
        self.Recruitmentareabtn.layer.borderWidth = 1.0
        self.Recruitmentareabtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Recruitmentareabtn.layer.cornerRadius = 4
        self.Recruitmentareabtn.layer.masksToBounds = true
        self.Recruitmentareabtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.Recruitmentareabtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.Recruitmentareabtn.tintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        self.Recruitmentareabtn.setImage(UIImage(named: "triangle@1x.png"), for: .normal)
        self.Recruitmentareabtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 310, bottom: 0, right: 0)
        self.Studyarealabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Studyarealabel.attributedText = NSAttributedString(string: "스터디 진행 장소", attributes: [NSAttributedString.Key.kern : -0.88])
        self.Studyarealabel.textAlignment = .left
        self.Studyarealabel.numberOfLines = 1
        self.StudyCafesearchbar.backgroundColor = UIColor.clear
        self.StudyCafesearchbar.layer.borderWidth = 1
        self.StudyCafesearchbar.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.StudyCafesearchbar.layer.masksToBounds = true
        self.StudyCafesearchbar.searchTextField.backgroundColor = UIColor.clear
        self.StudyCafesearchbar.layer.cornerRadius = 4
        self.StudyCafesearchbar.searchTextField.attributedPlaceholder = NSAttributedString(string: "스터디룸 검색하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)])
        self.StudyCafesearchbar.setImage(UIImage(named: "searchbar@2x.png"), for: .search, state: .normal)
        self.StudyCafesearchbar.
        
    }
    
}
