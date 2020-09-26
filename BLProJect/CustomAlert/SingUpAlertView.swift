//
//  SingUpAlertView.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/23.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit

class SingUpAlertView: UIView {
    @IBOutlet weak var AlertBackground: UIView!
    @IBOutlet weak var AlertConfirmBtn: UIButton!
    @IBOutlet weak var AlertTitle: UILabel!
    var title = ""
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        self.SetCustomView()

    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func commonInit(){
        let SingAlertView = Bundle.main.loadNibNamed("SingUpAlertView", owner: self, options: nil)![0] as? SingUpAlertView
        self.addSubview(SingAlertView!)
    }

    @IBAction func Confirmdismiss(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    public func SetCustomView(){
        self.AlertBackground.layer.cornerRadius = 10
        self.AlertBackground.layer.masksToBounds = true
        self.AlertBackground.frame = CGRect(x: self.AlertBackground.frame.origin.x, y: self.AlertBackground.frame.origin.y, width: self.AlertBackground.frame.size.width, height: self.AlertBackground.frame.size.height)

        self.AlertTitle.tintColor = UIColor.black
        self.AlertTitle.textAlignment = .center
        self.AlertTitle.numberOfLines = 1
        self.AlertTitle.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(1.0))
        self.AlertTitle.frame = CGRect(x: self.AlertTitle.frame.origin.x, y: self.AlertTitle.frame.origin.y, width: self.AlertTitle.frame.size.width, height: self.AlertTitle.frame.size.height)
        
        
        self.AlertConfirmBtn.tintColor = UIColor.white
        self.AlertConfirmBtn.backgroundColor = UIColor.black
        self.AlertConfirmBtn.setAttributedTitle(NSAttributedString(attributedString: NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 1.0))])), for: .normal)
        self.AlertConfirmBtn.frame = CGRect(x: self.AlertConfirmBtn.frame.origin.x, y: self.AlertConfirmBtn.frame.origin.y, width: self.AlertConfirmBtn.frame.size.width, height: self.AlertConfirmBtn.frame.size.height)
    }
    
}
