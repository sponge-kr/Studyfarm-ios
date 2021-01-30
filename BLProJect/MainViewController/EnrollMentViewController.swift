//
//  EnrollMentViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/01/30.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class EnrollMentViewController: UIViewController {
    @IBOutlet weak var RecruitmentInfolabel: UILabel!
    @IBOutlet weak var RecruitmentInfoLine: UIView!
    @IBOutlet weak var Participantlabel: UILabel!
    @IBOutlet weak var FirstComeBtn: UIButton!
    @IBOutlet weak var FirstComeLabel: UILabel!
    @IBOutlet weak var FirstComeExampleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationLayou()
        self.SetupInitLayout()
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
        paragraphStyle.lineHeightMultiple = 1.66
        self.FirstComeLabel.attributedText = NSAttributedString(string: "선착순 모집", attributes: [NSAttributedString.Key.kern:-0.77, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.FirstComeExampleLabel.textAlignment = .left
        self.FirstComeExampleLabel.numberOfLines = 1
        paragraphStyle.lineHeightMultiple = 1.54
        self.FirstComeExampleLabel.attributedText = NSAttributedString(string: "선착순으로 모집 인원이 다 차면 모임이 생성돼요.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern: -0.66])
//        self.FirstComeBtn.setImage(UIImage(named: "genderunCheckgray@4x.png"), for: .normal)
        self.FirstComeBtn.frame = CGRect(x: self.FirstComeBtn.frame.origin.x, y: self.FirstComeBtn.frame.origin.y, width: self.FirstComeBtn.frame.size.width, height: self.FirstComeBtn.frame.size.height)
        self.FirstComeBtn.setTitle("", for: .normal)
        self.FirstComeBtn.setAddImageView(image: UIImage(named: "genderunCheckgray@4x.png")!, renderingMode: .alwaysOriginal)
        self.FirstComeBtn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}

