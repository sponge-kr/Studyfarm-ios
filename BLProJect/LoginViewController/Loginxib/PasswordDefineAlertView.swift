//
//  PasswordDefineAlertView.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/18.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class PasswordDefineAlertView: UIView {


    @IBOutlet weak var passwordAlertContainerView: UIView!
    @IBOutlet weak var passwordAlertView: UIView!
    @IBOutlet weak var passwordAlertTilteLabel: UILabel!
    @IBOutlet weak var passwordAlertSubTitleLabel: UILabel!
    @IBOutlet weak var passwordAlertConfirmButton: UIButton!
    static let instance = PasswordDefineAlertView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("PasswordDefineAlertView", owner: self, options: nil)
        self.setAlertLayoutInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setAlertLayoutInit() {
        self.passwordAlertContainerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.passwordAlertContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.passwordAlertContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.passwordAlertView.layer.cornerRadius = 4
        self.passwordAlertView.layer.masksToBounds = true
        self.passwordAlertTilteLabel.text = "비밀번호가 변경되었습니다."
        self.passwordAlertTilteLabel.textAlignment = .center
        self.passwordAlertTilteLabel.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0)
        self.passwordAlertTilteLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        self.passwordAlertSubTitleLabel.attributedText = NSAttributedString(string: "새로운 비밀번호로 로그인해주세요.", attributes: [NSAttributedString.Key.kern: -0.77])
        self.passwordAlertSubTitleLabel.textAlignment = .left
        self.passwordAlertSubTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.passwordAlertSubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        self.passwordAlertConfirmButton.setAttributedTitle(NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)]), for: .normal)
        self.passwordAlertConfirmButton.setTitleColor(UIColor.white, for: .normal)
        self.passwordAlertConfirmButton.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.passwordAlertConfirmButton.layer.cornerRadius = 8
        self.passwordAlertConfirmButton.layer.masksToBounds = true
    }
    
    public func presentAlert() {
        UIApplication.shared.keyWindow?.addSubview(self.passwordAlertContainerView)
    }

}
