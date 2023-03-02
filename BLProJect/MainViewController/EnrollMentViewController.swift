//
//  EnrollMentViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/30.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import FSCalendar

class EnrollMentViewController: UIViewController, UIScrollViewDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var RecruitmentInfolabel: UILabel!
    @IBOutlet weak var RecruitmentInfoLine: UIView!
    @IBOutlet weak var Participantlabel: UILabel!
    @IBOutlet weak var FirstComeBtn: UIButton!
    @IBOutlet weak var FirstComeLabel: UILabel!
    @IBOutlet weak var FirstComeExampleLabel: UILabel!
    @IBOutlet weak var ReviewLabel: UILabel!
    @IBOutlet weak var ReviewExampleLabel: UILabel!
    @IBOutlet weak var ReviewBtn: UIButton!
    @IBOutlet weak var RecruitmentBtn: PickerButton!
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
    @IBOutlet weak var Recruitmentareabtn: PickerButton!
    @IBOutlet weak var Studyarealabel: UILabel!
    @IBOutlet weak var StudyCafesearchbar: UISearchBar!
    @IBOutlet weak var StudyCafeExamplelabel: UILabel!
    @IBOutlet weak var StudyKindInfolabel: UILabel!
    @IBOutlet weak var StudyKindInfobtn: UIButton!
    @IBOutlet weak var StudyKindExamplelabel: UILabel!
    @IBOutlet weak var StudyDiffcultylabel: UILabel!
    @IBOutlet weak var StudyDiffcultyView: UIView!
    @IBOutlet weak var StudyDiffcultybtn1: UIButton!
    @IBOutlet weak var StudyDiffcultybtn2: UIButton!
    @IBOutlet weak var StudyDiffcultybtn3: UIButton!
    @IBOutlet weak var StudyDiffcultybtn4: UIButton!
    @IBOutlet weak var StudyUserDiffcultylabel: UILabel!
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
    @IBOutlet weak var Studypostbtn: UIButton!
    @IBOutlet weak var StudyKindInfoTopconstraint: NSLayoutConstraint!
    @IBOutlet weak var StudymeetExamplelabel: UILabel!
    @IBOutlet weak var StudygoalExamplelabel: UILabel!
    @IBOutlet var FirstDateCalendar: FSCalendar!
    @IBOutlet weak var StudyIntroduceExamplelabel: UILabel!
    @IBOutlet var ProcessMonthView: ProcessView!
    @IBOutlet var InterestingUserView: InterestingView!
    @IBOutlet var RecruitAreaUserView: RecruitAreaView!
    var EnrollMentContainerView = UIView()
    @IBAction func Createpickerview(_ sender: PickerButton) {
        let pickerView = UIPickerView()
        let pickerToolView = UIToolbar()
        let pickerToolbutton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(RemoveFromToolbar))
        let pickerToolbuttonFiexed = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerView.delegate = self
        pickerView.tag = 1
        pickerToolView.sizeToFit()
        pickerToolView.barTintColor = UIColor.darkGray
        pickerToolView.tintColor = UIColor.white
        pickerToolView.setItems([pickerToolbuttonFiexed,pickerToolbutton], animated: false)
        pickerToolView.isUserInteractionEnabled = true
        sender.inputAccessoryView = pickerToolView
        sender.inputView = pickerView
    }

    let PickerData = ["1 명","2 명","3 명","4 명","5 명","6 명","7 명","8 명","9 명","10 명"]
    let MonthPickerData = ["1개월","2개월","3개월","4개월","5개월","6개월","7개월","8개월","9개월","10개월","11개월","12개월"]
    var FirstDate : Date? = nil
    var LastDate : Date? = nil
    public var StudyCategoryModel = [StudyContentsContainer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EnrollMentscrollview.isScrollEnabled = true
        self.EnrollMentscrollview.delegate = self
        self.Studymeettextview.delegate = self
        self.Studygoaltextview.delegate = self
        self.FirstDateCalendar.delegate = self
        self.FirstDateCalendar.dataSource = self
        self.StudyIntroducetextview.delegate = self
        self.NavigationLayou()
        self.SetupInitLayout()
        self.SetStudyInitLayout()
        self.ReviewBtn.addTarget(self, action: #selector(self.ReviewBtnCheck(_:)), for: .touchUpInside)
        self.FirstComeBtn.addTarget(self, action: #selector(self.FirstComeBtnCheck(_:)), for: .touchUpInside)
        self.OfflineCheckbtn.addTarget(self, action: #selector(self.OfflineBtnCheck), for: .touchUpInside)
        self.OnlineCheckbtn.addTarget(self, action: #selector(self.OnlineBtnCheck(_:)), for: .touchUpInside)
        self.StudyKindInfobtn.addTarget(self, action: #selector(self.AddInterestingView), for: .touchUpInside)
        self.StudyDiffcultybtn1.addTarget(self, action: #selector(self.difficultyBtnSelect(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn2.addTarget(self, action: #selector(self.difficultyBtnSelect2(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn3.addTarget(self, action: #selector(self.difficultyBtnSelect3(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn4.addTarget(self, action: #selector(self.difficultyBtnSelect4(_:)), for: .touchUpInside)
        self.LimitBtn.addTarget(self, action: #selector(self.LimitPersonBtnSelect(_:)), for: .touchUpInside)
        self.Limitbtn2.addTarget(self, action: #selector(self.LimitDateBtnSelect1(_:)), for: .touchUpInside)
        self.Studystartdatebtn.addTarget(self, action: #selector(self.setFSCalendarLayoutInit), for: .touchUpInside)
        self.Studylastdatebtn.addTarget(self, action: #selector(self.LastMonthPickerView), for: .touchUpInside)
        self.Recruitmentareabtn.addTarget(self, action: #selector(self.AddRecruitAreaView), for: .touchUpInside)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(EnrollMentViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(EnrollMentViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let ScrollVieWTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.ScrollViewHideKeyboard(recognizer:)))
        self.EnrollMentscrollview.addGestureRecognizer(ScrollVieWTapGesture)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let winodw = UIApplication.shared.windows.first
        if let FirstCalendarTag = winodw?.viewWithTag(5) {
            FirstCalendarTag.removeFromSuperview()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        self.RecruitmentBtn.setTitle("6 명", for: .normal)
        self.RecruitmentBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16)
        self.RecruitmentBtn.setTitleColor( UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
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
        self.StudyCafeExamplelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyCafeExamplelabel.lineBreakMode = .byWordWrapping
        self.StudyCafeExamplelabel.numberOfLines = 2
        self.StudyCafeExamplelabel.attributedText = NSAttributedString(string: "모집 지역과 스터디 진행 장소를 같은 지역으로 맞춰주세요.", attributes: [NSAttributedString.Key.kern: -0.66])
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
        self.StudyUserDiffcultylabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyUserDiffcultylabel.textAlignment = .center
        self.StudymeetExamplelabel.isHidden = true
        self.StudymeetExamplelabel.textAlignment = .left
        self.StudygoalExamplelabel.isHidden = true
        self.StudygoalExamplelabel.textAlignment = .left
        self.StudyIntroduceExamplelabel.isHidden = true
        self.StudyIntroduceExamplelabel.textAlignment = .left
    }
    
    
    
    public func SetStudyInitLayout(){
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.54
        self.StudyTermlabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.StudyTermlabel.attributedText = NSAttributedString(string: "스터디 진행 기간", attributes: [NSAttributedString.Key.kern: -0.88])
        self.Studystartdatelabel.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        self.Studystartdatelabel.attributedText = NSAttributedString(string: "시작 일시", attributes: [NSAttributedString.Key.kern: -0.66,NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.Studystartdatebtn.setTitle("날짜 선택", for: .normal)
        self.Studystartdatebtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size:16)
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
        self.Studylastdatebtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size:16)
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
        self.Studypostbtn.layer.cornerRadius = 8
        self.Studypostbtn.layer.masksToBounds = true
        self.Studypostbtn.isEnabled = false
        self.Studypostbtn.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1.0), for: .normal)
        self.Studypostbtn.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
    }
    
    @objc func OfflineBtnCheck(_ sender: UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }else{
            self.OnlineCheckbtn.isSelected = false
            sender.isSelected = true
            self.Recruitmentarealabel.isHidden = false
            self.Recruitmentareabtn.isHidden = false
            self.Studyarealabel.isHidden = false
            self.StudyCafesearchbar.isHidden = false
            self.StudyCafeExamplelabel.isHidden = false
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.OfflineCheckbtn.setImage(UIImage(named: "RedCheck@1x.png"), for: .selected)
                    self.OfflineCheckbtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.OfflineCheckbtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.Recruitmentarealabel.translatesAutoresizingMaskIntoConstraints = false
                    self.Studyarealabel.translatesAutoresizingMaskIntoConstraints = false
                    self.Recruitmentareabtn.translatesAutoresizingMaskIntoConstraints = false
                    self.StudyKindInfolabel.translatesAutoresizingMaskIntoConstraints = false
                    self.StudyCafeExamplelabel.translatesAutoresizingMaskIntoConstraints = false
                    self.StudyKindInfoTopconstraint.constant = 40
                }
            })
        }
    }
    @objc
    func OnlineBtnCheck(_ sender: UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }else{
            self.OfflineCheckbtn.isSelected = false
            sender.isSelected = true
            self.Recruitmentareabtn.isHidden = true
            self.Recruitmentarealabel.isHidden = true
            self.Studyarealabel.isHidden = true
            self.StudyCafesearchbar.isHidden = true
            self.StudyCafeExamplelabel.isHidden = true
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.OnlineCheckbtn.setImage(UIImage(named: "RedCheck@1x.png"), for: .selected)
                    self.OnlineCheckbtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.OnlineCheckbtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.StudyKindInfolabel.translatesAutoresizingMaskIntoConstraints = false
                    self.StudyKindInfoTopconstraint.constant = -260
                    self.StudyKindInfolabel.layoutIfNeeded()
                }
            })
        }
    }
    
    @objc
    func AddRecruitAreaView() {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.EnrollMentContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.EnrollMentContainerView.frame = self.view.frame
        self.RecruitAreaUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2.0)
        window?.addSubview(self.EnrollMentContainerView)
        window?.addSubview(self.RecruitAreaUserView)
        self.RecruitAreaUserView.layer.cornerRadius = 15
        self.RecruitAreaUserView.layer.masksToBounds = true
        self.RecruitAreaUserView.RecruitTitlelabel.text = "모집 지역"
        self.RecruitAreaUserView.RecruitTitlelabel.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        self.RecruitAreaUserView.RecruitAreaBtn.layer.borderWidth = 1
        self.RecruitAreaUserView.RecruitAreaBtn.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        self.RecruitAreaUserView.RecruitAreaBtn.layer.cornerRadius = 4
        self.RecruitAreaUserView.RecruitAreaBtn.layer.masksToBounds = true
        self.RecruitAreaUserView.RecruitAreaBtn.setTitle("서울 강남구", for: .normal)
        self.RecruitAreaUserView.RecruitAreaBtn.setTitleColor(UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0), for: .normal)
        self.RecruitAreaUserView.RecruitAreaBtn1.layer.cornerRadius = 4
        self.RecruitAreaUserView.RecruitAreaBtn1.layer.masksToBounds = true
        self.RecruitAreaUserView.RecruitAreaBtn1.setTitle("서울 강동구", for: .normal)
        self.RecruitAreaUserView.RecruitAreaBtn1.setTitleColor(UIColor.white, for: .normal)
        self.RecruitAreaUserView.RecruitAreaBtn1.backgroundColor = UIColor(red: 123/255, green: 120/255, blue: 255/255, alpha: 1.0)
        self.RecruitAreaUserView.RecruitExamplelabel.text = "내 지역은 ‘마이페이지’에서 변경할 수 있어요."
        self.RecruitAreaUserView.RecruitExamplelabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.RecruitAreaUserView.RecruitConfirmBtn.setTitle("확인", for: .normal)
        self.RecruitAreaUserView.RecruitConfirmBtn.setTitleColor(UIColor.white, for: .normal)
        self.RecruitAreaUserView.RecruitConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.RecruitAreaUserView.RecruitConfirmBtn.layer.cornerRadius = 8
        self.RecruitAreaUserView.RecruitConfirmBtn.layer.masksToBounds = true
        self.RecruitAreaUserView.RecruitConfirmBtn.addTarget(self, action: #selector(self.RemoveRecruitAreaConfirmBtn(_:)), for: .touchUpInside)
        let RecruitAreaTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.RemoveFromRecruitAreaView(recognizer:)))
        self.EnrollMentContainerView.addGestureRecognizer(RecruitAreaTapGesture)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0.5
            self.RecruitAreaUserView.frame = CGRect(x: 0, y: screenSize.height / 1.9 + self.view.safeAreaInsets.bottom, width: screenSize.width, height: self.RecruitAreaUserView.frame.size.height)
        }, completion: nil)
        
    }
    
    @objc
    func RemoveRecruitAreaConfirmBtn(_ sender : UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.RecruitAreaUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.9)
            self.navigationItem.hidesBackButton = false
        }, completion: nil)
    }
    
    @objc
    func RemoveFromRecruitAreaView(recognizer: UITapGestureRecognizer) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.RecruitAreaUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.9)
            self.navigationItem.hidesBackButton = false
        }, completion: nil)
    }
    
    @objc
    func AddInterestingView() {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.EnrollMentContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.EnrollMentContainerView.frame = self.view.frame
        self.InterestingUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.5)
        window?.addSubview(self.EnrollMentContainerView)
        window?.addSubview(self.InterestingUserView)
        self.navigationItem.hidesBackButton = true
        self.InterestingUserView.layer.cornerRadius = 15
        self.InterestingUserView.layer.masksToBounds = true
        self.InterestingUserView.InterestingTitlelabel.text = "내 관심 스터디"
        self.InterestingUserView.InterestingTitlelabel.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        self.InterestingUserView.InterestingUserBtn.layer.cornerRadius = 4
        self.InterestingUserView.InterestingUserBtn.layer.masksToBounds = true
        self.InterestingUserView.InterestingUserBtn.layer.borderWidth = 1
        self.InterestingUserView.InterestingUserBtn.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        self.InterestingUserView.InterestingUserBtn.setTitle("요리 > 제빵", for: .normal)
        self.InterestingUserView.InterestingUserBtn.setTitleColor(UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0), for: .normal)
        self.InterestingUserView.InterestingUserBtn1.setTitle("프로그래밍 > 앱개발", for: .normal)
        self.InterestingUserView.InterestingUserBtn1.setTitleColor(UIColor.white, for: .normal)
        self.InterestingUserView.InterestingUserBtn1.backgroundColor = UIColor(red: 123/255, green: 120/255, blue: 255/255, alpha: 1.0)
        self.InterestingUserView.InterestingUserBtn1.layer.cornerRadius = 4
        self.InterestingUserView.InterestingUserBtn1.layer.masksToBounds = true
        self.InterestingUserView.InterestingUserBtn2.layer.cornerRadius = 4
        self.InterestingUserView.InterestingUserBtn2.layer.masksToBounds = true
        self.InterestingUserView.InterestingUserBtn2.layer.borderWidth = 1
        self.InterestingUserView.InterestingUserBtn2.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        self.InterestingUserView.InterestingUserBtn2.setTitle("어학 > 토익", for: .normal)
        self.InterestingUserView.InterestingUserBtn2.setTitleColor(UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0), for: .normal)
        self.InterestingUserView.InterestingExamplelabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.InterestingUserView.InterestingExamplelabel.attributedText = NSAttributedString(string: "내 관심 스터디는 ‘마이페이지’에서 변경할 수 있어요.", attributes: [NSAttributedString.Key.kern : -0.55])
        self.InterestingUserView.InterestingConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.InterestingUserView.InterestingConfirmBtn.setTitle("확인", for: .normal)
        self.InterestingUserView.InterestingConfirmBtn.setTitleColor(UIColor.white, for: .normal)
        self.InterestingUserView.InterestingConfirmBtn.layer.cornerRadius = 8
        self.InterestingUserView.InterestingConfirmBtn.layer.masksToBounds = true
        let InterestingViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.RemoveFromInterestingView(recognizer:)))
        self.EnrollMentContainerView.addGestureRecognizer(InterestingViewGesture)
        self.InterestingUserView.InterestingConfirmBtn.addTarget(self, action: #selector(self.InterestingConfirmBtn(_:)), for: .touchUpInside)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0.5
            self.InterestingUserView.frame = CGRect(x: 0, y: screenSize.height / 2.5 + self.view.safeAreaInsets.bottom, width: screenSize.width, height: self.InterestingUserView.frame.size.height)
        }, completion: nil)
    }
    
    @objc
    func InterestingConfirmBtn(_ sender : UIButton){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.InterestingUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2.5)
            self.navigationItem.hidesBackButton = false
        }, completion: nil)
    }
    
    @objc
    func RemoveFromInterestingView(recognizer: UITapGestureRecognizer){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.InterestingUserView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2.5)
            self.navigationItem.hidesBackButton = false
        }, completion: nil)
    }
    
    @objc
    private func LastMonthPickerView(){
        let FirstCalendarwindow = UIApplication.shared.windows.first
        if let FirstCalendardisappear = FirstCalendarwindow?.viewWithTag(5) {
            FirstCalendardisappear.removeFromSuperview()
        }
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.EnrollMentContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.EnrollMentContainerView.frame = self.view.frame
        self.ProcessMonthView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.2)
        window?.addSubview(self.EnrollMentContainerView)
        window?.addSubview(self.ProcessMonthView)
        self.ProcessMonthView.layer.cornerRadius = 20
        self.ProcessMonthView.layer.masksToBounds = true
        self.ProcessMonthView.ProcessPickerView.delegate = self
        self.ProcessMonthView.ProcessPickerView.tag = 2
        self.ProcessMonthView.ProcessViewTitlelabel.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        self.ProcessMonthView.ProcessViewTitlelabel.textAlignment = .left
        self.ProcessMonthView.ProcessViewConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.ProcessMonthView.ProcessViewConfirmBtn.setTitleColor(UIColor.white, for: .normal)
        self.ProcessMonthView.ProcessViewConfirmBtn.setTitle("확인", for: .normal)
        self.ProcessMonthView.ProcessViewConfirmBtn.layer.cornerRadius = 8
        self.ProcessMonthView.ProcessViewConfirmBtn.layer.masksToBounds = true
        self.EnrollMentContainerView.alpha = 0
        let MonthViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.RemoveMonthView(_:)))
        self.EnrollMentContainerView.addGestureRecognizer(MonthViewTapGesture)
        self.ProcessMonthView.ProcessViewConfirmBtn.addTarget(self, action: #selector(self.MonthConfirmBtn(_:)), for: .touchUpInside)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0.5
            self.ProcessMonthView.frame = CGRect(x: 0, y: screenSize.height / 2.5 + self.view.safeAreaInsets.bottom, width: screenSize.width, height: self.ProcessMonthView.frame.size.height)
        }, completion: nil)
        
    }
    
    @objc
    public func MonthConfirmBtn(_ sender : UIButton) {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.ProcessMonthView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2.5)
        }, completion: nil)
    }
    
    @objc
    public func RemoveMonthView(_ recognizer: UITapGestureRecognizer){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.EnrollMentContainerView.alpha = 0
            self.ProcessMonthView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2.5)
        }, completion: nil)
    }
    
    @objc
    public func ScrollViewHideKeyboard(recognizer: UITapGestureRecognizer){
        self.Studymeettextview.resignFirstResponder()
        self.Studygoaltextview.resignFirstResponder()
        self.StudyIntroducetextview.resignFirstResponder()
    }
    
    
    
    @objc
    public func setFSCalendarLayoutInit(){
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.FirstDateCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
        self.FirstDateCalendar.appearance.headerDateFormat = "YYYY. MM"
        self.FirstDateCalendar.appearance.headerTitleFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        self.FirstDateCalendar.appearance.headerTitleColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.FirstDateCalendar.appearance.weekdayTextColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.FirstDateCalendar.layer.borderWidth = 1.0
        self.FirstDateCalendar.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.FirstDateCalendar.appearance.selectionColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.FirstDateCalendar.appearance.todayColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.FirstDateCalendar.calendarWeekdayView.addBottomBorder(with: UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), andWidth: 1)
        self.FirstDateCalendar.layer.cornerRadius = 8
        self.FirstDateCalendar.layer.shadowColor = UIColor.darkGray.cgColor
        self.FirstDateCalendar.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.FirstDateCalendar.layer.shadowOpacity = 0.2
        self.FirstDateCalendar.layer.shadowRadius = 4.0
        self.FirstDateCalendar.layer.masksToBounds = true
        self.FirstDateCalendar.appearance.weekdayFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.FirstDateCalendar.appearance.headerTitleFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        self.FirstDateCalendar.locale = Locale(identifier: "ko_KR")
        self.FirstDateCalendar.allowsMultipleSelection = false
        self.FirstDateCalendar.tag = 5
        self.FirstDateCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        self.FirstDateCalendar.headerHeight = 68
        self.FirstDateCalendar.calendarWeekdayView.frame = CGRect(x: self.FirstDateCalendar.calendarWeekdayView.frame.origin.x, y: self.FirstDateCalendar.calendarWeekdayView.frame.origin.y - 50, width: self.FirstDateCalendar.calendarWeekdayView.frame.size.width, height: self.FirstDateCalendar.calendarWeekdayView.frame.size.height)
        let FirstCalendarBtn = UIButton(frame: CGRect(x: 20, y: 26, width: 8, height: 20))
        FirstCalendarBtn.setTitle("", for: .normal)
        FirstCalendarBtn.setImage(UIImage(named: "Navigation.png"), for: .normal)
        FirstCalendarBtn.tintColor = UIColor.black
        FirstCalendarBtn.addTarget(self, action: #selector(self.MoveMonthFirstCalendar), for: .touchUpInside)
        self.FirstDateCalendar.addSubview(FirstCalendarBtn)
        window?.addSubview(self.FirstDateCalendar)
        let RemoveCalendartapGesture = UITapGestureRecognizer(target: self, action: #selector(EnrollMentViewController.RemoveFristCalendarTapgestureCalendar(recognizer:)))
        self.EnrollMentscrollview.addGestureRecognizer(RemoveCalendartapGesture)
        self.FirstDateCalendar.frame = CGRect(x: 0, y: screenSize.height, width: 300, height: 300)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.FirstDateCalendar.frame = CGRect(x: 20, y: screenSize.height - screenSize.height / 1.6, width: 340, height: 300)

        }, completion: nil)
    }
    
    
    @objc
    func MoveMonthFirstCalendar(){
        let Month = self.FirstDateCalendar.currentPage
        let CalendarDate = Calendar(identifier: .gregorian)
        let RemoveMonth : Date? = CalendarDate.date(byAdding: .month, value: -1, to: Month)
        self.FirstDateCalendar.setCurrentPage(RemoveMonth!, animated: true)
    }
        
    @objc
    func RemoveFristCalendarTapgestureCalendar(recognizer: UITapGestureRecognizer) {
        let FirstCalendarwindow = UIApplication.shared.windows.first
        if let FirstCalendar = FirstCalendarwindow?.viewWithTag(5){
            FirstCalendar.removeFromSuperview()
        }
    }
    
    @objc
    func FirstComeBtnCheck(_ sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
            self.ReviewBtn.isSelected = false
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.FirstComeBtn.setImage(UIImage(named: "RedCheck@1x.png"), for: .selected)
                    self.FirstComeBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.FirstComeBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            })
            
        }
    }
    
    @objc
    func ReviewBtnCheck(_ sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }else{
            sender.isSelected = true
            self.FirstComeBtn.isSelected = false
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.ReviewBtn.setImage(UIImage(named: "RedCheck@1x.png"), for: .selected)
                    self.ReviewBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.ReviewBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            })
        }
    }
    @objc
    func RemoveFromAreaToolbar() {
        self.Recruitmentareabtn.resignFirstResponder()
    }
    @objc
    func RemoveFromToolbar() {
        self.RecruitmentBtn.resignFirstResponder()
    }
    
    @objc
    func keyboardWillShow(_ notification : Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardViewEndFrame.height , right: 0.0)
        EnrollMentscrollview.contentInset = contentInsets
        EnrollMentscrollview.scrollIndicatorInsets = contentInsets
    }
    @objc
    func keyboardWillHide(_ notification : Notification) {
        let contentsInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        EnrollMentscrollview.contentInset = contentsInset
        EnrollMentscrollview.scrollIndicatorInsets = contentsInset
    }
    
    @objc
    func difficultyBtnSelect(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.StudyDiffcultybtn1.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn2.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn3.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn4.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultylabel1.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
            self.StepBarTextCheck()
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            print("difculrty1 클릭\(sender.isSelected)")
        } else {
            sender.isSelected = true
            print("difculrty1 클릭\(sender.isSelected)")
            self.StudyDiffcultybtn1.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel1.text!)"
            self.StudyUserDiffcultylabel.textAlignment = .right
            self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StudyDiffcultylabel1.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StepBarisCheck()
            self.StudyDiffcultyStepBar()
        }
    }
    
    
    @objc
    func difficultyBtnSelect2(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.StudyDiffcultybtn2.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn3.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultylabel2.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
            self.StepBarTextCheck()
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            print("difculrty2 클릭\(sender.isSelected)")
        } else {
            sender.isSelected = true
            print("difculrty2 클릭\(sender.isSelected)")
            self.StudyDiffcultybtn2.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel2.text!)"
            self.StudyUserDiffcultylabel.textAlignment = .right
            self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StepBarisCheck()
            self.StudyDiffcultyStepBar()
        }
    }
    
    @objc
    func difficultyBtnSelect3(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.StudyDiffcultybtn2.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn3.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultylabel3.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
            self.StepBarTextCheck()
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            print("difculrty3 클릭\(sender.isSelected)")
        } else {
            sender.isSelected = true
            print("difculrty3 클릭\(sender.isSelected)")
            self.StudyDiffcultybtn3.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel3.text!)"
            self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StudyUserDiffcultylabel.textAlignment = .right
            self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StepBarisCheck()
            self.StudyDiffcultyStepBar()
        }
    }
    
    @objc
    func difficultyBtnSelect4(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.StudyDiffcultybtn2.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn3.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultybtn4.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
            self.StudyDiffcultylabel4.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
            self.StepBarTextCheck()
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            print("difculrty4 클릭\(sender.isSelected)")
        } else {
            sender.isSelected = true
//            self.StudyDiffcultybtn3.isSelected = false
            print("difculrty4 클릭\(sender.isSelected)")
            self.StudyDiffcultybtn4.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel4.text!)"
            self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StudyUserDiffcultylabel.textAlignment = .right
            self.StudyDiffcultylabel4.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.StepBarisCheck()
            self.StudyDiffcultyStepBar()
        }
    }
    
    @objc
    func LimitPersonBtnSelect(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.LimitBtn.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.RecruitmentBtn.isEnabled = true
        } else {
            sender.isSelected = true
            self.LimitBtn.setImage(UIImage(named: "squarebox.png"), for: .selected)
            self.RecruitmentBtn.isEnabled = false
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.LimitBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.LimitBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            })
        }
    }
    
    @objc
    func LimitDateBtnSelect1(_ sender : UIButton) {
        if  sender.isSelected {
            sender.isSelected = false
            self.Limitbtn2.setImage(UIImage(named: "Rectangle.png"), for: .normal)
            self.Studystartdatebtn.isEnabled = true
            self.Studylastdatebtn.isEnabled = true
        } else {
            sender.isSelected = true
            self.Limitbtn2.setImage(UIImage(named: "squarebox.png"), for: .selected)
            self.Studystartdatebtn.isEnabled = false
            self.Studylastdatebtn.isEnabled = false
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.25/0.5, relativeDuration: 0.5/0.5) {
                    self.Limitbtn2.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5/0.5, relativeDuration: 0.5/0.5) {
                    self.Limitbtn2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            })
        }
    }
    
    
    private func StudyDiffcultyStepBar(){
        if self.StudyDiffcultybtn1.isSelected == true {
            self.StudyDiffcultybtn1.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            if self.StudyDiffcultybtn1.isSelected == true  && self.StudyDiffcultybtn2.isSelected == true{
                self.StudyDiffcultybtn3.isSelected = false
                self.StudyDiffcultybtn4.isSelected = false
                self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn2.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyDiffcultybtn3.setImage(UIImage(named: "GrayEllipse.png"), for: .normal)
                self.StudyDiffcultylabel1.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel1.text!) ~ \(self.StudyDiffcultylabel2.text!)"
                self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultybtn1.setNeedsLayout()
                self.StudyDiffcultybtn2.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn2.frame.origin.x - self.StudyDiffcultybtn1.frame.origin.x,2)))
            }else if self.StudyDiffcultybtn1.isSelected == true && self.StudyDiffcultybtn3.isSelected == true {
                self.StudyDiffcultybtn2.isSelected = false
                self.StudyDiffcultybtn4.isSelected = false
                self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn2.setImage(UIImage(named: "RedEllipse.png"), for: .normal)
                self.StudyDiffcultybtn3.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel1.text!) ~ \(self.StudyDiffcultylabel3.text!)"
                self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel1.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultybtn1.setNeedsLayout()
                self.StudyDiffcultybtn2.setNeedsLayout()
                self.StudyDiffcultybtn3.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn3.frame.origin.x - self.StudyDiffcultybtn1.frame.origin.x, 2)))
            }else if self.StudyDiffcultybtn1.isSelected == true && self.StudyDiffcultybtn4.isSelected == true{
                self.StudyDiffcultybtn2.isSelected = false
                self.StudyDiffcultybtn3.isSelected = false
                self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn2.setImage(UIImage(named: "RedEllipse.png"), for: .normal)
                self.StudyDiffcultybtn3.setImage(UIImage(named: "RedEllipse.png"), for: .normal)
                self.StudyDiffcultybtn4.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel1.text!) ~ \(self.StudyDiffcultylabel4.text!)"
                self.StudyDiffcultylabel1.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultybtn1.setNeedsLayout()
                self.StudyDiffcultybtn2.setNeedsLayout()
                self.StudyDiffcultybtn3.setNeedsLayout()
                self.StudyDiffcultybtn4.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn4.frame.origin.x - self.StudyDiffcultybtn1.frame.origin.x, 2)))
            }
        }else if self.StudyDiffcultybtn2.isSelected == true {
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            if self.StudyDiffcultybtn2.isSelected == true && self.StudyDiffcultybtn3.isSelected == true{
                self.StudyDiffcultybtn1.isSelected = false
                self.StudyDiffcultybtn4.isSelected = false
                self.StudyDiffcultybtn2.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn3.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel2.text!) ~ \(self.StudyDiffcultylabel3.text!)"
                self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel1.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultybtn2.setNeedsLayout()
                self.StudyDiffcultybtn3.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn2.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn3.frame.origin.x, 2)))
            }else if self.StudyDiffcultybtn2.isSelected == true && self.StudyDiffcultybtn4.isSelected == true {
                self.StudyDiffcultybtn1.isSelected = false
                self.StudyDiffcultybtn3.isSelected = false
                self.StudyDiffcultybtn2.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn3.setImage(UIImage(named: "RedEllipse.png"), for: .normal)
                self.StudyDiffcultybtn4.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel2.text!) ~ \(self.StudyDiffcultylabel4.text!)"
                self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel1.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultybtn2.setNeedsLayout()
                self.StudyDiffcultybtn3.setNeedsLayout()
                self.StudyDiffcultybtn4.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn2.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn4.frame.origin.x, 2)))
            }
        }else if self.StudyDiffcultybtn3.isSelected == true {
            self.StudyDiffcultyView.layer.sublayers = nil
            self.StudyDiffcultyView.layer.setNeedsDisplay()
            if self.StudyDiffcultybtn3.isSelected == true && self.StudyDiffcultybtn4.isSelected == true{
                self.StudyDiffcultybtn1.isSelected = false
                self.StudyDiffcultybtn2.isSelected = false
                self.StudyDiffcultybtn3.setImage(UIImage(named: "Group.png"), for: .selected)
                self.StudyDiffcultybtn4.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                self.StudyUserDiffcultylabel.text = "\(self.StudyDiffcultylabel3.text!) ~ \(self.StudyDiffcultylabel4.text!)"
                self.StudyUserDiffcultylabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel3.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel4.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
                self.StudyDiffcultylabel1.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultylabel2.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
                self.StudyDiffcultybtn3.setNeedsLayout()
                self.StudyDiffcultybtn4.setNeedsLayout()
                self.difficultyStepBar(move: self.StudyDiffcultybtn3.frame.origin.x, addLine: sqrt(pow(self.StudyDiffcultybtn4.frame.origin.x, 2)))
            }
        }
    }
    
    private func StepBarTextCheck() {
        if self.StudyDiffcultybtn2.image(for: .normal)!.pngData() == UIImage(named: "GrayEllipse.png")!.pngData() {
            self.StudyDiffcultylabel2.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        }
        if self.StudyDiffcultybtn3.image(for: .normal)!.pngData() == UIImage(named: "GrayEllipse.png")!.pngData() {
            self.StudyDiffcultylabel3.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        }
        
    }
    
    private func StepBarisCheck(){
        if self.StudyDiffcultybtn2.image(for: .normal)!.pngData() == UIImage(named: "RedEllipse.png")!.pngData() {
            self.StudyDiffcultybtn2.isSelected = false
        }
        if self.StudyDiffcultybtn3.image(for: .normal)!.pngData() == UIImage(named: "RedEllipse.png")!.pngData() {
            self.StudyDiffcultybtn3.isSelected = false
        }
    }
    
    private func difficultyStepBar(move x:CGFloat, addLine x2: CGFloat) {
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        path.move(to: CGPoint(x: x, y: 2))
        path.addLine(to: CGPoint(x: x2, y: 2))
        layer.path = path.cgPath
        layer.lineWidth = 5
        layer.strokeColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.25
        layer.add(animation, forKey: "StepBarAnimation")
        self.StudyDiffcultyView.layer.addSublayer(layer)
        self.StudyDiffcultyView.layoutIfNeeded()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.StudyCategoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let StudyCategoryCell = tableView.dequeueReusableCell(withIdentifier: "StudyCategoryCell", for: indexPath) as? StudyCategoryTableViewCell
        StudyCategoryCell?.StudyLabel.text = self.StudyCategoryModel[indexPath.row].name
        return StudyCategoryCell!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.RecruitmentBtn.setTitle(PickerData[row], for: .normal)
        } else {
            self.Studylastdatebtn.setTitle(MonthPickerData[row], for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            if MonthPickerData[row] == "1개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +1, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "2개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +2, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "3개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +3, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "4개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +4, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "5개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +5, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "6개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +6, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "7개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +7, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "8개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +8, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "9개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +9, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "10개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +10, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "11개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +11, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            } else if MonthPickerData[row] == "12개월" {
                let CalendarData = Calendar(identifier: .gregorian)
                self.LastDate = CalendarData.date(byAdding: .month, value: +12, to: self.FirstDate!)
                self.LastDate = self.LastDate!.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
                UserDefaults.standard.set(dateFormatter.string(from: self.LastDate!), forKey: "LastDate")
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return PickerData.count
        } else {
            return MonthPickerData.count
        }
       
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return PickerData[row].trimmingCharacters(in: .whitespaces)
        } else {
            return MonthPickerData[row].trimmingCharacters(in: .whitespaces)
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        var textparagraphStyle = NSMutableParagraphStyle()
        textparagraphStyle.lineHeightMultiple = 1.15
        if textView.tag == 1 && textView.text == "텍스트를 입력하세요" {
            self.Studymeettextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.Studymeettextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern:-0.88, NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        } else if textView.tag == 2 && textView.text == "텍스트를 입력하세요" {
            self.Studygoaltextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.Studygoaltextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.88,NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        } else if textView.tag == 3 && textView.text == "텍스트를 입력하세요"{
            self.StudyIntroducetextview.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.StudyIntroducetextview.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.88,NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)])
        }
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        var textparagraphStyle = NSMutableParagraphStyle()
        textparagraphStyle.lineHeightMultiple = 1.15
        if textView.tag == 1 && textView.text == "" {
            self.Studymeettextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.kern:-0.88, NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor : UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        } else if textView.tag == 2 && textView.text == "" {
            self.Studygoaltextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
        } else if textView.tag == 3 && textView.text == "" {
            self.StudyIntroducetextview.attributedText = NSAttributedString(string: "텍스트를 입력하세요", attributes: [NSAttributedString.Key.paragraphStyle:textparagraphStyle,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)])
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 1 {
            self.Studymeettextcountlabel.text = "\(self.Studymeettextview.text.count) / 20"
        } else if textView.tag == 2{
            self.Studygoaltextcountlabel.text = "\(self.Studygoaltextview.text.count) / 60"
        } else if textView.tag == 3{
            self.StudyIntroducecountlabel.text = "\(self.StudyIntroducetextview.text.count) / 1000"
        }
        if self.Studymeettextview.text.count >= 2 && self.Studygoaltextview.text.count >= 2 && self.StudyIntroducetextview.text.count >= 20 {
            self.Studypostbtn.isEnabled = true
            self.Studypostbtn.setTitleColor(UIColor.white, for: .normal)
            self.Studypostbtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        } else {
            self.Studypostbtn.isEnabled = false
            self.Studypostbtn.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1.0), for: .normal)
            self.Studypostbtn.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        }
        if self.Studymeettextview.text.count < 2 {
            self.Studymeettextview.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
            self.Studymeetnamelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudymeetExamplelabel.attributedText = NSAttributedString(string: "마감 일시는 시작 일시보다 뒤로 설정해주세요.", attributes: [NSAttributedString.Key.kern : -0.66])
            self.StudymeetExamplelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudymeetExamplelabel.isHidden = false
        } else {
            self.Studymeettextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
            self.Studymeetnamelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.StudymeetExamplelabel.isHidden = true
        }
        if self.Studygoaltextview.text.count < 2  {
            self.Studygoaltextview.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
            self.Studygoalnamelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudygoalExamplelabel.attributedText = NSAttributedString(string: "목표가 너무 짧습니다. ( 2자~ 60자 )", attributes: [NSAttributedString.Key.kern : -0.66])
            self.StudygoalExamplelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudygoalExamplelabel.isHidden = false
        } else {
            self.Studygoaltextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
            self.Studygoalnamelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.StudygoalExamplelabel.isHidden = true
        }
        if self.StudyIntroducetextview.text.count < 20 {
            self.StudyIntroducetextview.layer.borderColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0).cgColor
            self.StudyIntroducenamelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudyIntroduceExamplelabel.attributedText = NSAttributedString(string: "스터디 소개가 너무 짧습니다. ( 20자~ 1000자 )", attributes: [NSAttributedString.Key.kern : -0.66])
            self.StudyIntroduceExamplelabel.textColor = UIColor(red: 237/255, green: 65/255, blue: 65/255, alpha: 1.0)
            self.StudyIntroduceExamplelabel.isHidden = false
        } else {
            self.StudyIntroducetextview.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
            self.StudyIntroducenamelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
            self.StudyIntroduceExamplelabel.isHidden = true
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.tag == 1{
            let currentText = textView.text ?? ""
            guard let StringRange = Range(range, in: currentText) else { return false }
            let changedText = currentText.replacingCharacters(in: StringRange, with: text)
            
            return changedText.count <= 20
        } else if textView.tag == 2{
            let cureentText2 = textView.text ?? ""
            guard let StringRange = Range(range, in: cureentText2) else { return false }
            let changedText = cureentText2.replacingCharacters(in: StringRange, with: text)
            
            return changedText.count <= 60
        } else if textView.tag == 3{
            let cureentText3 = textView.text ?? ""
            guard let StringRange = Range(range, in: cureentText3) else {return false}
            let changeText = cureentText3.replacingCharacters(in: StringRange, with: text)
            
            return changeText.count <= 1000
        }
        return true
    }
    
    
}




class PickerButton : UIButton {
    var PickerView = UIView()
    var PickerToolView = UIView()
    
    override var inputView: UIView {
        get {
            return self.PickerView
        }set {
            self.PickerView = newValue
            self.becomeFirstResponder()
        }
    }
    override var inputAccessoryView: UIView {
        get {
            return self.PickerToolView
        }set {
            self.PickerToolView = newValue
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
}


class ProcessView : UIView {
    @IBOutlet weak var ProcessPickerView: UIPickerView!
    @IBOutlet weak var ProcessViewTitlelabel: UILabel!
    @IBOutlet weak var ProcessViewConfirmBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class InterestingView : UIView {
    @IBOutlet weak var InterestingTitlelabel: UILabel!
    @IBOutlet weak var InterestingUserBtn: UIButton!
    @IBOutlet weak var InterestingUserBtn1: UIButton!
    @IBOutlet weak var InterestingUserBtn2: UIButton!
    @IBOutlet weak var InterestingExamplelabel: UILabel!
    @IBOutlet weak var InterestingConfirmBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class RecruitAreaView : UIView {
    @IBOutlet weak var RecruitTitlelabel: UILabel!
    @IBOutlet weak var RecruitAreaBtn: UIButton!
    @IBOutlet weak var RecruitAreaBtn1: UIButton!
    @IBOutlet weak var RecruitExamplelabel: UILabel!
    @IBOutlet weak var RecruitConfirmBtn: UIButton!
    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



extension EnrollMentViewController : FSCalendarDataSource,FSCalendarDelegate {
    public func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let dateCell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        return dateCell
        
    }
    
    public func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPage)
        let currnetPageSet = calendar.setCurrentPage(currentPage, animated: true)
    }
    
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        if let FirstDidSelect = calendar.viewWithTag(5) {
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            UserDefaults.standard.set(dateFormatter.string(from: self.FirstDate!), forKey: "StartDate")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            self.FirstDateCalendar.today = self.FirstDate
            
        }
        print("선택 해체 했습니다 \(date)")
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let FirstCalendar = calendar.viewWithTag(5) {
            let dateFormatter = DateFormatter()
            self.FirstDate = date.addingTimeInterval(TimeInterval(NSTimeZone.local.secondsFromGMT()))
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            UserDefaults.standard.set(dateFormatter.string(from: self.FirstDate!), forKey: "StartDate")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            self.FirstDateCalendar.today = self.FirstDate
            self.FirstDateCalendar.allowsMultipleSelection = false
            self.FirstDateCalendar.appearance.todayColor = UIColor.white
            self.FirstDateCalendar.appearance.titleTodayColor = UIColor.black
            print("StudyStartDate\(FirstDate)")
            self.Studystartdatebtn.setTitle("\(dateFormatter.string(from: self.FirstDate!))", for: .normal)
        }
    }
}

extension UIView {
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        self.addSubview(border)
    }
}
