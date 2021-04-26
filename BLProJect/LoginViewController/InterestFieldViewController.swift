//
//  InterestFieldViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/04/10.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class InterestFieldViewController: UIViewController {
    @IBOutlet weak var InterestKindTitleLabel: UILabel!
    @IBOutlet weak var InterestSubjectTitleLabel: UILabel!
    @IBOutlet weak var InterestConfirmButton: UIButton!
    @IBOutlet weak var InterestKindTableView: UITableView!
    @IBOutlet weak var InteresetContainerView: UIView!
    @IBOutlet weak var InterestSubjectTableView: UITableView!
    @IBOutlet weak var InterestSubjectTagOneButton: UIButton!
    @IBOutlet weak var InterestSubjectTagTwoButton: UIButton!
    @IBOutlet weak var InterestSubjectTagThreeButton: UIButton!
    public var selectItem: Int = 0
    public var subjectselectItem: Int = 0
    public var subjectIndexPath = [IndexPath]()
    private var interestKindData = [StudyContentsContainer]()
    private var interestSubjectData = [StudyChildrenContainer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayoutInit()
        self.sendInterestKindCode()
        let nib = UINib(nibName: "InterestTableViewCell", bundle: nil)
        self.InterestKindTableView.register(nib, forCellReuseIdentifier: "InterestCell")
        let subjectNib = UINib(nibName: "InterestSubjectTableViewCell", bundle: nil)
        self.InterestSubjectTableView.register(subjectNib, forCellReuseIdentifier: "InterestSubjectCell")
    }
    
    private func setLayoutInit() {
        let navigationAttribute = NSMutableAttributedString()
        navigationAttribute.append(NSAttributedString(string: "관심 분야 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "  \(self.subjectIndexPath.count)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
        navigationAttribute.append(NSAttributedString(string: "/3", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
        let interestNavigationLabel = UILabel()
        interestNavigationLabel.sizeToFit()
        interestNavigationLabel.text = "관심 분야 선택  \(self.subjectIndexPath.count)/3"
        interestNavigationLabel.attributedText = navigationAttribute
        self.navigationItem.titleView = interestNavigationLabel
        
        self.InterestKindTitleLabel.text = "종류"
        self.InterestKindTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        self.InterestKindTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.InterestSubjectTitleLabel.text = "과목"
        self.InterestSubjectTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        self.InterestSubjectTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.InterestConfirmButton.layer.cornerRadius = 4
        self.InterestConfirmButton.layer.masksToBounds = true
        self.InterestConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.InterestConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.InterestConfirmButton.setTitle("확인", for: .normal)
        self.InterestKindTableView.delegate = self
        self.InterestKindTableView.dataSource = self
        self.InterestSubjectTableView.delegate = self
        self.InterestSubjectTableView.dataSource = self
        self.InterestSubjectTableView.allowsMultipleSelection = true
        self.InteresetContainerView.layer.borderWidth = 1
        self.InteresetContainerView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.InteresetContainerView.layer.cornerRadius = 10
        self.InteresetContainerView.layer.masksToBounds = true
        self.InterestKindTableView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.InterestKindTableView.layer.borderWidth = 1
        self.InterestKindTableView.separatorInset = .zero
        self.InterestSubjectTableView.separatorInset = .zero
        self.InterestSubjectTableView.layer.borderWidth = 1
        self.InterestSubjectTableView.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
        self.InterestSubjectTagOneButton.layer.borderWidth = 1
        self.InterestSubjectTagOneButton.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.InterestSubjectTagOneButton.layer.cornerRadius = 4
        self.InterestSubjectTagOneButton.layer.masksToBounds = true
        self.InterestSubjectTagOneButton.contentHorizontalAlignment = .right
        self.InterestSubjectTagOneButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.InterestSubjectTagOneButton.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.InterestSubjectTagOneButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 66, bottom: 0, right: 0)
        self.InterestSubjectTagOneButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 45)
        self.InterestSubjectTagOneButton.backgroundColor = UIColor.white
        self.InterestSubjectTagOneButton.isHidden = true
        
        self.InterestSubjectTagTwoButton.layer.borderWidth = 1
        self.InterestSubjectTagTwoButton.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.InterestSubjectTagTwoButton.layer.cornerRadius = 4
        self.InterestSubjectTagTwoButton.layer.masksToBounds = true
        self.InterestSubjectTagTwoButton.contentHorizontalAlignment = .right
        self.InterestSubjectTagTwoButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.InterestSubjectTagTwoButton.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.InterestSubjectTagTwoButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 66, bottom: 0, right: 0)
        self.InterestSubjectTagTwoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 45)
        self.InterestSubjectTagTwoButton.backgroundColor = UIColor.white
        self.InterestSubjectTagTwoButton.isHidden = true
        
        
        self.InterestSubjectTagThreeButton.layer.borderWidth = 1
        self.InterestSubjectTagThreeButton.layer.borderColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0).cgColor
        self.InterestSubjectTagThreeButton.layer.cornerRadius = 4
        self.InterestSubjectTagThreeButton.layer.masksToBounds = true
        self.InterestSubjectTagThreeButton.contentHorizontalAlignment = .right
        self.InterestSubjectTagThreeButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.InterestSubjectTagThreeButton.setImage(UIImage(named: "Delete.png"), for: .normal)
        self.InterestSubjectTagThreeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 66, bottom: 0, right: 0)
        self.InterestSubjectTagThreeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 45)
        self.InterestSubjectTagThreeButton.backgroundColor = UIColor.white
        self.InterestSubjectTagThreeButton.isHidden = true
        
    }
    private func sendInterestKindCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStudyCategoryCall { result in
                self.interestKindData = result
                self.InterestKindTableView.reloadData()
            }
        }
    }
    
    private func sendIntrestSubjectCode() {
        DispatchQueue.main.async {
            UtilApi.shared.UtilStudyCategoryCall { result in
                self.interestSubjectData = result[self.selectItem].children!
                self.InterestSubjectTableView.reloadData()
            }
        }
    }
    
}


extension InterestFieldViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.InterestKindTableView {
            return self.interestKindData.count
        } else {
            return self.interestSubjectData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.InterestKindTableView {
            let interestCell = tableView.dequeueReusableCell(withIdentifier: "InterestCell", for: indexPath) as? InterestTableViewCell
            interestCell?.interesetKindLabel.text = "\(self.interestKindData[indexPath.row].name!)"
                
            return interestCell!
        } else {
            let interestSubjectCell = tableView.dequeueReusableCell(withIdentifier: "InterestSubjectCell", for: indexPath) as? InterestSubjectTableViewCell
            interestSubjectCell?.InterestSubjectLabel.text = "\(self.interestSubjectData[indexPath.row].name!)"
//            print("테스트 값 \(self.InterestSubjectTagOneButton.titleLabel?.text) 저장 값 \(UserDefaults.standard.string(forKey: "first_Intrest_name")) 데이터 \(self.interestSubjectData[self.subjectselectItem].name) ")
            //기타 중복 문구 예외 처리
            if self.InterestSubjectTagOneButton.isHidden == false {
                if self.InterestSubjectTagOneButton.titleLabel?.text == interestSubjectCell?.InterestSubjectLabel.text {
                    tableView.selectRow(at: self.subjectIndexPath.first, animated: false, scrollPosition: .none)
                }
            }
            if self.InterestSubjectTagTwoButton.isHidden == false {
                if self.InterestSubjectTagTwoButton.titleLabel?.text == interestSubjectCell?.InterestSubjectLabel.text {
                    tableView.selectRow(at: self.subjectIndexPath[1], animated: false, scrollPosition: .none)
                }
            }
            if self.InterestSubjectTagThreeButton.isHidden == false {
                if self.InterestSubjectTagThreeButton.titleLabel?.text == interestSubjectCell?.InterestSubjectLabel.text {
                    tableView.selectRow(at: self.subjectIndexPath.last, animated: false, scrollPosition: .none)
                }
            }
            
            return interestSubjectCell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.InterestKindTableView {
            DispatchQueue.main.async {
                self.selectItem = indexPath.row
                self.sendIntrestSubjectCode()
            }
        } else {
            let navigationAttribute = NSMutableAttributedString()
            navigationAttribute.append(NSAttributedString(string: "관심 분야 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "  \(self.subjectIndexPath.count + 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "/3", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
            let interestNavigationLabel = UILabel()
            interestNavigationLabel.sizeToFit()
            interestNavigationLabel.text = "관심 분야 선택  \(self.subjectIndexPath.count + 1)/3"
            interestNavigationLabel.attributedText = navigationAttribute
            self.navigationItem.titleView = interestNavigationLabel
            self.subjectselectItem = indexPath.row
            if self.InterestSubjectTagOneButton.isHidden == true {
                self.InterestSubjectTagOneButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                self.InterestSubjectTagOneButton.setTitle("\(self.interestSubjectData[indexPath.row].name!)", for: .normal)
                self.InterestSubjectTagOneButton.isHidden = false
                self.subjectIndexPath.append(indexPath)
                UserDefaults.standard.set(self.interestSubjectData[indexPath.row].name!, forKey: "first_Intrest_name")
            } else if self.InterestSubjectTagTwoButton.isHidden == true {
                self.InterestSubjectTagTwoButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                self.InterestSubjectTagTwoButton.setTitle("\(self.interestSubjectData[indexPath.row].name!)", for: .normal)
                self.InterestSubjectTagTwoButton.isHidden = false
                self.subjectIndexPath.append(indexPath)
                UserDefaults.standard.set(self.interestSubjectData[indexPath.row].name!, forKey: "second_Intrest_name")
            } else if self.InterestSubjectTagThreeButton.isHidden == true {
                self.InterestSubjectTagThreeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                self.InterestSubjectTagThreeButton.setTitle("\(self.interestSubjectData[indexPath.row].name!)", for: .normal)
                self.InterestSubjectTagThreeButton.isHidden = false
                self.subjectIndexPath.append(indexPath)
                UserDefaults.standard.set(self.interestSubjectData[indexPath.row].name!, forKey: "three_Intrest_name")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.InterestKindTableView {
            
        } else {
            let navigationAttribute = NSMutableAttributedString()
            navigationAttribute.append(NSAttributedString(string: "관심 분야 선택", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "  \(self.subjectIndexPath.count - 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]))
            navigationAttribute.append(NSAttributedString(string: "/3", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),NSAttributedString.Key.foregroundColor: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)]))
            let interestNavigationLabel = UILabel()
            interestNavigationLabel.sizeToFit()
            interestNavigationLabel.text = "관심 분야 선택  \(self.subjectIndexPath.count - 1)/3"
            interestNavigationLabel.attributedText = navigationAttribute
            self.navigationItem.titleView = interestNavigationLabel
            if self.InterestSubjectTagOneButton.isHidden == false && self.subjectIndexPath.first == indexPath {
                if self.interestSubjectData[indexPath.row].name == self.InterestSubjectTagOneButton.titleLabel?.text {
                    self.InterestSubjectTagOneButton.isHidden = true
                    self.subjectIndexPath.removeFirst()
                }
            }
            if self.InterestSubjectTagTwoButton.isHidden == false && self.subjectIndexPath[1] == indexPath && self.InterestSubjectTagOneButton.isHidden == false {
                if self.interestSubjectData[indexPath.row].name == self.InterestSubjectTagTwoButton.titleLabel?.text {
                    self.InterestSubjectTagTwoButton.isHidden = true
                    self.subjectIndexPath.remove(at: 1)
                }
            }
            if self.subjectIndexPath.isEmpty == false {
                if self.InterestSubjectTagOneButton.isHidden == true && self.subjectIndexPath[0] == indexPath {
                    if self.interestSubjectData[indexPath.row].name == self.InterestSubjectTagTwoButton.titleLabel?.text {
                        self.InterestSubjectTagTwoButton.isHidden = true
                        self.subjectIndexPath.removeFirst()
                    }
                }
            }
            if self.InterestSubjectTagThreeButton.isHidden == false && self.subjectIndexPath.last == indexPath {
                if self.interestSubjectData[indexPath.row].name == self.InterestSubjectTagThreeButton.titleLabel?.text {
                    self.InterestSubjectTagThreeButton.isHidden = true
                    self.subjectIndexPath.removeLast()
                }
            }
        }
    }
}
