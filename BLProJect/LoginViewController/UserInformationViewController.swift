//
//  UserInformationViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2020/12/29.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SnapKit


class UserInformationViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var userInfoScrollView: UIScrollView!
    @IBOutlet weak var userInformationtitle: UILabel!
    @IBOutlet weak var userInformationsubtitle: UILabel!
    @IBOutlet weak var userInformationgendertitle: UILabel!
    @IBOutlet weak var userInformationbirthday: UILabel!
    @IBOutlet weak var userInformationbirthdayButton: UIButton!
    @IBOutlet weak var userInformationareatitle: UILabel!
    @IBOutlet weak var userInformationareaAddbtn: UIButton!
    @IBOutlet weak var userInformationIntresttitle: UILabel!
    @IBOutlet weak var userInformationConfirmButton: UIButton!
    @IBOutlet weak var userInformationmanButton: UIButton!
    @IBOutlet weak var userInformationmanTitleLabel: UILabel!
    @IBOutlet weak var userInformationgirlButton: UIButton!
    @IBOutlet weak var userInformationgirlTitleLabel: UILabel!
    @IBOutlet weak var userInformationAreaSelectionButton: UIButton!
    @IBOutlet weak var userInformationAreaSelectionButtonTwo: UIButton!
    @IBOutlet var birthdayView: BirthDayView!
    @IBOutlet weak var userInformationInterestingStudyButton: UIButton!
    @IBOutlet weak var userInformationAreaLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var userInfomationAreaSelectionTwoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var userInfomationAreaSelectionWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var userInfomationAreaSelectionTwoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var userInfoStudySelectTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userInfoContainerView: UIView!
    @IBOutlet weak var userInfoBeginnerButton: UIButton!
    @IBOutlet weak var userInfoBegineerInterButton: UIButton!
    @IBOutlet weak var userInfoMiddleButton: UIButton!
    @IBOutlet weak var userInfoContainerViewTitleLabel: UILabel!
    @IBOutlet weak var userInfoStepTitleLabel: UILabel!
    @IBOutlet weak var userInfoAdvancedButton: UIButton!
    @IBOutlet weak var userInfoContinerViewDeleteButton: UIButton!
    @IBOutlet weak var userInfoBoxView: UIView!
    @IBOutlet weak var userInfoContainerViewTwo: UIView!
    @IBOutlet weak var userInfoBeginnerButtonTwo: UIButton!
    @IBOutlet weak var userInfoBegineerInterButtonTwo: UIButton!
    @IBOutlet weak var userInfoMiddleButtonTwo: UIButton!
    @IBOutlet weak var userInfoAdvancedButtonTwo: UIButton!
    @IBOutlet weak var userInfoStepTitleLabelTwo: UILabel!
    @IBOutlet weak var userInfoContainerViewDeleteButtonTwo: UIButton!
    @IBOutlet weak var userInfoContainerViewTitleLabelTwo: UILabel!
    public let birthDayTitle = ["1980","1981","1982","1983","1984","1985","1986",
                                "1987","1988","1989","1990","1991","1992","1993",
                                "1994","1995","1996","1997","1998","1999","2000",
                                "2001","2002","2003","2004","2005","2006","2007",
                                "2008","2009","2010","2011","2012","2013","2014",
                                "2015","2016","2017","2018","2019","2020","2021"]
    
    lazy var BirthDayContainerView: UIView = {
        let ConatinerView = UIView(frame: self.view.frame)
        ConatinerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        ConatinerView.tag = 1
        return ConatinerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.showAreaselectionButton()
        self.showUserInfoStudyContinaerLayout()
        self.userInfoScrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showAreaselectionButton()
        self.showUserInfoStudyContinaerLayout()
    }
    
    public func initLayout() {
        self.userInformationtitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationtitle.numberOfLines = 1
        self.userInformationtitle.textAlignment = .left
        self.userInformationtitle.attributedText = NSAttributedString(string: "어떤 스터디를 찾고 있나요?", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 26)])
        self.userInformationsubtitle.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.userInformationsubtitle.numberOfLines = 2
        self.userInformationsubtitle.textAlignment = .left
        self.userInformationsubtitle.attributedText = NSAttributedString(string: "입력하신 정보로 스터디를 찾을 수 있습니다.\n지역 정보는 다른 사람들에게 공유되지 않습니다.", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        self.userInformationgendertitle.numberOfLines = 1
        self.userInformationgendertitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationgendertitle.textAlignment = .left
        self.userInformationgendertitle.attributedText = NSAttributedString(string: "성별", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        self.userInformationmanButton.setImage(UIImage(named: "GrayCheck.png"), for: .normal)
        self.userInformationmanButton.addTarget(self, action: #selector(didTapMangender(_:)), for: .touchUpInside)
        self.userInformationmanTitleLabel.attributedText = NSAttributedString(string: "남자", attributes: [NSAttributedString.Key.kern: -0.77])
        self.userInformationmanTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.userInformationmanTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationmanTitleLabel.textAlignment = .left
        self.userInformationgirlButton.setImage(UIImage(named: "GrayCheck.png"), for: .normal)
        self.userInformationgirlButton.addTarget(self, action: #selector(didTapGirlgender(_:)), for: .touchUpInside)
        self.userInformationgirlTitleLabel.attributedText = NSAttributedString(string: "여자", attributes: [NSAttributedString.Key.kern: -0.77])
        self.userInformationgirlTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.userInformationgirlTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationgirlTitleLabel.textAlignment = .left
        self.userInformationbirthday.text = "출생년도"
        self.userInformationbirthday.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationbirthday.textAlignment = .center
        self.userInformationbirthday.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationbirthdayButton.layer.borderWidth = 1
        self.userInformationbirthdayButton.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.userInformationbirthdayButton.setTitle("1996", for: .normal)
        self.userInformationbirthdayButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        self.userInformationbirthdayButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationbirthdayButton.layer.cornerRadius = 4
        self.userInformationbirthdayButton.layer.masksToBounds = true
        self.userInformationbirthdayButton.contentHorizontalAlignment = .left
        self.userInformationbirthdayButton.setImage(UIImage(named: "triangle.png"), for: .normal)
        self.userInformationbirthdayButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationbirthdayButton.tintColor = UIColor(red: 196/266, green: 196/255, blue: 196/255, alpha: 1.0)
        self.userInformationbirthdayButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
        self.userInformationbirthdayButton.addTarget(self, action: #selector(didTapShowBirthDayView(_:)), for: .touchUpInside)
        self.userInformationareatitle.text = "지역"
        self.userInformationareatitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationareatitle.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInformationareatitle.textAlignment = .left
        self.userInformationareaAddbtn.setAttributedTitle(NSAttributedString(string: "추가하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        self.userInformationareaAddbtn.setImage(UIImage(named: "addCircle.png"), for: .normal)
        self.userInformationareaAddbtn.contentHorizontalAlignment = .right
        self.userInformationareaAddbtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        self.userInformationareaAddbtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 36)
        self.userInformationareaAddbtn.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationareaAddbtn.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.userInformationareaAddbtn.layer.cornerRadius = 4
        self.userInformationareaAddbtn.layer.masksToBounds = true
        self.userInformationareaAddbtn.addTarget(self, action: #selector(didTapAreaSearchView), for: .touchUpInside)
        self.userInformationAreaSelectionButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationAreaSelectionButton.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.77,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)]), for: .normal)
        self.userInformationAreaSelectionButton.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.userInformationAreaSelectionButton.contentHorizontalAlignment = .right
        self.userInformationAreaSelectionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 109, bottom: 0, right: 0)
        self.userInformationAreaSelectionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        self.userInformationAreaSelectionButton.layer.cornerRadius = 4
        self.userInformationAreaSelectionButton.layer.masksToBounds = true
        self.userInformationAreaSelectionButton.isHidden = true
        self.userInformationAreaSelectionButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationAreaSelectionButtonTwo.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.77,NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)]), for: .normal)
        self.userInformationAreaSelectionButtonTwo.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.userInformationAreaSelectionButtonTwo.contentHorizontalAlignment = .right
        self.userInformationAreaSelectionButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 109, bottom: 0, right: 0)
        self.userInformationAreaSelectionButtonTwo.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        self.userInformationAreaSelectionButtonTwo.layer.cornerRadius = 4
        self.userInformationAreaSelectionButtonTwo.layer.masksToBounds = true
        self.userInformationAreaSelectionButtonTwo.isHidden = true
        self.userInformationIntresttitle.textAlignment = .left
        self.userInformationIntresttitle.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.userInformationIntresttitle.attributedText = NSAttributedString(string: "관심 스터디", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)])
        self.userInformationConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInformationConfirmButton.setAttributedTitle(NSAttributedString(string: "가입하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.userInformationConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.userInformationConfirmButton.layer.cornerRadius = 4
        self.userInformationConfirmButton.layer.masksToBounds = true
        self.userInformationInterestingStudyButton.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.userInformationInterestingStudyButton.setAttributedTitle(NSAttributedString(string: "추가하기", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 12)]), for: .normal)
        self.userInformationInterestingStudyButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInformationInterestingStudyButton.layer.cornerRadius = 4
        self.userInformationInterestingStudyButton.layer.masksToBounds = true
        self.userInformationInterestingStudyButton.setImage(UIImage(named: "addCircle.png"), for: .normal)
        self.userInformationInterestingStudyButton.contentHorizontalAlignment = .right
        self.userInformationInterestingStudyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 140)
        self.userInformationInterestingStudyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 136)
        self.userInformationAreaSelectionButton.addTarget(self, action: #selector(self.didTapAreaInfoDelete(_:)), for: .touchUpInside)
        self.userInformationAreaSelectionButtonTwo.addTarget(self, action: #selector(self.didTapAreaInfoTwoDelete(_:)), for: .touchUpInside)
        self.userInformationInterestingStudyButton.addTarget(self, action: #selector(self.didTapShowInterestView), for: .touchUpInside)
        
        self.userInfoContainerView.layer.borderWidth = 1
        self.userInfoContainerView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.userInfoContainerView.layer.cornerRadius = 4
        self.userInfoContainerView.layer.masksToBounds = true
        self.userInfoContainerView.isHidden = true
        self.userInfoBeginnerButton.setTitle("초급", for: .normal)
        self.userInfoBeginnerButton.setTitleColor(UIColor.white, for: .normal)
        self.userInfoBeginnerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoBeginnerButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBeginnerButton.layer.cornerRadius = 4
        self.userInfoBeginnerButton.layer.masksToBounds = true
        self.userInfoBeginnerButton.addTarget(self, action: #selector(self.didTapBegginerButton(_:)), for: .touchUpInside)
        self.userInfoBegineerInterButton.setTitle("초중급", for: .normal)
        self.userInfoBegineerInterButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoBegineerInterButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoBegineerInterButton.backgroundColor = UIColor.white
        self.userInfoBegineerInterButton.layer.cornerRadius = 4
        self.userInfoBegineerInterButton.layer.masksToBounds = true
        self.userInfoBegineerInterButton.addTarget(self, action: #selector(self.didTapBegineerInterButton(_:)), for: .touchUpInside)
        self.userInfoMiddleButton.setTitle("중급", for: .normal)
        self.userInfoMiddleButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoMiddleButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoMiddleButton.backgroundColor = UIColor.white
        self.userInfoMiddleButton.layer.cornerRadius = 4
        self.userInfoMiddleButton.addTarget(self, action: #selector(self.didTapMiddleButton(_:)), for: .touchUpInside)
        self.userInfoAdvancedButton.layer.masksToBounds = true
        self.userInfoAdvancedButton.setTitle("상급", for: .normal)
        self.userInfoAdvancedButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoAdvancedButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoAdvancedButton.backgroundColor = UIColor.white
        self.userInfoAdvancedButton.layer.cornerRadius = 4
        self.userInfoAdvancedButton.addTarget(self, action: #selector(self.didTapAdvancedButton(_:)), for: .touchUpInside)
        self.userInfoContinerViewDeleteButton.setImage(UIImage(named: "userInfodelete.png"), for: .normal)
        self.userInfoContinerViewDeleteButton.setTitle("", for: .normal)
        self.userInfoContinerViewDeleteButton.addTarget(self, action: #selector(self.didTapContainerDeleteButton(_:)), for: .touchUpInside)
        self.userInfoContinerViewDeleteButton.isHidden = true
        self.userInfoStepTitleLabel.text = ""
        self.userInfoStepTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        self.userInfoStepTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.userInfoContainerViewTitleLabel.text = ""
        self.userInfoContainerViewTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.userInfoContainerViewTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.userInfoBoxView.isHidden = true
        self.userInfoContainerViewTwo.layer.borderWidth = 1
        self.userInfoContainerViewTwo.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.userInfoContainerViewTwo.layer.cornerRadius = 4
        self.userInfoContainerViewTwo.layer.masksToBounds = true
        self.userInfoBeginnerButtonTwo.setTitle("초급", for: .normal)
        self.userInfoBeginnerButtonTwo.setTitleColor(UIColor.white, for: .normal)
        self.userInfoBeginnerButtonTwo.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoBeginnerButtonTwo.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBeginnerButtonTwo.layer.cornerRadius = 4
        self.userInfoBeginnerButtonTwo.layer.masksToBounds = true
        self.userInfoBeginnerButtonTwo.addTarget(self, action: #selector(self.didTapBegginerButtonTwo(_:)), for: .touchUpInside)
        self.userInfoBegineerInterButtonTwo.setTitle("초중급", for: .normal)
        self.userInfoBegineerInterButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoBegineerInterButtonTwo.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor.white
        self.userInfoBegineerInterButtonTwo.layer.cornerRadius = 4
        self.userInfoBegineerInterButtonTwo.layer.masksToBounds = true
        self.userInfoBegineerInterButtonTwo.addTarget(self, action: #selector(self.didTapBegginerInterButtonTwo(_:)), for: .touchUpInside)
        self.userInfoMiddleButtonTwo.setTitle("중급", for: .normal)
        self.userInfoMiddleButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoMiddleButtonTwo.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoMiddleButtonTwo.backgroundColor = UIColor.white
        self.userInfoMiddleButtonTwo.layer.cornerRadius = 4
        self.userInfoMiddleButtonTwo.addTarget(self, action: #selector(self.didTapMiddleButtonTwo(_:)), for: .touchUpInside)
        self.userInfoAdvancedButtonTwo.setTitle("상급", for: .normal)
        self.userInfoAdvancedButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoAdvancedButtonTwo.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.userInfoAdvancedButtonTwo.backgroundColor = UIColor.white
        self.userInfoAdvancedButtonTwo.layer.cornerRadius = 4
        self.userInfoAdvancedButtonTwo.layer.masksToBounds = true
        self.userInfoAdvancedButtonTwo.addTarget(self, action: #selector(self.didTapAdvancedButtonTwo(_:)), for: .touchUpInside)
        self.userInfoContainerViewDeleteButtonTwo.setImage(UIImage(named: "userInfodelete.png"), for: .normal)
        self.userInfoContainerViewDeleteButtonTwo.setTitle("", for: .normal)
        self.userInfoContainerViewDeleteButtonTwo.addTarget(self, action: #selector(self.didTapContainerDeleteTwoButton(_:)), for: .touchUpInside)
        self.userInfoStepTitleLabelTwo.text = ""
        self.userInfoStepTitleLabelTwo.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        self.userInfoStepTitleLabelTwo.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        self.userInfoContainerViewTitleLabelTwo.text = ""
        self.userInfoContainerViewTitleLabelTwo.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        self.userInfoContainerViewTitleLabelTwo.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
    }
    
    private func birthDayViewInit() {
        let screenSize = UIScreen.main.bounds.size
        self.birthdayView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2)
        self.birthdayView.birthDayTitleLabel.text = "출생 년도"
        self.birthdayView.birthDayTitleLabel.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        self.birthdayView.birthDayTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        self.birthdayView.birthDayTitleLabel.textAlignment = .left
        self.birthdayView.birthDayPickerView.delegate = self
        self.birthdayView.birthDayPickerView.dataSource = self
        self.birthdayView.birthDayConfirmButton.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.birthdayView.birthDayConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.birthdayView.birthDayConfirmButton.layer.cornerRadius = 8
        self.birthdayView.birthDayConfirmButton.layer.masksToBounds = true
        self.birthdayView.birthDayConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.birthdayView.birthDayConfirmButton.addTarget(self, action: #selector(didRemoveBirthDayView(_:)), for: .touchUpInside)
        self.birthdayView.layer.cornerRadius = 8
        self.birthdayView.layer.masksToBounds = true
        self.birthdayView.backgroundColor = UIColor.white
    }
    
    public func didTapBeginerLayoutInit() {
        self.userInfoMiddleButton.isSelected = false
        self.userInfoBegineerInterButton.isSelected = false
        self.userInfoAdvancedButton.isSelected = false
        self.userInfoMiddleButton.backgroundColor = UIColor.white
        self.userInfoBegineerInterButton.backgroundColor = UIColor.white
        self.userInfoAdvancedButton.backgroundColor = UIColor.white
        self.userInfoStepTitleLabel.text = "\(self.userInfoBeginnerButton.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoBeginnerButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBeginnerButton.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapBeginerTwoLayouInit() {
        self.userInfoMiddleButtonTwo.isSelected = false
        self.userInfoBegineerInterButtonTwo.isSelected = false
        self.userInfoAdvancedButtonTwo.isSelected = false
        self.userInfoMiddleButtonTwo.backgroundColor = UIColor.white
        self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor.white
        self.userInfoAdvancedButtonTwo.backgroundColor = UIColor.white
        self.userInfoStepTitleLabelTwo.text = "\(self.userInfoBeginnerButtonTwo.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoBeginnerButtonTwo.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBeginnerButtonTwo.setTitleColor(UIColor.white, for: .selected)
    }

    public func didTapBeginerInterLayoutInit() {
        self.userInfoMiddleButton.isSelected = false
        self.userInfoBeginnerButton.isSelected = false
        self.userInfoAdvancedButton.isSelected = false
        self.userInfoMiddleButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoAdvancedButton.backgroundColor = UIColor.white
        self.userInfoStepTitleLabel.text = "\(self.userInfoBegineerInterButton.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoBegineerInterButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBegineerInterButton.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapBeginerInterTwoLayoutInit() {
        self.userInfoMiddleButtonTwo.isSelected = false
        self.userInfoBeginnerButtonTwo.isSelected = false
        self.userInfoAdvancedButtonTwo.isSelected = false
        self.userInfoMiddleButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoAdvancedButtonTwo.backgroundColor = UIColor.white
        self.userInfoStepTitleLabelTwo.text = "\(self.userInfoBeginnerButtonTwo.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoBegineerInterButtonTwo.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapMiddleLayoutInit() {
        self.userInfoBegineerInterButton.isSelected = false
        self.userInfoBeginnerButton.isSelected = false
        self.userInfoAdvancedButton.isSelected = false
        self.userInfoBegineerInterButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.backgroundColor = UIColor.white
        self.userInfoAdvancedButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoStepTitleLabel.text = "\(self.userInfoMiddleButton.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoMiddleButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoMiddleButton.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapMiddleTwoLayoutInit() {
        self.userInfoBegineerInterButtonTwo.isSelected = false
        self.userInfoBeginnerButtonTwo.isSelected = false
        self.userInfoAdvancedButtonTwo.isSelected = false
        self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.backgroundColor = UIColor.white
        self.userInfoAdvancedButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoStepTitleLabelTwo.text = "\(self.userInfoMiddleButtonTwo.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoMiddleButtonTwo.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoMiddleButtonTwo.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapAdvancedLayoutInit() {
        self.userInfoMiddleButton.isSelected = false
        self.userInfoBegineerInterButton.isSelected = false
        self.userInfoBeginnerButton.isSelected = false
        self.userInfoMiddleButton.backgroundColor = UIColor.white
        self.userInfoBegineerInterButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.backgroundColor = UIColor.white
        self.userInfoBeginnerButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoStepTitleLabel.text = "\(self.userInfoAdvancedButton.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoAdvancedButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoAdvancedButton.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func didTapAdvancedTwoLayoutInit() {
        self.userInfoMiddleButtonTwo.isSelected = false
        self.userInfoBegineerInterButtonTwo.isSelected = false
        self.userInfoBeginnerButtonTwo.isSelected = false
        self.userInfoMiddleButtonTwo.backgroundColor = UIColor.white
        self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.backgroundColor = UIColor.white
        self.userInfoBeginnerButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.userInfoStepTitleLabelTwo.text = "\(self.userInfoAdvancedButtonTwo.titleLabel!.text!)! 거의 처음 배워요"
        self.userInfoAdvancedButtonTwo.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.userInfoAdvancedButtonTwo.setTitleColor(UIColor.white, for: .selected)
    }
    
    public func showAreaselectionButton() {
        if UserDefaults.standard.string(forKey: "first_name") != nil && UserDefaults.standard.string(forKey: "first_longname") != nil {
            if UserDefaults.standard.string(forKey: "first_longname")?.count == 4 {
                self.userInformationAreaSelectionButton.layoutIfNeeded()
                self.userInfomationAreaSelectionWidthConstraint.constant = 150
                self.userInformationAreaSelectionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 119, bottom: 0, right: 0)
            } else {
                self.userInformationAreaSelectionButton.layoutIfNeeded()
                self.userInfomationAreaSelectionWidthConstraint.constant = 133
                self.userInformationAreaSelectionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 109, bottom: 0, right: 0)
            }
            self.userInformationareaAddbtn.layoutIfNeeded()
            self.userInformationAreaLeadingConstraint.constant = 163
            self.userInformationAreaSelectionButton.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            self.userInformationAreaSelectionButton.setTitle("\(UserDefaults.standard.string(forKey: "first_name")!) \(UserDefaults.standard.string(forKey: "first_longname")!)", for: .normal)
            self.userInformationAreaSelectionButton.isHidden = false
        }
        if UserDefaults.standard.string(forKey: "second_name") != nil && UserDefaults.standard.string(forKey: "second_longname") != nil {
            if UserDefaults.standard.string(forKey: "second_longname")?.count == 4 {
                self.userInformationAreaSelectionButtonTwo.layoutIfNeeded()
                self.userInfomationAreaSelectionTwoWidthConstraint.constant = 150
                self.userInfomationAreaSelectionTwoLeadingConstraint.constant = -110
                self.userInformationAreaSelectionButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 119, bottom: 0, right: 0)
            } else {
                self.userInformationAreaSelectionButtonTwo.layoutIfNeeded()
                self.userInfomationAreaSelectionTwoWidthConstraint.constant = 133
                self.userInfomationAreaSelectionTwoLeadingConstraint.constant = -110
                self.userInformationAreaSelectionButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 109, bottom: 0, right: 0)
            }
            if UserDefaults.standard.string(forKey: "second_longname")?.count == 4 && UserDefaults.standard.string(forKey: "first_longname")?.count == 3  || UserDefaults.standard.string(forKey: "second_longname")?.count == 3 && UserDefaults.standard.string(forKey: "first_longname")?.count == 3 {
                self.userInfomationAreaSelectionTwoLeadingConstraint.constant = -130
            }
            self.userInformationAreaSelectionButtonTwo.isHidden = false
            self.userInformationareaAddbtn.isHidden = true
            self.userInformationAreaSelectionButtonTwo.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
            self.userInformationAreaSelectionButtonTwo.setTitle("\(UserDefaults.standard.string(forKey: "second_name")!) \(UserDefaults.standard.string(forKey: "second_longname")!)", for: .normal)
            self.userInformationAreaSelectionButtonTwo.isHidden = false
        }
    }
    
    
    public func showUserInfoStudyContinaerLayout() {
        if UserDefaults.standard.string(forKey: "first_Intrest_name") != nil && UserDefaults.standard.string(forKey: "second_Intrest_name") == nil {
            self.userInfoContainerView.isHidden = false
            self.userInfoContinerViewDeleteButton.isHidden = false
            self.userInfoContainerViewTitleLabel.text = "\(UserDefaults.standard.string(forKey: "first_Intrest_name")!)"
            self.userInfoStepTitleLabel.text = "\(self.userInfoBeginnerButton.titleLabel!.text!)! 거의 처음 배워요"
            UIView.animate(withDuration: 0.2) {
                self.userInformationInterestingStudyButton.layoutIfNeeded()
                self.userInfoStudySelectTopConstraint.constant = 115
            }
        } else if UserDefaults.standard.string(forKey: "first_Intrest_name") != nil && UserDefaults.standard.string(forKey: "second_Intrest_name") != nil {
            self.userInfoContainerView.isHidden = false
            self.userInfoContinerViewDeleteButton.isHidden = false
            self.userInfoBoxView.isHidden = false
            self.userInfoContainerViewTitleLabel.text = "\(UserDefaults.standard.string(forKey: "first_Intrest_name")!)"
            self.userInfoStepTitleLabel.text = "\(self.userInfoBeginnerButton.titleLabel!.text!)! 거의 처음 배워요"
            self.userInfoContainerViewTitleLabelTwo.text = "\(UserDefaults.standard.string(forKey: "second_Intrest_name")!)"
            self.userInfoStepTitleLabelTwo.text = "\(self.userInfoBeginnerButtonTwo.titleLabel!.text!)! 거의 처음 배워요"
            UIView.animate(withDuration: 0.2) {
                self.userInformationInterestingStudyButton.layoutIfNeeded()
                self.userInfoStudySelectTopConstraint.constant = 215
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.birthDayTitle.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.birthDayTitle[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.userInformationbirthdayButton.setTitle(self.birthDayTitle[row], for: .normal)
    }
    
    @objc
    func didTapContainerDeleteButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoContainerView.isHidden = false
        } else {
            sender.isSelected = true
            self.userInfoContainerView.isHidden = true
            self.userInfoContinerViewDeleteButton.isHidden = true
            self.userInformationInterestingStudyButton.layoutIfNeeded()
            self.userInfoStudySelectTopConstraint.constant = 13
        }
    }
    
    @objc
    func didTapContainerDeleteTwoButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoBoxView.isHidden = false
        } else {
            sender.isSelected = true
            self.userInfoBoxView.isHidden = true
            self.userInformationInterestingStudyButton.layoutIfNeeded()
            self.userInfoStudySelectTopConstraint.constant = 115
        }
    }
    
    
    @objc
    private func didTapAreaInfoDelete(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "first_longname")
        UserDefaults.standard.removeObject(forKey: "first_name")
        self.userInformationAreaSelectionButton.isHidden = true
        self.userInformationareaAddbtn.isHidden = false
        if self.userInformationAreaSelectionButton.isHidden == true && self.userInformationAreaSelectionButtonTwo.isHidden == true {
            self.userInformationAreaLeadingConstraint.constant = 20
        } else if self.userInformationAreaSelectionButtonTwo.isHidden == false && self.userInformationareaAddbtn.isHidden == false {
            self.userInfomationAreaSelectionTwoLeadingConstraint.constant = -280
            if UserDefaults.standard.string(forKey: "second_longname")?.count == 4 {
                self.userInformationAreaLeadingConstraint.constant = 180
                self.userInfomationAreaSelectionTwoLeadingConstraint.constant = -300
            } else {
                self.userInformationAreaLeadingConstraint.constant = 163
            }
        }
    }
    
    @objc
    func didTapBegginerButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoBeginnerButton.backgroundColor = UIColor.white
            self.userInfoBeginnerButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapBeginerLayoutInit()
        }
    }
    
    @objc
    func didTapBegineerInterButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoBegineerInterButton.backgroundColor = UIColor.white
            self.userInfoBegineerInterButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapBeginerInterLayoutInit()
        }
    }
    
    @objc
    func didTapMiddleButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoMiddleButton.backgroundColor = UIColor.white
            self.userInfoMiddleButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapMiddleLayoutInit()
        }
    }
    
    @objc
    func didTapAdvancedButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoAdvancedButton.backgroundColor = UIColor.white
            self.userInfoAdvancedButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapAdvancedLayoutInit()
        }
    }
    
    @objc
    func didTapBegginerButtonTwo(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoBeginnerButtonTwo.backgroundColor = UIColor.white
            self.userInfoBeginnerButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapBeginerTwoLayouInit()
        }
    }
    
    @objc
    func didTapBegginerInterButtonTwo(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoBegineerInterButtonTwo.backgroundColor = UIColor.white
            self.userInfoBegineerInterButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapBeginerInterTwoLayoutInit()
        }
    }
    
    @objc
    func didTapMiddleButtonTwo(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoMiddleButtonTwo.backgroundColor = UIColor.white
            self.userInfoMiddleButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapMiddleTwoLayoutInit()
        }
    }
    
    @objc
    func didTapAdvancedButtonTwo(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInfoAdvancedButtonTwo.backgroundColor = UIColor.white
            self.userInfoAdvancedButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        } else {
            sender.isSelected = true
            self.didTapAdvancedTwoLayoutInit()
        }
    }
    
    
    @objc
    private func didTapAreaInfoTwoDelete(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "second_longname")
        UserDefaults.standard.removeObject(forKey: "second_name")
        self.userInformationAreaSelectionButtonTwo.isHidden = true
        self.userInformationareaAddbtn.isHidden = false
        if self.userInformationAreaSelectionButton.isHidden == false {
            self.userInformationAreaLeadingConstraint.constant = 163
        }
        if userInformationAreaSelectionButtonTwo.isHidden == true && self.userInformationAreaSelectionButton.isHidden == true {
            self.userInformationAreaLeadingConstraint.constant = 20
        } else if self.userInformationAreaSelectionButtonTwo.isHidden == true && self.userInformationAreaSelectionButton.isHidden == false {
            self.userInformationAreaLeadingConstraint.constant = 163
        }
    }
    
    @objc
    private func didTapShowInterestView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let interestView = storyboard.instantiateViewController(withIdentifier: "InterestView") as? InterestFieldViewController
        guard let interestVC = interestView else {return}
        self.navigationController?.pushViewController(interestVC, animated: true)
    }
    
    
    
    @objc
    private func didTapMangender(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInformationgirlButton.isSelected = false
            self.userInformationmanTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        } else {
            sender.isSelected = true
            self.userInformationgirlButton.isSelected = false
            self.userInformationmanButton.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.userInformationmanTitleLabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.userInformationgirlTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        }
    }
    
    @objc
    private func didTapGirlgender(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.userInformationgirlButton.isSelected = false
            self.userInformationgirlTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        } else {
            sender.isSelected = true
            self.userInformationmanButton.isSelected = false
            self.userInformationgirlButton.setImage(UIImage(named: "RedCheck.png"), for: .selected)
            self.userInformationgirlTitleLabel.textColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
            self.userInformationmanTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
        }
    }
    
    @objc
    private func didTapShowBirthDayView(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.birthDayViewInit()
        window?.addSubview(self.BirthDayContainerView)
        window?.addSubview(self.birthdayView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.BirthDayContainerView.alpha = 0.5
            self.birthdayView.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.9, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
        })
        
    }
    
    @objc
    private func didRemoveBirthDayView(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.BirthDayContainerView.alpha = 0
            self.birthdayView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.9)
        })
    }
    
    @objc
    private func didTapAreaSearchView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AreaSearchView = storyboard.instantiateViewController(withIdentifier: "AreaSearchView") as? AreaSearchViewController
        guard let AreaSearchVC = AreaSearchView else { return }
        self.navigationController?.pushViewController(AreaSearchVC, animated: true)
    }
    
}

class BirthDayView: UIView {
    
    @IBOutlet weak var birthDayTitleLabel: UILabel!
    @IBOutlet weak var birthDayPickerView: UIPickerView!
    @IBOutlet weak var birthDayConfirmButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
