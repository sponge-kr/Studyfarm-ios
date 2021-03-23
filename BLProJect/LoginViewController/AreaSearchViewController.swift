//
//  AreaSearchViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/23.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit


class AreaSearchViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var areaSearchSubTitleLabel: UILabel!
    @IBOutlet weak var areaSearchScrollView: UIScrollView!
    @IBOutlet weak var areaSearchScrollContainerView: UIView!
    @IBOutlet weak var areaSearchCollectionView: UICollectionView!
    public let count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        let navigationAttribute = NSMutableAttributedString()
        navigationAttribute.append(NSAttributedString(string: "지역 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "  \(self.count)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "/2", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
        let areaNavigationLabel = UILabel()
        areaNavigationLabel.sizeToFit()
        areaNavigationLabel.text = "지역 선택  \(self.count)/2"
        areaNavigationLabel.attributedText = navigationAttribute
        self.navigationItem.titleView = areaNavigationLabel
        self.areaSearchSubTitleLabel.attributedText = NSAttributedString(string: "집, 학교, 직장 등 자주 가는 곳을 설정해주세요.\n선택하신 지역으로 스터디를 찾아드릴게요!", attributes: [NSAttributedString.Key.kern: -0.77])
        self.areaSearchSubTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.areaSearchSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.areaSearchSubTitleLabel.textAlignment = .left
        self.areaSearchSubTitleLabel.numberOfLines = 0
        self.areaSearchScrollView.delegate = self
        
    }
}
