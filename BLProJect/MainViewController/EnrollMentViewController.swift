//
//  EnrollMentViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/30.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class EnrollMentViewController: UIViewController, UIScrollViewDelegate,UITextViewDelegate {
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
    @IBOutlet weak var StudyCafeExamplelabel: UILabel!
    @IBOutlet weak var StudyKindInfolabel: UILabel!
    @IBOutlet weak var StudyKindInfobtn: UIButton!
    @IBOutlet weak var StudyKindExamplelabel: UILabel!
    @IBOutlet weak var StudyDiffcultylabel: UILabel!
    @IBOutlet weak var StudyDiffcultyView: UIView!
    @IBOutlet weak var StudyDiffcultybtn1:
        UIButton!
    @IBOutlet weak var StudyDiffcultybtn2:
        UIButton!
    @IBOutlet weak var StudyDiffcultybtn3: UIButton!
    @IBOutlet weak var StudyDiffcultybtn4: UIButton!
    @IBOutlet weak var StudyDiffcultylabel1: UILabel!
    @IBOutlet weak var StudyDiffcultylabel2: UILabel!
    @IBOutlet weak var StudyDiffcultylabel3: UILabel!
    @IBOutlet weak var StudyDiffcultylabel4: UILabel!
    @IBOutlet weak var StudyTermlabel: UILabel!
    @IBOutlet weak var Studystartdatelabel: UILabel!
    @IBOutlet weak var Studystartdatebtn: UIButton!
    @IBOutlet weak var Studylastdatelabel: UILabel!
    @IBOutlet weak var Studylastdatebtn: UIButton!
    @IBOutlet weak var Limitbtn2: UIButton!
    @IBOutlet weak var Conferencelabel: UILabel!
    @IBOutlet weak var Studymeetnamelabel: UILabel!
    @IBOutlet weak var Studymeettextview: UITextView!
    @IBOutlet weak var Studymeettextcountlabel: UILabel!
    @IBOutlet weak var Studygoalnamelabel: UILabel!
    @IBOutlet weak var Studygoaltextview: UITextView!
    @IBOutlet weak var Studygoaltextcountlabel: UILabel!
    @IBOutlet weak var StudyIntroducenamelabel: UILabel!
    @IBOutlet weak var StudyIntroducetextview: UITextView!
    @IBOutlet weak var StudyIntroducecountlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EnrollMentscrollview.isScrollEnabled = true
        self.EnrollMentscrollview.delegate = self
        self.Studymeettextview.delegate = self
        self.Studygoaltextview.delegate = self
        self.StudyIntroducetextview.delegate = self
        self.NavigationLayou()
        self.SetupInitLayout()
        self.SetStudyInitLayout()
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
        self.Participantlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Participantlabel.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.32
        self.Participantlabel.attributedText = NSMutableAttributedString(string: "참가자 모집 유형", attributes: [NSAttributedString.Key.kern: -0.88, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.FirstComeLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        var paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineHeightMultiple = 1.25
        self.FirstComeLabel.attributedText = NSAttributedString(string: "선착순 모집", attributes: [NSAttributedString.Key.kern:-0.77, NSAttributedString.Key.paragraphStyle: paragraphStyle2])
        self.FirstComeLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        var paragraphStyle3 = NSMutableParagraphStyle()
        paragraphStyle3.lineHeightMultiple = 1.54
        self.FirstComeExampleLabel.attributedText = NSAttributedString(string: "선착순으로 모집 인원이 다 차면 모임이 생성돼요.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle3, NSAttributedString.Key.kern: -0.66])
        var paragraphStyle4 = NSMutableParagraphStyle()
        paragraphStyle4.lineHeightMultiple = 1.66
        self.ReviewLabel.attributedText = NSAttributedString(string: "검토 후 승인", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle2,NSAttributedString.Key.kern:-0.77])
        self.ReviewLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.ReviewExampleLabel.attributedText = NSAttributedString(string: "가입 신청한 사람을 검토하고, 승인된 사람들과 모임을 진행해요.", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle3,NSAttributedString.Key.kern:-0.66])
        self.Recruitmentlabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Recruitmentlabel.attributedText = NSAttributedString(string: "모집 인원", attributes: [NSAttributedString.Key.kern : -0.88])
        self.RecruitmentBtn.setAttributedTitle(NSAttributedString(string: "6 명", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)]), for: .normal)
        self.RecruitmentBtn.layer.borderWidth = 1.0
        self.RecruitmentBtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.RecruitmentBtn.layer.cornerRadius = 4
        self.RecruitmentBtn.layer.masksToBounds = true
        self.RecruitmentBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.RecruitmentBtn.titleEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 10, right: 16)
        self.RecruitmentBtn.tintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        self.RecruitmentBtn.setImage(UIImage(named: "triangle@1x.png"), for: .normal)
        self.RecruitmentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 310, bottom: 0, right: 0)
        var Limitparagraph = NSMutableParagraphStyle()
        Limitparagraph.lineHeightMultiple = 1.15
        self.Limitlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Limitlabel.attributedText = NSAttributedString(string: "제한 없음", attributes: [NSAttributedString.Key.kern: -0.77,NSAttributedString.Key.paragraphStyle:Limitparagraph])
        self.DetailInfolabel.attributedText = NSAttributedString(string: "상세 정보", attributes: [NSAttributedString.Key.kern: -1.21])
        self.DetailInfolabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Progresslabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Progresslabel.attributedText = NSAttributedString(string: "진행 유형", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern: -0.88])
        self.Offlinelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        var paragraphStyle5 = NSMutableParagraphStyle()
        paragraphStyle5.lineHeightMultiple = 1.25
        self.Offlinelabel.attributedText = NSAttributedString(string: "오프라인", attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle5,NSAttributedString.Key.kern : -0.77])
        self.Onlinelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.Onlinelabel.attributedText = NSAttributedString(string: "온라인", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle5,NSAttributedString.Key.kern: -0.77])
        self.Recruitmentarealabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Recruitmentarealabel.attributedText = NSAttributedString(string: "모집 지역", attributes: [NSAttributedString.Key.kern: -0.88])
        self.Recruitmentareabtn.setAttributedTitle(NSAttributedString(string: "지역 선택", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16)!,NSAttributedString.Key.foregroundColor : UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)]), for: .normal)
        self.Recruitmentareabtn.layer.borderWidth = 1.0
        self.Recruitmentareabtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Recruitmentareabtn.layer.cornerRadius = 4
        self.Recruitmentareabtn.layer.masksToBounds = true
        self.Recruitmentareabtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.Recruitmentareabtn.titleEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 10, right: 16)
        self.Recruitmentareabtn.tintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        self.Recruitmentareabtn.setImage(UIImage(named: "triangle@1x.png"), for: .normal)
        self.Recruitmentareabtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 310, bottom: 0, right: 0)
        self.Studyarealabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Studyarealabel.attributedText = NSAttributedString(string: "스터디 진행 장소", attributes: [NSAttributedString.Key.kern: -0.88])
        self.StudyCafesearchbar.backgroundColor = UIColor.clear
        self.StudyCafesearchbar.layer.borderWidth = 1
        self.StudyCafesearchbar.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.StudyCafesearchbar.layer.masksToBounds = true
        self.StudyCafesearchbar.searchTextField.backgroundColor = UIColor.clear
        self.StudyCafesearchbar.layer.cornerRadius = 4
        self.StudyCafesearchbar.searchTextField.attributedPlaceholder = NSAttributedString(string: "스터디룸 검색하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)])
        self.StudyCafesearchbar.setImage(UIImage(named: "searchbar@2x.png"), for: .search, state: .normal)
        self.StudyCafeExamplelabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyCafeExamplelabel.lineBreakMode = .byWordWrapping
        self.StudyCafeExamplelabel.numberOfLines = 2
        self.StudyCafeExamplelabel.attributedText = NSAttributedString(string: "모집 지역과 스터디 진행 장소를 같은 지역으로 맞춰주세요.\n비대면 스터디의 경우 진행 플랫폼을 입력해주세요.", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.paragraphStyle: paragraphStyle5])
        self.StudyKindInfolabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.StudyKindInfolabel.attributedText = NSAttributedString(string: "어떤 스터디를 모집할까요?", attributes: [NSAttributedString.Key.kern : -0.88])
        self.StudyKindInfobtn.setAttributedTitle(NSAttributedString(string: "선택", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)]), for: .normal)
        self.StudyKindInfobtn.layer.borderWidth = 1.0
        self.StudyKindInfobtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.StudyKindInfobtn.layer.cornerRadius = 4
        self.StudyKindInfobtn.layer.masksToBounds = true
        self.StudyKindInfobtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.StudyKindInfobtn.titleEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 10, right: 16)
        self.StudyKindInfobtn.tintColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        self.StudyKindInfobtn.setImage(UIImage(named: "triangle@1x.png"), for: .normal)
        self.StudyKindInfobtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 310, bottom: 0, right: 0)
        self.StudyKindExamplelabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyKindExamplelabel.attributedText = NSAttributedString(string: "스터디 정보는 ‘내 정보’에서 변경할 수 있어요.", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.paragraphStyle:paragraphStyle3])
        self.StudyDiffcultylabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.StudyDiffcultylabel.attributedText = NSAttributedString(string: "모집 난이도", attributes: [NSAttributedString.Key.kern : -0.88])
        self.StudyDiffcultylabel1.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyDiffcultylabel1.attributedText = NSAttributedString(string: "초급", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyDiffcultylabel2.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyDiffcultylabel2.attributedText = NSAttributedString(string: "초중급", attributes: [NSAttributedString.Key.kern: -0.77])
        self.StudyDiffcultylabel3.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyDiffcultylabel3.attributedText = NSAttributedString(string: "중급", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyDiffcultylabel4.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.StudyDiffcultylabel4.attributedText = NSAttributedString(string: "상급", attributes: [NSAttributedString.Key.kern: -0.77])
    }
    public func SetStudyInitLayout(){
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.54
        self.StudyTermlabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.StudyTermlabel.attributedText = NSAttributedString(string: "스터디 진행 기간", attributes: [NSAttributedString.Key.kern: -0.88])
        self.Studystartdatelabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.Studystartdatelabel.attributedText = NSAttributedString(string: "시작 일시", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.Studystartdatebtn.setTitle("날짜 선택", for: .normal)
        self.Studystartdatebtn.setAttributedTitle(NSAttributedString(string: "날짜 선택", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size:16)]), for: .normal)
        self.Studystartdatebtn.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0), for: .normal)
        self.Studystartdatebtn.layer.borderWidth = 1
        self.Studystartdatebtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Studystartdatebtn.layer.cornerRadius = 4
        self.Studystartdatebtn.layer.masksToBounds = true
        self.Studystartdatebtn.titleEdgeInsets = UIEdgeInsets(top: 11, left: 16, bottom: 10, right: 0)
        self.Studystartdatebtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.Studylastdatelabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.Studylastdatelabel.attributedText = NSAttributedString(string: "마감 일시", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.paragraphStyle:paragraphStyle])
        self.Studylastdatebtn.setTitle("날짜 선택", for: .normal)
        self.Studylastdatebtn.setTitleColor(UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0), for: .normal)
        self.Studylastdatebtn.setAttributedTitle(NSAttributedString(string: "날짜 선택", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)]), for: .normal)
        self.Studylastdatebtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        self.Studylastdatebtn.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Studylastdatebtn.layer.borderWidth = 1.0
        self.Studylastdatebtn.layer.cornerRadius = 4
        self.Studylastdatebtn.layer.masksToBounds = true
        self.Studylastdatebtn.titleEdgeInsets = UIEdgeInsets(top: 11, left: 16, bottom: 10, right: 0)
        self.Conferencelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        var paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.lineHeightMultiple = 1.15
        self.Conferencelabel.attributedText = NSAttributedString(string: "협의 예정", attributes: [NSAttributedString.Key.kern: -0.77,NSAttributedString.Key.paragraphStyle: paragraphStyle2])
        self.Studymeetnamelabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Studymeetnamelabel.attributedText = NSAttributedString(string: "스터디 모임 이름", attributes: [NSAttributedString.Key.kern : -0.88])
        self.Studymeettextview.layer.borderWidth = 1
        self.Studymeettextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Studymeettextview.layer.cornerRadius = 4
        self.Studymeettextview.layer.masksToBounds = true
        self.Studymeettextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.kern:-0.88, NSAttributedString.Key.paragraphStyle:paragraphStyle2,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        self.Studymeettextcountlabel.attributedText = NSAttributedString(string: "0 / 20", attributes: [NSAttributedString.Key.kern : -0.66])
        self.Studygoalnamelabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.Studygoalnamelabel.attributedText = NSAttributedString(string: "스터디 목표", attributes: [NSAttributedString.Key.kern : -0.88])
        self.Studygoaltextview.layer.borderWidth = 1
        self.Studygoaltextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.Studymeettextview.layer.cornerRadius = 4
        self.Studygoaltextview.layer.masksToBounds = true
        self.Studygoaltextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle2,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        self.Studygoaltextcountlabel.attributedText = NSAttributedString(string: "0 / 60", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyIntroducenamelabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.StudyIntroducenamelabel.attributedText = NSAttributedString(string: "스터디 소개", attributes: [NSAttributedString.Key.kern : -0.88])
        self.StudyIntroducetextview.layer.borderWidth = 1
        self.StudyIntroducetextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.StudyIntroducetextview.layer.cornerRadius = 4
        self.StudyIntroducetextview.layer.masksToBounds = true
        self.StudyIntroducetextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle2,NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        self.StudyIntroducecountlabel.attributedText = NSAttributedString(string: "0 / 1000", attributes: [NSAttributedString.Key.kern : -0.66])
    }
    
    //만약에 다른 텍스트를 눌렀어 그러면 위에 텍스트는 플레이스 홀더를 보이게하게 만들어야해 하지만 위에 텍스트가 써있는 상태라면 플레이스 홀더는 지우고 텍스트만 보이는 형태로
    func textViewDidBeginEditing(_ textView: UITextView) {
        var textparagraphStyle = NSMutableParagraphStyle()
        textparagraphStyle.lineHeightMultiple = 1.15
        if textView.tag == 1 && textView.text == "텍스트를 입력하세요" {
            self.Studymeettextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.Studymeettextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern:-0.88, NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        }else if textView.tag == 2 && textView.text == "텍스트를 입력하세요" {
            self.Studygoaltextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.Studygoaltextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.88,NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        }else if textView.tag == 3 && textView.text == "텍스트를 입력하세요"{
            self.StudyIntroducetextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.StudyIntroducetextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.88,NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        var textparagraphStyle = NSMutableParagraphStyle()
        textparagraphStyle.lineHeightMultiple = 1.15
        if textView.tag == 1 && textView.text == "" {
            self.Studymeettextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.kern:-0.88, NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        }else if textView.tag == 2 && textView.text == "" {
            self.Studygoaltextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 1 {
            self.Studymeettextcountlabel.text = "\(self.Studymeettextview.text.count) / 20"
        }else if textView.tag == 2{
            self.Studygoaltextcountlabel.text = "\(self.Studygoaltextview.text.count) / 60"
        }else if textView.tag == 3{
            self.StudyIntroducecountlabel.text = "\(self.StudyIntroducetextview.text.count) / 1000"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.tag == 1{
            let currentText = textView.text ?? ""
            guard let StringRange = Range(range, in: currentText) else { return false }
            let changedText = currentText.replacingCharacters(in: StringRange, with: text)
            
            return changedText.count <= 20
        }else if textView.tag == 2{
            let cureentText2 = textView.text ?? ""
            guard let StringRange = Range(range, in: cureentText2) else { return false }
            let changedText = cureentText2.replacingCharacters(in: StringRange, with: text)
            
            return changedText.count <= 60
        }else if textView.tag == 3{
            let cureentText3 = textView.text ?? ""
            guard let StringRange = Range(range, in: cureentText3) else {return false}
            let changeText = cureentText3.replacingCharacters(in: StringRange, with: text)
            
            return changeText.count <= 1000
        }
        return true
    }
}
