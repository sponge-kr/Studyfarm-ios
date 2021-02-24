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
    @IBOutlet weak var StudyDetailTagButton3: UIButton!
    @IBOutlet weak var StudyDetailTagButton4: UIButton!
    @IBOutlet weak var StudyDetailTagButton5: UIButton!
    @IBOutlet weak var StudyleaderProfileView: UIView!
    @IBOutlet weak var StudyleaderProfileImageView: UIImageView!
    @IBOutlet weak var StudyleaderNicknamelabel: UILabel!
    @IBOutlet weak var StudyleaderIntroducelabel: UILabel!
    @IBOutlet weak var StudyDetailReplyView: UIView!
    @IBOutlet weak var StudyCommentCountlabel: UILabel!
    @IBOutlet weak var StudyDetailReplyTextfiled: UITextField!
    @IBOutlet weak var StudyDetailReplyTableView: UITableView!
    @IBOutlet weak var StudyDetailReplyConfirmbtn: UIButton!
    
    var Index: Int = 1
    var ReplySize : CGFloat = 0.0
    var StudyDetailModel : StudyDetailResults?
    var TagCount : Int = 0
    private var studyRepliesData = [RepliesContent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StudyContentTextView.delegate = self
        self.StudyResearchScrollview.isScrollEnabled = true
        self.StudyResearchScrollview.delegate = self
        self.StudyDetailReplyTableView.delegate = self
        self.StudyDetailReplyTableView.dataSource = self
        let nibName = UINib(nibName: "StudyDetailRepliesTableViewCell", bundle: nil)
        self.StudyDetailReplyTableView.register(nibName, forCellReuseIdentifier: "ReplyCell")
        self.NavigationLayout()
        ServerApi.shared.StudyDetailCall(study_seq: Index) { result in
            DispatchQueue.main.async {
                self.StudyDetailModel = result
                self.setInitLayout()
                self.StepsIndexScribe()
                self.StudyTagHidden()
                self.StudyleaderSkillLevel()
            }
        }
        
        self.ReplySize = self.StudyDetailReplyView.frame.size.height
        self.setReplyLayout()
        let RepliesParam : Parameters = [
            "size" : 5,
            "page" : 0
        ]
        let Replies = RepliesParams(size: 5, page: 0)
        RepliesApi.shared.StudyRepliesCall(study_seq: Index, RepliesParamter: RepliesParam) { result in
            DispatchQueue.main.async {
                self.studyRepliesData = result
                self.StudyDetailReplyTableView.reloadData()
                print("댓글 데이터 체크 입니다\(self.studyRepliesData)")
            }
        }
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.StudyTopicnamelabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.StudyDetailReplyView.frame = CGRect(x: 0, y: self.StudyResearchScrollview.contentOffset.y + self.view.frame.size.height - self.view.frame.origin.y, width: self.StudyDetailReplyView.frame.size.width, height: self.StudyDetailReplyView.frame.size.height + self.view.safeAreaInsets.bottom)
        let ReplyViewInset = UIEdgeInsets(top: 0, left: 0, bottom:self.ReplySize, right: 0)
        self.StudyResearchScrollview.contentInset =  ReplyViewInset
        self.StudyResearchScrollview.scrollIndicatorInsets = ReplyViewInset
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
    
    
    private func setReplyLayout() {
        self.StudyDetailReplyTextfiled.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.StudyDetailReplyTextfiled.layer.borderWidth = 1
        self.StudyDetailReplyTextfiled.layer.cornerRadius = 5
        self.StudyDetailReplyTextfiled.layer.masksToBounds = true
        self.StudyDetailReplyTextfiled.attributedPlaceholder = NSAttributedString(string: "댓글을 남겨보세요.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.foregroundColor : UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)])
        let TextFiledInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        self.StudyDetailReplyTextfiled.leftView = TextFiledInsetView
        self.StudyDetailReplyTextfiled.leftViewMode = .always
        self.StudyDetailReplyConfirmbtn.setAttributedTitle(NSAttributedString(string: "등록", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14)]), for: .normal)
        self.StudyDetailReplyConfirmbtn.setTitleColor(UIColor.white, for: .normal)
        self.StudyDetailReplyConfirmbtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.StudyDetailReplyConfirmbtn.layer.cornerRadius = 3
        self.StudyDetailReplyConfirmbtn.layer.masksToBounds = true
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
    
    private func StudyTagHidden(){
        if self.StudyDetailModel!.tags!.count < 1 {
            self.StudyDetailTagButton.isHidden = true
            self.StudyDetailTagButton2.isHidden = true
            self.StudyDetailTagButton3.isHidden = true
            self.StudyDetailTagButton4.isHidden = true
            self.StudyDetailTagButton5.isHidden = true
        }else if self.StudyDetailModel!.tags!.count < 2 {
            self.StudyDetailTagButton.isHidden = false
            self.StudyDetailTagButton2.isHidden = true
            self.StudyDetailTagButton3.isHidden = true
            self.StudyDetailTagButton4.isHidden = true
            self.StudyDetailTagButton5.isHidden = true
            self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton.layer.borderWidth = 1
            self.StudyDetailTagButton.layer.cornerRadius = 10
            self.StudyDetailTagButton.layer.masksToBounds = true
        }else if self.StudyDetailModel!.tags!.count < 3 {
            self.StudyDetailTagButton.isHidden = false
            self.StudyDetailTagButton2.isHidden = false
            self.StudyDetailTagButton3.isHidden = true
            self.StudyDetailTagButton4.isHidden = true
            self.StudyDetailTagButton5.isHidden = true
            self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton.layer.borderWidth = 1
            self.StudyDetailTagButton.layer.cornerRadius = 10
            self.StudyDetailTagButton.layer.masksToBounds = true
            self.StudyDetailTagButton2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton2.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![1])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton2.layer.borderWidth = 1
            self.StudyDetailTagButton2.layer.cornerRadius = 10
            self.StudyDetailTagButton2.layer.masksToBounds = true
        }else if self.StudyDetailModel!.tags!.count < 4 {
            self.StudyDetailTagButton.isHidden = false
            self.StudyDetailTagButton2.isHidden = false
            self.StudyDetailTagButton3.isHidden = false
            self.StudyDetailTagButton4.isHidden = true
            self.StudyDetailTagButton5.isHidden = true
            self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton.layer.borderWidth = 1
            self.StudyDetailTagButton.layer.cornerRadius = 10
            self.StudyDetailTagButton.layer.masksToBounds = true
            self.StudyDetailTagButton2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton2.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![1])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton2.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton2.layer.borderWidth = 1
            self.StudyDetailTagButton2.layer.cornerRadius = 10
            self.StudyDetailTagButton2.layer.masksToBounds = true
            self.StudyDetailTagButton3.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton3.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![2])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton3.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton3.layer.borderWidth = 1
            self.StudyDetailTagButton3.layer.cornerRadius = 10
            self.StudyDetailTagButton3.layer.masksToBounds = true
        }else if self.StudyDetailModel!.tags!.count < 5 {
            self.StudyDetailTagButton.isHidden = false
            self.StudyDetailTagButton2.isHidden = false
            self.StudyDetailTagButton3.isHidden = false
            self.StudyDetailTagButton4.isHidden = false
            self.StudyDetailTagButton5.isHidden = true
            self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton.layer.borderWidth = 1
            self.StudyDetailTagButton.layer.cornerRadius = 10
            self.StudyDetailTagButton.layer.masksToBounds = true
            self.StudyDetailTagButton2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton2.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![1])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton2.layer.borderWidth = 1
            self.StudyDetailTagButton2.layer.cornerRadius = 10
            self.StudyDetailTagButton2.layer.masksToBounds = true
            self.StudyDetailTagButton3.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton3.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![2])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton3.layer.borderWidth = 1
            self.StudyDetailTagButton3.layer.cornerRadius = 10
            self.StudyDetailTagButton3.layer.masksToBounds = true
            self.StudyDetailTagButton4.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton4.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![3])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton4.layer.borderWidth = 1
            self.StudyDetailTagButton4.layer.cornerRadius = 10
            self.StudyDetailTagButton4.layer.masksToBounds = true
        }else if self.StudyDetailModel!.tags!.count < 6 {
            self.StudyDetailTagButton.isHidden = false
            self.StudyDetailTagButton2.isHidden = false
            self.StudyDetailTagButton3.isHidden = false
            self.StudyDetailTagButton4.isHidden = false
            self.StudyDetailTagButton5.isHidden = false
            self.StudyDetailTagButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![0])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton.layer.borderWidth = 1
            self.StudyDetailTagButton.layer.cornerRadius = 12
            self.StudyDetailTagButton.layer.masksToBounds = true
            self.StudyDetailTagButton2.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton2.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![1])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton2.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton2.layer.borderWidth = 1
            self.StudyDetailTagButton2.layer.cornerRadius = 12
            self.StudyDetailTagButton2.layer.masksToBounds = true
            self.StudyDetailTagButton3.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton3.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![2])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton3.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton3.layer.borderWidth = 1
            self.StudyDetailTagButton3.layer.cornerRadius = 12
            self.StudyDetailTagButton3.layer.masksToBounds = true
            self.StudyDetailTagButton4.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton4.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![3])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton4.layer.borderWidth = 1
            self.StudyDetailTagButton4.layer.cornerRadius = 12
            self.StudyDetailTagButton4.layer.masksToBounds = true
            
            self.StudyDetailTagButton5.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
            self.StudyDetailTagButton5.setAttributedTitle(NSAttributedString(string: "\(self.StudyDetailModel!.tags![4])", attributes: [NSAttributedString.Key.kern : -0.77,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
            self.StudyDetailTagButton.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
            self.StudyDetailTagButton5.layer.borderWidth = 1
            self.StudyDetailTagButton5.layer.cornerRadius = 12
            self.StudyDetailTagButton5.layer.masksToBounds = true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studyRepliesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let DetailCell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as? StudyDetailRepliesTableViewCell
        
        
        
        DetailCell?.StudyRepliesUserNickname.text = self.studyRepliesData[indexPath.row].dateFormat
        DetailCell?.StudyRepliesUserDate.text = self.studyRepliesData[indexPath.row].reply_created_at
        DetailCell?.StudyRepliesUserContent.text = self.studyRepliesData[indexPath.row].content
        
        return DetailCell!
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
