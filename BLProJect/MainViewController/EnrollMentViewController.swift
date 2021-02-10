//
//  EnrollMentViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/30.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class EnrollMentViewController: UIViewController, UIScrollViewDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet var StudyCategoryView: StudyCategoryView!
    @IBOutlet weak var StudyCategorytableview: UITableView!
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
    @IBOutlet weak var Studypostbtn: UIButton!
    @IBOutlet weak var StudyKindInfoTopconstraint: NSLayoutConstraint!
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
    @IBAction func Createareapickerview(_ sender: PickerButton) {
        let pickerView = UIPickerView()
        let pickerToolbar = UIToolbar()
        let pickerToolbarbutton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(RemoveFromAreaToolbar))
        let pickerToolbarFiexed = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerView.delegate = self
        pickerView.tag = 2
        pickerToolbar.sizeToFit()
        pickerToolbar.barTintColor = UIColor.darkGray
        pickerToolbar.tintColor = UIColor.white
        pickerToolbar.isUserInteractionEnabled = true
        pickerToolbar.setItems([pickerToolbarFiexed,pickerToolbarbutton], animated: false)
        sender.inputAccessoryView = pickerToolbar
        sender.inputView = pickerView
    }
    let PickerData = ["1 명","2 명","3 명","4 명","5 명","6 명","7 명","8 명","9 명","10 명"]
    public var StudyCategoryModel = [StudyContentsContainer]()
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
        self.StudyCategorytableview.delegate = self
        self.StudyCategorytableview.dataSource = self
        let nibCell = UINib(nibName: "StudyCategoryTableViewCell", bundle: nil)
        self.StudyCategorytableview.register(nibCell, forCellReuseIdentifier: "StudyCategoryCell")
        UtilApi.shared.UtilStudyCategoryCall { result in
            self.StudyCategoryModel = result
            self.StudyCategorytableview.reloadData()
        }
        self.ReviewBtn.addTarget(self, action: #selector(self.ReviewBtnCheck(_:)), for: .touchUpInside)
        self.FirstComeBtn.addTarget(self, action: #selector(self.FirstComeBtnCheck(_:)), for: .touchUpInside)
        self.OfflineCheckbtn.addTarget(self, action: #selector(self.OfflineBtnCheck), for: .touchUpInside)
        self.OnlineCheckbtn.addTarget(self, action: #selector(self.OnlineBtnCheck(_:)), for: .touchUpInside)
        self.StudyKindInfobtn.addTarget(self, action: #selector(self.AddCategoryView), for: .touchUpInside)
        self.StudyDiffcultybtn1.addTarget(self, action: #selector(self.difficultyBtnSelect(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn2.addTarget(self, action: #selector(self.difficultyBtnSelect2(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn3.addTarget(self, action: #selector(self.difficultyBtnSelect3(_:)), for: .touchUpInside)
        self.StudyDiffcultybtn4.addTarget(self, action: #selector(self.difficultyBtnSelect4(_:)), for: .touchUpInside)
        let Tapgesture = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod(sender:)))
        Tapgesture.numberOfTapsRequired = 1
        Tapgesture.cancelsTouchesInView = false
        Tapgesture.isEnabled = true
        EnrollMentscrollview.addGestureRecognizer(Tapgesture)
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
        self.Studypostbtn.layer.cornerRadius = 8
        self.Studypostbtn.layer.masksToBounds = true
        self.Studypostbtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
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
    @objc func OnlineBtnCheck(_ sender: UIButton){
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
    
    @objc func AddCategoryView() {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.StudyCategoryView.HandlerAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.StudyCategoryView.HandlerAreaView.frame = self.view.frame
        self.StudyCategorytableview.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.8)
        self.StudyCategoryView.HeaderView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 50)
        self.StudyCategoryView.ConfirmBtn.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.85, width: self.StudyCategorytableview.frame.size.width, height: 90)
        self.StudyCategoryView.ConfirmBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
        self.StudyCategoryView.ConfirmBtn.setAttributedTitle(NSAttributedString(string: "완료", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16)]), for: .normal)
        self.StudyCategoryView.Headerlabel.attributedText = NSAttributedString(string: "스터디 종류", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-SemiBold",size: 16),NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)])
        self.StudyCategorytableview.isScrollEnabled = false
        self.StudyCategoryView.ConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyCategoryView.Headerlabel.frame = CGRect(x: self.StudyCategoryView.Headerlabel.frame.origin.x, y: self.StudyCategoryView.Headerlabel.frame.origin.y, width: self.StudyCategoryView.Headerlabel.frame.size.width, height: self.StudyCategoryView.Headerlabel.frame.size.height)
        self.StudyCategoryView.Headerlabel.textAlignment = .left
        self.StudyCategoryView.ConfirmBtn.tintColor = UIColor.white
        self.StudyCategoryView.ConfirmBtn.layer.masksToBounds = true
        window?.addSubview(self.StudyCategoryView.HandlerAreaView)
        window?.addSubview(self.StudyCategorytableview)
        window?.addSubview(self.StudyCategoryView.HeaderView)
        self.StudyCategoryView.HeaderView.addSubview(self.StudyCategoryView.Headerlabel)
        self.StudyCategorytableview.addSubview(self.StudyCategoryView.ConfirmBtn)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.RemoveFromCategoryView(recognizer:)))
        self.StudyCategoryView.HandlerAreaView.addGestureRecognizer(tapGesture)
        self.StudyCategoryView.ConfirmBtn.addTarget(self, action: #selector(self.ConfirmRemoveCategoryView(_:)), for: .touchUpInside)
        self.StudyCategoryView.HandlerAreaView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.StudyCategoryView.HandlerAreaView.alpha = 0.5
            self.StudyCategorytableview.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.8, width: screenSize.width, height: screenSize.height / 1.8)
            self.StudyCategoryView.HeaderView.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.65, width: screenSize.width, height: 50)
        }, completion: nil)
    }
    
    @objc func ConfirmRemoveCategoryView(_ sender : UIButton){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.StudyCategoryView.HandlerAreaView.alpha = 0
            self.StudyCategorytableview.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.8)
            self.StudyCategoryView.HeaderView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 50)
        }, completion: nil)
    }
    
    @objc func RemoveFromCategoryView(recognizer: UITapGestureRecognizer){
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.StudyCategoryView.HandlerAreaView.alpha = 0
            self.StudyCategorytableview.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.8)
            self.StudyCategoryView.HeaderView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 50)
        }, completion: nil)
    }
    
    @objc func FirstComeBtnCheck(_ sender : UIButton){
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
    
    @objc func ReviewBtnCheck(_ sender : UIButton){
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
    func difficultyBtnSelect(_ sender : UIButton) {
        if sender.tag == 1 {
            sender.isSelected = true
            self.StudyDiffcultybtn1.setImage(UIImage(named: "RedCheck.png"), for: .selected)
        }
    }
    
    
    func difficultyStepBar(move x:CGFloat, addLine x2: CGFloat) {
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
        animation.duration = 1
        layer.add(animation, forKey: "StepBarAnimation")
        self.StudyDiffcultyView.layer.addSublayer(layer)
    }
    
    @objc
    func difficultyBtnSelect2(_ sender : UIButton) {
        if sender.tag == 2 {
            sender.isSelected = true
            print("difculrty2 클릭\(sender.isSelected)")
        }
    }
    
    @objc
    func difficultyBtnSelect3(_ sender : UIButton) {
        if sender.tag == 3 {
            sender.isSelected = true
            print("difculrty3 클릭\(sender.isSelected)")
        }
    }
    
    @objc
    func difficultyBtnSelect4(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = true

        }
    }
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            var touchLocation: CGPoint = sender.location(in: self.StudyDiffcultyView)
            print("좌표 입니다 \(sender.location(in: self.StudyDiffcultyView))")
            if self.StudyDiffcultybtn1.isSelected == true {
                if self.StudyDiffcultybtn2.isSelected == true {
                    self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                    self.StudyDiffcultybtn2.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                    self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(touchLocation.x,2)))
                }else if self.StudyDiffcultybtn3.isSelected == true {
                    self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                    self.StudyDiffcultybtn2.setImage(UIImage(named: "RedEllipse.png"), for: .normal)
                    self.StudyDiffcultybtn3.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                    self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(touchLocation.x,2)))
                }else if self.StudyDiffcultybtn4.isSelected == true {
                    self.StudyDiffcultybtn1.setImage(UIImage(named: "Group.png"), for: .selected)
                    self.StudyDiffcultybtn2.setImage(UIImage(named: "RedEllipse.png"), for: .selected)
                    self.StudyDiffcultybtn3.setImage(UIImage(named: "RedEllipse.png"), for: .selected)
                    self.StudyDiffcultybtn4.setImage(UIImage(named: "Groupnext.png"), for: .selected)
                    self.difficultyStepBar(move: self.StudyDiffcultybtn1.frame.origin.x, addLine: sqrt(pow(touchLocation.x,2)))
                }
            }else if self.StudyDiffcultybtn2.isSelected == true{
                self.difficultyStepBar(move: self.StudyDiffcultybtn2.frame.origin.x, addLine: sqrt(pow(touchLocation.x, 2)))
            }else if self.StudyDiffcultybtn3.isSelected == true{
                self.difficultyStepBar(move: self.StudyDiffcultybtn3.frame.origin.x, addLine: sqrt(pow(touchLocation.x, 2)))
            }
        }
        self.view.endEditing(true)

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
        self.RecruitmentBtn.setTitle(PickerData[row], for: .normal)
            
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PickerData[row].trimmingCharacters(in: .whitespaces)
    }
    
    
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

class StudyCategoryView: UIView {
    @IBOutlet weak var HandlerAreaView: UIView!
    @IBOutlet weak var ConfirmBtn: UIButton!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var Headerlabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
