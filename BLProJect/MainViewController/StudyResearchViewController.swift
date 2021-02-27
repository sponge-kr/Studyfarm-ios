//
//  StudyResearchViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/19.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import Alamofire

class StudyResearchViewController: UIViewController,UITextViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var StudyResearchScrollview: UIScrollView!
    @IBOutlet weak var StudyResearchContentView: UIView!
    @IBOutlet weak var StudyTopicnamelabel: UILabel!
    @IBOutlet weak var StudyTopicLineView: UIView!
    @IBOutlet weak var StudyAreanamelabel: UILabel!
    @IBOutlet weak var StudyContentTitlelabel: UILabel!
    @IBOutlet weak var StudyCreateDatelabel: UILabel!
    @IBOutlet weak var StudyGoalView: UIView!
    @IBOutlet weak var StudyGoalViewlabel: UILabel!
    @IBOutlet weak var StudyGoalViewContentlabel: UILabel!
    @IBOutlet weak var StudyContentTextView: UITextView!
    @IBOutlet weak var StudyIntroduceView: UIView!
    @IBOutlet weak var StudyIntroducetitlelabel: UILabel!
    @IBOutlet weak var StudyProcesstitlelabel: UILabel!
    @IBOutlet weak var StudyProcessImageView: UIImageView!
    @IBOutlet weak var StudyTypeImageView: UIImageView!
    @IBOutlet weak var StudyTypetitlelabel: UILabel!
    @IBOutlet weak var StudyProcesscontentlabel: UILabel!
    @IBOutlet weak var StudyTypecontentlabel: UILabel!
    @IBOutlet weak var StudyAreaImageView: UIImageView!
    @IBOutlet weak var StudyAreatilelabel: UILabel!
    @IBOutlet weak var StudyUserImageView: UIImageView!
    @IBOutlet weak var StudyUsertitlelabel: UILabel!
    @IBOutlet weak var StudyUsercontentlabel: UILabel!
    @IBOutlet weak var StudyDefaultView: UIView!
    @IBOutlet weak var StudyRecruitmenttitlelabel: UILabel!
    @IBOutlet weak var StudyRecruitTypeImageView: UIImageView!
    @IBOutlet weak var StudyRecruitTypetitlelabel: UILabel!
    @IBOutlet weak var StudyRecruitTypecontentlabel: UILabel!
    @IBOutlet weak var StudyRecruitRankImageView: UIImageView!
    @IBOutlet weak var StudyRecruitRanktitlelabel: UILabel!
    @IBOutlet weak var StudyRecruitRankcontentlabel: UILabel!
    @IBOutlet weak var StudyRecruitDateImageView: UIImageView!
    @IBOutlet weak var StudyRecruitDatetitlelabel: UILabel!
    @IBOutlet weak var StudyRecruitcontentlabel: UILabel!
    @IBOutlet weak var StudyDetailTagButton: UIButton!
    @IBOutlet weak var StudyDetailTagButton2: UIButton!
    @IBOutlet weak var StudyleaderProfileView: UIView!
    @IBOutlet weak var StudyleaderProfileImageView: UIImageView!
    @IBOutlet weak var StudyleaderNicknamelabel: UILabel!
    @IBOutlet weak var StudyleaderIntroducelabel: UILabel!
    @IBOutlet weak var StudyCommentCountlabel: UILabel!
    @IBOutlet weak var StudyDetailReplyTableView: UITableView!
    @IBOutlet weak var StudyDetailApllyExamplelabel: UILabel!
    @IBOutlet weak var StudyDetailFavoritebtn: UIButton!
    @IBOutlet weak var StudyDetailConfirmbtn: UIButton!
    @IBOutlet weak var StudyDetailReplyViewmoreBtn: UIButton!
    @IBOutlet weak var StudyDetailApllylabelTopConstraint: NSLayoutConstraint!
    var Index: Int = 1
    var TagCount : Int = 0
    private var StudyDetailModel : StudyDetailResults?
    private var studyRepliesData = [RepliesContent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StudyContentTextView.delegate = self
        self.StudyResearchScrollview.isScrollEnabled = true
        self.StudyResearchScrollview.delegate = self
        self.StudyDetailReplyTableView.delegate = self
        self.StudyDetailReplyTableView.dataSource = self
        self.StudyDetailReplyTableView.estimatedRowHeight = UITableView.automaticDimension
        self.StudyDetailReplyTableView.rowHeight = 91
        self.StudyDetailReplyTableView.isScrollEnabled = false
        self.StudyDetailReplyTableView.isUserInteractionEnabled = false
        self.StudyIntroduceView.translatesAutoresizingMaskIntoConstraints = false
        let nibName = UINib(nibName: "StudyDetailRepliesTableViewCell", bundle: nil)
        self.StudyDetailReplyTableView.register(nibName, forCellReuseIdentifier: "ReplyCell")
        self.StudyDetailReplyTableView.separatorInset.right = 20
        self.StudyDetailReplyTableView.separatorInset.left = 20
        self.NavigationLayout()
        self.ConfrimLayoutInit()
        ServerApi.shared.StudyDetailCall(study_seq: Index) { result in
            DispatchQueue.main.async {
                self.StudyDetailModel = result
                self.setInitLayout()
                self.StepsIndexScribe()
                self.StudyTagLayout()
                self.StudyleaderSkillLevel()
            }
        }
        
        let RepliesParam : Parameters = [
            "size" : 10,
            "page" : 1
        ]
        RepliesApi.shared.StudyRepliesCall(study_seq: Index, RepliesParamter: RepliesParam) { result in
            DispatchQueue.main.async {
                self.studyRepliesData = result
                self.StudyDetailReplyTableView.reloadData()
                self.ReplyLayoutInit()
                print("댓글 데이터 체크 입니다\(self.studyRepliesData)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        print("스터디 댓글 테이블뷰 높이 값 입니다\(self.StudyDetailReplyTableView.contentSize.height)")
        self.StudyResearchScrollview.translatesAutoresizingMaskIntoConstraints = false
        self.StudyResearchScrollview.contentSize = CGSize(width: self.view.frame.size.width, height: self.StudyDetailConfirmbtn.frame.origin.y + self.StudyDetailConfirmbtn.frame.size.height + self.view.safeAreaInsets.bottom)
        self.StudyResearchScrollview.layoutIfNeeded()
        
    }
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.StudyTopicnamelabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    
    
    private func NavigationLayout() {
        let RightNavigationButton = UIBarButtonItem(image: UIImage(named: "modified.png"), style: .plain, target: self, action: nil)
        let NavigationAttribute = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)!]
        self.navigationItem.title = "그룹 탐색"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "NavigationBackbutton@1x.jpg")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "NavigationBackbutton@1x.jpg")
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = NavigationAttribute
        self.navigationItem.rightBarButtonItem = RightNavigationButton
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    public func setInitLayout() {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        self.StudyTopicnamelabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.topic_name)", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyTopicnamelabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.StudyTopicnamelabel.textAlignment = .left
        self.StudyTopicnamelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyTopicnamelabel.lineBreakMode = .byCharWrapping
        self.StudyAreanamelabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.state_name) \(self.StudyDetailModel!.city_name)", attributes: [NSAttributedString.Key.kern : -0.66])
        self.StudyAreanamelabel.textAlignment = .left
        self.StudyAreanamelabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.StudyAreanamelabel.lineBreakMode = .byCharWrapping
        self.StudyContentTitlelabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.title)", attributes: [NSAttributedString.Key.kern : -1.21])
        self.StudyContentTitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyContentTitlelabel.textAlignment = .left
        self.StudyContentTitlelabel.lineBreakMode = .byCharWrapping
        self.StudyCreateDatelabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.study_created_at_str) 조회 \(self.StudyDetailModel!.views)", attributes: [NSAttributedString.Key.kern : -0.55])
        self.StudyCreateDatelabel.lineBreakMode = .byCharWrapping
        self.StudyCreateDatelabel.textAlignment = .left
        self.StudyCreateDatelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyGoalView.layer.borderColor = UIColor.clear.cgColor
        self.StudyGoalView.layer.cornerRadius = 10
        self.StudyGoalView.layer.masksToBounds = true
        self.StudyGoalViewlabel.textColor = UIColor(red: 123/255, green: 120/255, blue: 255/255, alpha: 1.0)
        self.StudyGoalViewlabel.attributedText = NSAttributedString(string: "목표", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyGoalViewContentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyGoalViewContentlabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.objective)", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyGoalViewContentlabel.numberOfLines = 0
        self.StudyGoalViewlabel.lineBreakMode = .byCharWrapping
        self.StudyContentTextView.isEditable = false
        self.StudyContentTextView.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyContentTextView.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.content)", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)])
        self.StudyContentTextView.isScrollEnabled = false
        self.StudyContentTextView.sizeToFit()
        self.StudyContentTextView.translatesAutoresizingMaskIntoConstraints = true
        self.StudyIntroduceView.layer.borderWidth = 1
        self.StudyIntroduceView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0).cgColor
        self.StudyIntroducetitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyIntroducetitlelabel.textAlignment = .left
        self.StudyIntroducetitlelabel.attributedText = NSAttributedString(string: "스터디 진행 정보", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyProcesstitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyProcesstitlelabel.textAlignment = .left
        self.StudyProcesstitlelabel.attributedText = NSAttributedString(string: "진행 일정", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyProcessImageView.image = UIImage(named: "calendar.png")
        self.StudyProcessImageView.contentMode = .scaleAspectFill
        self.StudyTypeImageView.image = UIImage(named: "calendar.png")
        self.StudyTypeImageView.contentMode = .scaleAspectFill
        self.StudyTypetitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyTypetitlelabel.textAlignment = .left
        self.StudyTypetitlelabel.attributedText = NSAttributedString(string: "진행 유형", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyProcesscontentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        let startdate = self.StudyDetailModel!.start_date.replacingOccurrences(of: "-", with: ".", options: .literal, range: nil)
        let enddate = self.StudyDetailModel!.end_date.replacingOccurrences(of: "-", with: ".", options: .literal, range: nil)
        self.StudyProcesscontentlabel.attributedText = NSAttributedString(string: "\(startdate) ~ \(enddate)", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyTypetitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyTypecontentlabel.textAlignment = .left
        self.StudyTypecontentlabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.progress_type_str)", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyAreaImageView.image = UIImage(named: "calendar.png")
        self.StudyAreaImageView.contentMode = .scaleAspectFill
        self.StudyAreatilelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyAreatilelabel.textAlignment = .left
        self.StudyAreatilelabel.attributedText = NSAttributedString(string: "장소", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyUserImageView.image = UIImage(named: "user.png")
        self.StudyUserImageView.contentMode = .scaleAspectFill
        self.StudyUsertitlelabel.textAlignment = .left
        self.StudyUsertitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyUsertitlelabel.attributedText = NSAttributedString(string: "인원", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyUsercontentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyUsercontentlabel.textAlignment = .left
        self.StudyUsercontentlabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.recruit_number)명", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyDefaultView.layer.borderWidth = 1
        self.StudyDefaultView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.StudyRecruitmenttitlelabel.attributedText = NSAttributedString(string: "모집 정보", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyRecruitmenttitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyRecruitmenttitlelabel.numberOfLines = 0
        self.StudyRecruitTypeImageView.image = UIImage(named: "calendar.png")
        self.StudyRecruitTypeImageView.contentMode = .scaleAspectFill
        self.StudyRecruitTypetitlelabel.attributedText = NSAttributedString(string: "모집 유형", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyRecruitTypetitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyRecruitTypecontentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyRecruitTypecontentlabel.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.member_check_type_str)", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyRecruitTypecontentlabel.numberOfLines = 0
        self.StudyRecruitRankImageView.image = UIImage(named: "calendar.png")
        self.StudyRecruitRankImageView.contentMode = .scaleAspectFill
        self.StudyRecruitRanktitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyRecruitRanktitlelabel.attributedText = NSAttributedString(string: "모집 등급", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyRecruitRankcontentlabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyRecruitRankcontentlabel.numberOfLines = 0
        self.StudyRecruitDateImageView.image = UIImage(named: "calendar.png")
        self.StudyRecruitDateImageView.contentMode = .scaleAspectFill
        self.StudyRecruitDatetitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyRecruitDatetitlelabel.attributedText = NSAttributedString(string: "모집 기한", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.paragraphStyle : paragraphStyle])
        self.StudyRecruitcontentlabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyRecruitcontentlabel.attributedText = NSAttributedString(string: "2020.01.10까지", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyleaderProfileView.layer.borderWidth = 1
        self.StudyleaderProfileView.backgroundColor = UIColor.white
        self.StudyleaderProfileView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.StudyleaderNicknamelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        if let StudyleaderNickname = self.StudyDetailModel?.study_leader?.nickname {
            self.StudyleaderNicknamelabel.attributedText = NSAttributedString(string: "\(StudyleaderNickname)", attributes: [NSAttributedString.Key.kern : -0.77])
        }
        self.StudyleaderIntroducelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        let StudyApplyAttribute = NSMutableAttributedString()
        StudyApplyAttribute.append(NSAttributedString(string: "선착순 모집 중!", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 12),NSAttributedString.Key.kern : -0.66]))
        StudyApplyAttribute.append(NSAttributedString(string: " 신청하면 바로 참여되는 스터디에요. 😀", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.kern : -0.66]))
        self.StudyDetailApllyExamplelabel.attributedText = StudyApplyAttribute
        self.StudyDetailApllyExamplelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyDetailApllyExamplelabel.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.StudyDetailApllyExamplelabel.layer.cornerRadius = 7
        self.StudyDetailApllyExamplelabel.layer.masksToBounds = true
        self.StudyDetailReplyViewmoreBtn.setAttributedTitle(NSAttributedString(string: "더 보기 >", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12),NSAttributedString.Key.kern : -0.66]), for: .normal)
        self.StudyDetailReplyViewmoreBtn.setTitleColor(UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0), for: .normal)
        
    }
    
    private func StudyleaderSkillLevel(){
        if let beginnerLeader = self.StudyDetailModel?.study_leader?.interesting?[0].skill_level {
            if let StudyleaderIntersting =  self.StudyDetailModel?.study_leader?.interesting?[0].name{
                if beginnerLeader == 0{
                    self.StudyleaderIntroducelabel.attributedText = NSAttributedString(string: "\(StudyleaderIntersting): 초급", attributes: [NSAttributedString.Key.kern : -0.77])
                }else if beginnerLeader == 1 {
                    self.StudyleaderIntroducelabel.attributedText = NSAttributedString(string: "\(StudyleaderIntersting): 초중급", attributes: [NSAttributedString.Key.kern : -0.77])
                }else if beginnerLeader == 2 {
                    self.StudyleaderIntroducelabel.attributedText = NSAttributedString(string: "\(StudyleaderIntersting): 중급", attributes: [NSAttributedString.Key.kern : -0.77])
                }else if beginnerLeader == 3 {
                    self.StudyleaderIntroducelabel.attributedText = NSAttributedString(string: "\(StudyleaderIntersting): 상급", attributes: [NSAttributedString.Key.kern : -0.77])
                }
            }
        }
    }
    
    private func ConfrimLayoutInit(){
        self.StudyDetailFavoritebtn.layer.borderWidth = 1
        self.StudyDetailFavoritebtn.layer.borderColor = UIColor(red: 123/255, green: 120/255, blue: 255/255, alpha: 1.0).cgColor
        self.StudyDetailFavoritebtn.layer.cornerRadius = 4
        self.StudyDetailFavoritebtn.layer.masksToBounds = true
        self.StudyDetailFavoritebtn.setImage(UIImage(named: "Favorite.png"), for: .normal)
        self.StudyDetailFavoritebtn.imageEdgeInsets = UIEdgeInsets(top: 17, left: 18, bottom: 16, right: 18)
        self.StudyDetailFavoritebtn.setTitle("", for: .normal)
        self.StudyDetailConfirmbtn.backgroundColor = UIColor(red: 255/255, green: 113/255, blue: 104/255, alpha: 1.0)
        self.StudyDetailConfirmbtn.layer.cornerRadius = 4
        self.StudyDetailConfirmbtn.layer.masksToBounds = true
        self.StudyDetailConfirmbtn.setAttributedTitle(NSAttributedString(string: "가입 신청하기", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 14)]), for: .normal)
        self.StudyDetailConfirmbtn.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func StepsIndexScribe() {
        if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 0 && self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 1 {
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초급 ~ 초중급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 0 && self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 2 {
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초급 ~ 중급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 0 && self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 3{
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.77])
        }
        if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 1 && self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 2 {
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초중급 ~ 중급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 1 && self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 3 {
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초중급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.77])
        }
        if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 2 &&
            self.StudyDetailModel!.steps.index(before: self.StudyDetailModel!.steps.endIndex) == 3 {
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "중급 ~ 상급", attributes: [NSAttributedString.Key.kern : -0.77])
        }
        if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 0 && self.StudyDetailModel!.steps.count <= 1{
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 1 && self.StudyDetailModel!.steps.count <= 1{
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "초중급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 2 && self.StudyDetailModel!.steps.count <= 1{
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "중급", attributes: [NSAttributedString.Key.kern : -0.77])
        }else if self.StudyDetailModel!.steps[self.StudyDetailModel!.steps.startIndex] == 3 && self.StudyDetailModel!.steps.count <= 1{
            self.StudyRecruitRankcontentlabel.attributedText = NSAttributedString(string: "상급", attributes: [NSAttributedString.Key.kern : -0.77])
        }
    }
    
    private func StudyTagLayout(){
        self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
        self.StudyDetailTagButton.layer.borderWidth = 1
        self.StudyDetailTagButton.layer.cornerRadius = 10
        self.StudyDetailTagButton.layer.masksToBounds = true
        self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.StudyDetailTagButton2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.StudyDetailTagButton2.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![1])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
        self.StudyDetailTagButton2.layer.borderWidth = 1
        self.StudyDetailTagButton2.layer.cornerRadius = 10
        self.StudyDetailTagButton2.layer.masksToBounds = true
    }
    
    private func ReplyLayoutInit(){
        let StudyCommenetAttribute = NSMutableAttributedString()
        StudyCommenetAttribute.append(NSAttributedString(string: "댓글", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.kern : -0.88]))
        StudyCommenetAttribute.append(NSAttributedString(string: " \(self.studyRepliesData.count)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.kern : -0.88]))
        self.StudyCommentCountlabel.attributedText = StudyCommenetAttribute
        if self.studyRepliesData.isEmpty == true {
            self.StudyDetailReplyTableView.isHidden = true
            self.StudyDetailApllylabelTopConstraint.constant = -83
        } else {
            self.StudyDetailReplyTableView.isHidden = false
        }
    }
    
    @objc func MoreRepliesView(_ sender : UIButton) {
        
    }
    
    @objc func Favoritselect(_ sender : UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studyRepliesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let DetailCell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as? StudyDetailRepliesTableViewCell
        
        DetailCell?.StudyRepliesUserNickname.text = self.studyRepliesData[indexPath.row].writer!.nickname
        DetailCell?.StudyRepliesUserDate.text = self.studyRepliesData[indexPath.row].reply_created_at
        DetailCell?.StudyRepliesUserContent.text = self.studyRepliesData[indexPath.row].content
        
        return DetailCell!
    }
}
