//
//  ReplyViewController.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/02/28.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit
import Alamofire
class ReplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var RepliesAlltabelview: UITableView!
    @IBOutlet weak var RepliesAllCommentAreaView: UIView!
    @IBOutlet weak var RepliesAllCommentBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var RepliesAllTextfield: UITextField!
    @IBOutlet weak var RepliesAllConfirmBtn: UIButton!
    public var isKeyboard : Bool = true
    var ReplyIndex : Int = 0
    public var ReplyParamter : Parameters?
    public var ReplyData = [RepliesContent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationLayouInit()
        self.RepliesAlltabelview.estimatedRowHeight = UITableView.automaticDimension
        self.RepliesAlltabelview.rowHeight = UITableView.automaticDimension
        self.RepliesAlltabelview.delegate = self
        self.RepliesAlltabelview.dataSource = self
        self.RepliesAlltabelview.separatorInset.left = 20
        self.RepliesAlltabelview.separatorInset.right = 20
        self.RepliesAllTextfield.clearButtonMode = .whileEditing
        self.RepliesAllTextfield.delegate = self
        self.RepliesAlltabelview.separatorColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        let nibName = UINib(nibName: "RepliesAllTableViewCell", bundle: nil)
        self.RepliesAlltabelview.register(nibName, forCellReuseIdentifier: "RepliesAllCell")
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.RepliesAllConfirmBtn.addTarget(self, action: #selector(self.RepliesConfirm), for: .touchUpInside)
        self.ReplyAreaViewLayout()
        self.RepliesAllTextfield.clearButtonMode = .whileEditing
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    private func setNavigationLayouInit() {
        let NavigationAttribute = NSMutableAttributedString()
        NavigationAttribute.append(NSAttributedString(string: "댓글", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)]))
        NavigationAttribute.append(NSAttributedString(string: " \(self.ReplyData.count)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0),NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16)]))
        let navigationLabel = UILabel()
        navigationLabel.sizeToFit()
        navigationLabel.text = "댓글 \(self.ReplyData.count)"
        navigationLabel.attributedText = NavigationAttribute
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.titleView = navigationLabel
    }
    
    private func ReplyAreaViewLayout() {
        self.RepliesAllTextfield.layer.borderWidth = 1
        self.RepliesAllTextfield.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0).cgColor
        self.RepliesAllTextfield.layer.cornerRadius = 5
        self.RepliesAllTextfield.layer.masksToBounds = true
        self.RepliesAllTextfield.placeholder = "댓글을 남겨보세요."
        self.RepliesAllTextfield.attributedPlaceholder = NSAttributedString(string: "댓글을 남겨보세요.", attributes: [NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 14),NSAttributedString.Key.foregroundColor : UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)])
        self.RepliesAllConfirmBtn.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.RepliesAllConfirmBtn.setTitle("등록", for: .normal)
        self.RepliesAllConfirmBtn.setTitleColor(UIColor.white, for: .normal)
        self.RepliesAllConfirmBtn.layer.cornerRadius = 3
        self.RepliesAllConfirmBtn.layer.masksToBounds = true
        let TextFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        self.RepliesAllTextfield.leftView = TextFieldView
        self.RepliesAllTextfield.leftViewMode = .always
    }
    
    @objc
    func RepliesConfirm(){
        if self.RepliesAllTextfield.text == ""{
            self.RepliesAllConfirmBtn.isEnabled = false
        } else {
            self.RepliesAllConfirmBtn.isEnabled = true
            let Paramter = RepliesParameter(study_seq: self.ReplyIndex, content: self.RepliesAllTextfield.text!, parent_reply_seq: nil)
            
            
            RepliesApi.shared.studyRepliesPostFetch(RepliesParamter: Paramter) { [weak self] result in
                switch result {
                case .success(let value):
                    if value == true {
                        RepliesApi.shared.StudyRepliesCall(study_seq: self!.ReplyIndex, RepliesParamter: self!.ReplyParamter!) { result in
                            DispatchQueue.main.async {
                                self?.ReplyData = result
                                self?.RepliesAlltabelview.reloadData()
                                self?.setNavigationLayouInit()
                                self?.RepliesAllTextfield.text = ""
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification : Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            let keyboardHeight = keyboardValue.cgRectValue.height
            print("keyboard 호출 ")
        if self.isKeyboard == true {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
                self.RepliesAllCommentBottomConstraint.constant -= (keyboardHeight - self.view.safeAreaInsets.bottom)
                self.RepliesAllCommentAreaView.translatesAutoresizingMaskIntoConstraints = false
                self.RepliesAllCommentAreaView.setNeedsLayout()
            })
        }
        self.isKeyboard = false
    }
    
    @objc
    private func keyboardWillHide(_ notification : Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardHeight = keyboardValue.cgRectValue.height
        if self.isKeyboard == false {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
                self.RepliesAllCommentBottomConstraint.constant += keyboardHeight - self.view.safeAreaInsets.bottom
                self.RepliesAllCommentAreaView.translatesAutoresizingMaskIntoConstraints = false
                self.RepliesAllCommentAreaView.setNeedsLayout()
            })
        }
        self.isKeyboard = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ReplyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let RepliesAllCell = tableView.dequeueReusableCell(withIdentifier: "RepliesAllCell", for: indexPath) as? RepliesAllTableViewCell
        
        RepliesAllCell?.RepliesAllUserNickname.text = self.ReplyData[indexPath.row].writer!.nickname
        RepliesAllCell?.RepliesAllUserDate.text = self.ReplyData[indexPath.row].reply_created_at
        RepliesAllCell?.RepliesAllUserContent.text = self.ReplyData[indexPath.row].content
      
        
        return RepliesAllCell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
