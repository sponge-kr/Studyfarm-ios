//
//  BLDetailViewController.swift
//  BLProJect
//
//  Created by 김도현 on 2020/08/12.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire






class BLDetailViewController: UIViewController {
    @IBOutlet weak var Detailtitle: UILabel!
    @IBOutlet weak var Detailname: UILabel!
    var DetailText : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Detailtitle.text = DetailText
    }
    
        
}
