//
//  PasswordDefineAlertView.swift
//  BLProJect
//
//  Created by Kim dohyun on 2021/03/18.
//  Copyright © 2021 김도현. All rights reserved.
//

import UIKit

class PasswordDefineAlertView: UIViewController {


    @IBOutlet weak var passwordAlertContainerView: UIView!
    @IBOutlet weak var passwordAlertView: UIView!
    @IBOutlet weak var passwordAlertTilteLabel: UILabel!
    @IBOutlet weak var passwordAlertSubTitleLabel: UILabel!
    @IBOutlet weak var passwordAlertConfirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Bundle.main.loadNibNamed("PasswordDefineAlertView", owner: self, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
