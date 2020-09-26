//
//  LoginAlertView.swift
//  BLProJect
//
//  Created by 김도현 on 2020/09/22.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit

class LoginAlertView: UIView {

    @IBOutlet weak var LoginBackgroundView: UIView!
    @IBOutlet weak var LoginTitle: UILabel!
    @IBOutlet weak var LoginConfirmBtn: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.CommonInit()
        self.LayoutInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func CommonInit(){
        let LoginView = Bundle.main.loadNibNamed("LoginAlertView", owner: self, options: nil)![0] as? LoginAlertView
        self.addSubview(LoginView!)
    }
    public func LayoutInit(){
        self.LoginBackgroundView.layer.cornerRadius = 10
        self.LoginBackgroundView.layer.masksToBounds = true
        self.LoginBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        self.LoginBackgroundView.layer.borderWidth = 1.0
        self.LoginBackgroundView.frame = CGRect(x: self.LoginBackgroundView.frame.origin.x, y: self.LoginBackgroundView.frame.origin.y, width: self.LoginBackgroundView.frame.size.width, height: self.LoginBackgroundView.frame.size.height)
        
        self.LoginTitle.textAlignment = .center
        self.LoginTitle.numberOfLines = 2
        self.LoginTitle.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 1.0))
        self.LoginTitle.frame = CGRect(x: self.LoginTitle.frame.origin.x, y: self.LoginTitle.frame.origin.y, width: self.LoginTitle.frame.size.width, height: self.LoginTitle.frame.size.height)
        
        self.LoginConfirmBtn.tintColor = UIColor.white
        self.LoginConfirmBtn.backgroundColor = UIColor.black
        self.LoginConfirmBtn.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.LoginConfirmBtn.frame = CGRect(x: self.LoginConfirmBtn.frame.origin.x, y: self.LoginConfirmBtn.frame.origin.y, width: self.LoginConfirmBtn.frame.size.width, height: self.LoginConfirmBtn.frame.size.height)
    }
    
    
    

}
