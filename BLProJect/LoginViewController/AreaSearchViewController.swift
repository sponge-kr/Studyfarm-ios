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
    @IBOutlet weak var areaCityCollectionView: UICollectionView!
    @IBOutlet weak var areaSearchConfirmButton: UIButton!
    @IBOutlet weak var areaCityTagButtonOne: UIButton!
    @IBOutlet weak var areaCityTagButtonTwo: UIButton!
    public var count: Int = 0
    public var selectItem: Int = 0
    public var firstSelect: Int = 0
    public var citySelctItem: Int = 0
    public var CityData = [StateCityContentContainer]()
    public var cityChildrenData = [StateCityChildrenContainer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
        self.getApiAreaCode()
        self.getApiCityCode()
        let nibName = UINib(nibName: "AreaSearchCollectionViewCell", bundle: nil)
        self.areaSearchCollectionView.register(nibName, forCellWithReuseIdentifier: "AreaSearchCell")
        let AreaCitynibName = UINib(nibName: "AreaCityCollectionViewCell", bundle: nil)
        self.areaCityCollectionView.register(AreaCitynibName, forCellWithReuseIdentifier: "AreaCityCell")
        self.areaSearchCollectionView.delegate = self
        self.areaSearchCollectionView.dataSource = self
        self.areaCityCollectionView.delegate = self
        self.areaCityCollectionView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        let areaSearchCell = self.areaSearchCollectionView.cellForItem(at: [0,0]) as? AreaSearchCollectionViewCell
        if self.selectItem == 0 {
            areaSearchCell?.layoutIfNeeded()
            areaSearchCell?.isSelected = true
        }
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
        self.areaSearchCollectionView.allowsMultipleSelection = false
        self.areaCityCollectionView.allowsMultipleSelection = true
        self.areaCityCollectionView.canCancelContentTouches = true
        self.areaCityTagButtonOne.layer.borderWidth = 1
        self.areaCityTagButtonOne.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.areaCityTagButtonOne.backgroundColor = UIColor.white
        self.areaCityTagButtonOne.imageEdgeInsets = UIEdgeInsets(top: 12, left: 90, bottom: 12, right: 12)
        self.areaCityTagButtonOne.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 30)
        self.areaCityTagButtonOne.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.areaCityTagButtonOne.layer.cornerRadius = 4
        self.areaCityTagButtonOne.layer.masksToBounds = true
        self.areaCityTagButtonOne.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.areaCityTagButtonTwo.layer.borderWidth = 1
        self.areaCityTagButtonTwo.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.areaCityTagButtonTwo.backgroundColor = UIColor.white
        self.areaCityTagButtonTwo.contentHorizontalAlignment = .left
        self.areaCityTagButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
        self.areaCityTagButtonTwo.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.areaCityTagButtonTwo.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.areaCityTagButtonTwo.layer.cornerRadius = 4
        self.areaCityTagButtonTwo.layer.masksToBounds = true
        self.areaCityTagButtonTwo.isHidden = true
        self.areaCityTagButtonOne.isHidden = true
        
    }
    
    public func getApiCityCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStatesCiteCodeCall { result in
                
                self.cityChildrenData = result[self.selectItem].children!
                print("데이터 테스트 \(self.cityChildrenData)")
                self.areaCityCollectionView.reloadData()
            }
        }
    }
    public func getApiAreaCode() {
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
        if collectionView == self.areaSearchCollectionView {
            return self.CityData.count
        } else {
            return self.cityChildrenData.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.areaSearchCollectionView {
            let AreaSearchcell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaSearchCell", for: indexPath) as? AreaSearchCollectionViewCell
            AreaSearchcell?.areaTitleButton.setTitle("\(self.CityData[indexPath.item].short_name!)", for: .normal)
            self.firstSelect = indexPath.item
            return AreaSearchcell!
        } else {
            let AreaCitycell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCityCell", for: indexPath) as? AreaCityCollectionViewCell
            AreaCitycell?.areaCityTitleButton.setTitle("\(self.cityChildrenData[indexPath.item].name!)", for: .normal)
            indexPath.forEach { (i) in
                if self.cityChildrenData[i].name == UserDefaults.standard.string(forKey: "areaCityItem") {
                    AreaCitycell?.isSelected = true
                } else {
                    AreaCitycell?.isSelected = false
                }
            }
            return AreaCitycell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.areaSearchCollectionView {
            let areaSearchCell = collectionView.cellForItem(at: [0,0]) as? AreaSearchCollectionViewCell
            let cellItems = collectionView.indexPathsForSelectedItems
            self.count = cellItems!.count
            DispatchQueue.main.async {
                print("indexPath\(indexPath)")
                self.selectItem = indexPath.item
                UserDefaults.standard.set(self.selectItem, forKey: "areaSeachItem")
                print("전달되는 selectitem \(self.selectItem)")
                self.getApiCityCode()
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            if indexPath.item != 0 {
                areaSearchCell?.isSelected = false
            }
        } else {
            let areaCityCell = collectionView.cellForItem(at: indexPath) as? AreaCityCollectionViewCell
            self.citySelctItem = indexPath.item
            print("클릭 넘겨지는 데이터 \(self.cityChildrenData[indexPath.item].name)")
            UserDefaults.standard.set(self.cityChildrenData[indexPath.item].name, forKey: "areaCityItem")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if self.count >= 2 {
            if collectionView == self.areaSearchCollectionView {
                let AreaSearchcell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaSearchCell", for: indexPath) as? AreaSearchCollectionViewCell
                collectionView.deselectItem(at: indexPath, animated: true)
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.areaSearchCollectionView {
            return CGSize(width: 57, height: 32)
        } else {
            return CGSize(width: 90, height: 16)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.areaSearchCollectionView {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.areaSearchCollectionView {
            return 10
        } else {
            return 54
            
        }
    }
}
