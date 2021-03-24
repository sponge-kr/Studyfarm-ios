//
//  AreaSearchViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/23.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit


class AreaSearchViewController: UIViewController {
    
    @IBOutlet weak var areaSearchSubTitleLabel: UILabel!
    @IBOutlet weak var areaSearchCollectionView: UICollectionView!
    @IBOutlet weak var areaSearchConfirmButton: UIButton!
    public let count = 0
    public var CityData = [StateCityContentContainer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
        self.getApiCityCode()
        let nibName = UINib(nibName: "AreaSearchCollectionViewCell", bundle: nil)
        self.areaSearchCollectionView.register(nibName, forCellWithReuseIdentifier: "AreaSearchCell")
        self.areaSearchCollectionView.delegate = self
        self.areaSearchCollectionView.dataSource = self
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
        self.areaSearchCollectionView.canCancelContentTouches = true
        self.areaSearchConfirmButton.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.areaSearchConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.areaSearchConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.areaSearchConfirmButton.layer.cornerRadius = 4
        self.areaSearchConfirmButton.layer.masksToBounds = true
    }
    
    
    
    public func getApiCityCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStatesCiteCodeCall { result in
                self.CityData = result
                self.areaSearchCollectionView.reloadData()
            }
        }
    }
}

extension AreaSearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.CityData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaSearchCell", for: indexPath) as? AreaSearchCollectionViewCell
        cell?.areaTitleButton.setTitle("\(self.CityData[indexPath.row].short_name!)", for: .normal)
        print("\(self.CityData[indexPath.row].short_name)")
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let AreaCell = collectionView.cellForItem(at: indexPath) as? AreaSearchCollectionViewCell
        AreaCell!.areaTitleButton.layer.borderWidth = 1
        AreaCell!.areaTitleButton.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        AreaCell!.areaTitleButton.setTitleColor(UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0), for: .selected)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 57, height: 32)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
