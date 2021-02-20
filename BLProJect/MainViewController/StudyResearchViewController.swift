//
//  StudyResearchViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/19.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class StudyResearchViewController: UIViewController,UITextViewDelegate,UIScrollViewDelegate {
    
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
    var Index: Int = 1
    
    var StudyDetailModel : StudyDetailResults?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StudyContentTextView.delegate = self
        self.StudyResearchScrollview.isScrollEnabled = true
        self.StudyResearchScrollview.delegate = self
        self.NavigationLayout()
        ServerApi.shared.StudyDetailCall(study_seq: Index + 1) { result in
            DispatchQueue.main.async {
                self.StudyDetailModel = result
                self.setInitLayout()
            }
        }
        print("인덱스 번호 입니다 \(Index)")
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.StudyTopicnamelabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    }
    
    public func setInitLayout() {
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
        self.StudyGoalViewContentlabel.text = "직장인 스터디인만큼 높은 퀄리티를 목표로 합니다. 집에서도 많은 작업 부탁드립니다"
        self.StudyGoalViewContentlabel.numberOfLines = 0
        self.StudyGoalViewlabel.lineBreakMode = .byCharWrapping
        self.StudyContentTextView.isEditable = false
        self.StudyContentTextView.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyContentTextView.attributedText = NSAttributedString(string: "\(self.StudyDetailModel!.content)", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 14)])
        self.StudyContentTextView.isScrollEnabled = false
        self.StudyIntroduceView.layer.borderWidth = 1
        self.StudyIntroduceView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0).cgColor
        self.StudyIntroducetitlelabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.StudyIntroducetitlelabel.textAlignment = .left
        self.StudyIntroducetitlelabel.attributedText = NSAttributedString(string: "스터디 진행 정보", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyProcesstitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyProcesstitlelabel.textAlignment = .left
        self.StudyProcesstitlelabel.attributedText = NSAttributedString(string: "진행 일정", attributes: [NSAttributedString.Key.kern : -0.77])
        self.StudyProcessImageView.image = UIImage(named: "calendar.png")
        self.StudyProcessImageView.contentMode = .scaleAspectFill
        self.StudyTypeImageView.image = UIImage(named: "calendar.png")
        self.StudyTypeImageView.contentMode = .scaleAspectFill
        self.StudyTypetitlelabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.StudyTypetitlelabel.textAlignment = .left
        self.StudyTypetitlelabel.attributedText = NSAttributedString(string: "진행 유형", attributes: [NSAttributedString.Key.kern : -0.77])
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
        self.StudyAreatilelabel.attributedText = NSAttributedString(string: "장소", attributes: [NSAttributedString.Key.kern : -0.77])
        
    }

}
