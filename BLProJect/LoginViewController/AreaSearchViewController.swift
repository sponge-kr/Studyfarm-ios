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
    @IBOutlet weak var areaCityTagButtonConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var areaCityTagTwoButtonConstraintWidth: NSLayoutConstraint!
    public var count: Int = 0
    public var cityCount: Int = 0
    public var selectItem: Int = 0
    public var deselectItem: Int = 0
    public var thirdselectedIndexes = [IndexPath]()
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
        let AreaEmptynibName = UINib(nibName: "AreaEmptyCollectionViewCell", bundle: nil)
        self.areaCityCollectionView.register(AreaEmptynibName, forCellWithReuseIdentifier: "areaEmptyCell")
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
        if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[1].count == 4 {
            self.areaCityTagButtonOne.layoutIfNeeded()
            self.areaCityTagButtonConstraintWidth.constant = 130
            self.areaCityTagButtonOne.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        } else {
            self.areaCityTagButtonOne.layoutIfNeeded()
            self.areaCityTagButtonConstraintWidth.constant = 115
            self.areaCityTagButtonOne.imageEdgeInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
            self.areaCityTagButtonOne.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        }
        
        if self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[1].count == 4 {
            self.areaCityTagButtonTwo.layoutIfNeeded()
            self.areaCityTagTwoButtonConstraintWidth.constant = 130
            self.areaCityTagButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        } else {
            self.areaCityTagButtonTwo.layoutIfNeeded()
            self.areaCityTagTwoButtonConstraintWidth.constant = 115
            self.areaCityTagButtonTwo.imageEdgeInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
            self.areaCityTagButtonTwo.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        }
        let navigationAttribute = NSMutableAttributedString()
        navigationAttribute.append(NSAttributedString(string: "지역 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "  \(self.deselectItem)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "/2", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
        let areaNavigationLabel = UILabel()
        areaNavigationLabel.sizeToFit()
        areaNavigationLabel.text = "지역 선택  \(self.deselectItem)/2"
        areaNavigationLabel.attributedText = navigationAttribute
        self.navigationItem.titleView = areaNavigationLabel
    }
    
    private func setInitLayout() {
        let navigationAttribute = NSMutableAttributedString()
        navigationAttribute.append(NSAttributedString(string: "지역 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "  \(self.thirdselectedIndexes.count)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "/2", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
        let areaNavigationLabel = UILabel()
        areaNavigationLabel.sizeToFit()
        areaNavigationLabel.text = "지역 선택  \(self.thirdselectedIndexes.count)/2"
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
        self.areaCityTagButtonOne.contentHorizontalAlignment = .right
        self.areaCityTagButtonOne.imageEdgeInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
        self.areaCityTagButtonOne.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
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
        self.areaCityCollectionView.layer.borderColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0).cgColor
        self.areaCityCollectionView.layer.borderWidth = 1
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
            if self.selectItem >= 3 {
                return 1
            } else {
                return self.cityChildrenData.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.areaSearchCollectionView {
            let AreaSearchcell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaSearchCell", for: indexPath) as? AreaSearchCollectionViewCell
            if indexPath.item >= 3 {
                AreaSearchcell?.setSelectLayout(indexPath: indexPath.item)
                AreaSearchcell?.areaTitleButton.setTitle("\(self.CityData[indexPath.item].short_name!)", for: .normal)
                AreaSearchcell?.areaTitleButton.setTitleColor(UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0), for: .normal)
                AreaSearchcell?.areaTitleButton.setTitleColor(UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0), for: .selected)
            } else {
                AreaSearchcell?.areaTitleButton.setTitle("\(self.CityData[indexPath.item].short_name!)", for: .normal)
                AreaSearchcell?.areaTitleButton.setTitleColor(UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0), for: .normal)
                UserDefaults.standard.set(self.CityData[0].short_name, forKey: "first_name")
            }
            return AreaSearchcell!
        } else {
            if self.selectItem >= 3 && indexPath.item == 0{
                    let AreaEmptycell = collectionView.dequeueReusableCell(withReuseIdentifier: "areaEmptyCell", for: indexPath) as? AreaEmptyCollectionViewCell
                    return AreaEmptycell!
            } else {
                let AreaCitycell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCityCell", for: indexPath) as? AreaCityCollectionViewCell
                print("테스트 City index \(self.thirdselectedIndexes)")
                AreaCitycell?.areaCityTitleButton.setTitle("\(self.cityChildrenData[indexPath.item].name!)", for: .normal)
                
                if self.areaCityTagButtonOne.isHidden == false && self.areaCityTagButtonTwo.isHidden == false {
                    if self.areaCityTagButtonOne.titleLabel?.text!.components(separatedBy: " ")[0] == "서울"  && self.areaCityTagButtonTwo.titleLabel?.text!.components(separatedBy: " ")[0] == "서울" && self.CityData[selectItem].code! - 1  == 0 {
                        collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                    } else if self.areaCityTagButtonOne.titleLabel?.text!.components(separatedBy: " ")[0] == "부산"  && self.areaCityTagButtonTwo.titleLabel?.text!.components(separatedBy: " ")[0] == "부산" && self.CityData[selectItem].code! - 1  == 1  {
                        collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "서울" && self.areaCityTagButtonTwo.titleLabel?.text!.components(separatedBy: " ")[0] == "부산" {
                        if self.CityData[selectItem].code! - 1  == 0 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1  == 1 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "부산" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "서울" {
                        if self.CityData[selectItem].code! - 1  == 1 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1  == 0 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" && self.CityData[selectItem].code! - 1 == 2 {
                        collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "서울" {
                        if self.CityData[selectItem].code! - 1 == 2 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1 == 0 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "부산" {
                        if self.CityData[selectItem].code! - 1 == 2 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1 == 1 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "서울" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" {
                        if self.CityData[selectItem].code! - 1 == 0 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1 == 2 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    } else if self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[0] == "부산" && self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[0] == "대구" {
                        if self.CityData[selectItem].code! - 1 == 1 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.first, animated: false, scrollPosition: .init())
                        } else if self.CityData[selectItem].code! - 1 == 2 {
                            collectionView.selectItem(at: self.thirdselectedIndexes.last, animated: false, scrollPosition: .init())
                        }
                    }
                }
                return AreaCitycell!
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.areaSearchCollectionView {
            let areaSearchCell = collectionView.cellForItem(at: [0,0]) as? AreaSearchCollectionViewCell
            let cellItems = collectionView.indexPathsForSelectedItems
            self.count = cellItems!.count
            DispatchQueue.main.async {
                self.selectItem = indexPath.item
                print("전달되는 selectitem \(self.selectItem)")
                self.getApiCityCode()
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            if indexPath.item != 0 {
                areaSearchCell?.isSelected = false
            }
        } else {
            let areaCityCell = collectionView.cellForItem(at: indexPath) as? AreaCityCollectionViewCell
            self.cityCount = collectionView.indexPathsForSelectedItems!.count
            self.citySelctItem = indexPath.item
            self.deselectItem = self.thirdselectedIndexes.count + 1
            print("select count값 입니다 \(self.thirdselectedIndexes.count)")
            if self.areaCityTagButtonOne.isHidden == true && self.areaCityTagButtonTwo.isHidden == true {
                self.areaCityTagButtonOne.setAttributedTitle(NSAttributedString(string: "\(self.CityData[self.selectItem].short_name!) \(self.cityChildrenData[indexPath.item].name!)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern: -0.77]), for: .normal)
                self.thirdselectedIndexes.append(indexPath)
                self.areaCityTagButtonOne.isHidden = false
                self.areaCityTagButtonOne.setNeedsLayout()
                UserDefaults.standard.set(self.CityData[self.selectItem].code, forKey: "first")
                UserDefaults.standard.set(self.CityData[self.selectItem].short_name, forKey: "first_name")
            } else if self.areaCityTagButtonOne.isHidden == false && self.areaCityTagButtonTwo.isHidden == true {
                self.areaCityTagButtonTwo.setAttributedTitle(NSAttributedString(string: "\(self.CityData[self.selectItem].short_name!) \(self.cityChildrenData[indexPath.item].name!)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern: -0.77]), for: .normal)
                self.thirdselectedIndexes.append(indexPath)
                self.areaCityTagButtonTwo.isHidden = false
                self.areaCityTagButtonTwo.setNeedsLayout()
                UserDefaults.standard.set(self.CityData[self.selectItem].code, forKey: "second")
                UserDefaults.standard.set(self.CityData[self.selectItem].short_name, forKey: "second_name")
            }
            
            if self.areaCityTagButtonOne.isHidden == true && self.areaCityTagButtonTwo.isHidden == false {
                self.areaCityTagButtonOne.setAttributedTitle(NSAttributedString(string: "\(self.CityData[self.selectItem].short_name!) \(self.cityChildrenData[indexPath.item].name!)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern: -0.77]), for: .normal)
                if self.thirdselectedIndexes.count == 1 {
                    self.thirdselectedIndexes.insert(indexPath, at: 0)
                }
                self.areaCityTagButtonOne.isHidden = false
                self.areaCityTagButtonOne.setNeedsLayout()
            } else if self.areaCityTagButtonOne.isHidden == true && self.areaCityTagButtonTwo.isHidden == false {
                self.areaCityTagButtonTwo.setAttributedTitle(NSAttributedString(string: "\(self.CityData[self.selectItem].short_name!) \(self.cityChildrenData[indexPath.item].name!)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.kern: -0.77]), for: .normal)
                self.thirdselectedIndexes.append(indexPath)
                self.areaCityTagButtonTwo.isHidden = false
                self.areaCityTagButtonTwo.setNeedsLayout()
                UserDefaults.standard.set(self.CityData[self.selectItem].code, forKey: "second")
                UserDefaults.standard.set(self.CityData[self.selectItem].short_name, forKey: "second_name")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.areaSearchCollectionView {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else if collectionView == self.areaCityCollectionView {
            let areacityCell = collectionView.cellForItem(at: indexPath) as? AreaCityCollectionViewCell
            let count = collectionView.indexPathsForSelectedItems!.count
            self.deselectItem = self.thirdselectedIndexes.count - 1
            let navigationAttribute = NSMutableAttributedString()
            navigationAttribute.append(NSAttributedString(string: "지역 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "  \(self.thirdselectedIndexes.count - 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "/2", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
            let areaNavigationLabel = UILabel()
            areaNavigationLabel.sizeToFit()
            areaNavigationLabel.text = "지역 선택  \(self.thirdselectedIndexes.count - 1)/2"
            areaNavigationLabel.attributedText = navigationAttribute
            self.navigationItem.titleView = areaNavigationLabel
            if self.areaCityTagButtonOne.isHidden == false && self.areaCityTagButtonTwo.isHidden == false {
                if self.thirdselectedIndexes.first! == indexPath || self.areaCityTagButtonOne.titleLabel?.text?.components(separatedBy: " ")[1] == self.cityChildrenData[indexPath.item].name {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonOne.isHidden = true
                    self.thirdselectedIndexes.removeFirst()
                    collectionView.deselectItem(at: indexPath, animated: true)
                } else {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonTwo.isHidden = true
                    self.thirdselectedIndexes.removeLast()
                    collectionView.deselectItem(at: indexPath, animated: true)
                }
            } else if self.areaCityTagButtonOne.isHidden == false && self.areaCityTagButtonTwo.isHidden == true {
                if self.thirdselectedIndexes.first == indexPath {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonOne.isHidden = true
                    self.thirdselectedIndexes.removeFirst()
                    collectionView.deselectItem(at: indexPath, animated: true)
                } else {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonTwo.isHidden = true
                    self.thirdselectedIndexes.removeLast()
                    collectionView.deselectItem(at: indexPath, animated: true)
                }
            } else {
                if self.thirdselectedIndexes.first! == indexPath || self.areaCityTagButtonTwo.titleLabel?.text?.components(separatedBy: " ")[1] == self.cityChildrenData[indexPath.item].name {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonTwo.isHidden = true
                    self.thirdselectedIndexes.removeFirst()
                    collectionView.deselectItem(at: indexPath, animated: true)
                } else {
                    areacityCell?.isSelected = false
                    self.areaCityTagButtonOne.isHidden = true
                    self.thirdselectedIndexes.removeLast()
                    collectionView.deselectItem(at: indexPath, animated: true)
                }
//                if self.thirdselectedIndexes.first == indexPath {
//                    areacityCell?.isSelected = false
//                    self.areaCityTagButtonOne.isHidden = true
//                    self.thirdselectedIndexes.removeFirst()
//                    collectionView.deselectItem(at: indexPath, animated: true)
//                } else {
//                    areacityCell?.isSelected = false
//                    self.areaCityTagButtonTwo.isHidden = true
//                    self.thirdselectedIndexes.removeLast()
//                    collectionView.deselectItem(at: indexPath, animated: true)
//                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView == self.areaCityCollectionView {
            return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 2
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.areaSearchCollectionView {
            return CGSize(width: 57, height: 32)
        } else {
            if self.selectItem >= 3 && indexPath.item == 0 {
                return CGSize(width: 350, height: 360)
            } else {
                return CGSize(width: 90, height: 16)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.areaSearchCollectionView {
            return 20
        } else {
            print("첫번째 셋션 \(section)")
            if self.selectItem >= 3 && section == 0 {
                return 0
            } else {
                return 10
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.areaCityCollectionView {
            return UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.areaSearchCollectionView {
            return 10
        } else {
            if self.selectItem >= 3  && section == 0 {
                return 0
            } else {
                return 40
            }
        }
    }
}
