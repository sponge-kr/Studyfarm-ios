//
//  BLSlideViewController.swift
//  BLProJect
//
//  Created by 김도현 on 26/07/2020.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit
import SnapKit


class BLSlideViewController: UIViewController {
    @IBOutlet weak var LeftView: UIView!
    @IBOutlet weak var LeftBackButton: UIButton!
    @IBOutlet weak var SlideSettingButton: UIButton!
    @IBOutlet weak var SlideProfileButton: UIButton!
    @IBOutlet weak var SlideLoginButton: UIButton!
    @IBOutlet weak var SlideLoginPlacehoder: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AutoLayoutView()
        self.LayoutSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.LeftBackButton.transform =  CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    public func LayoutSetup(){
        //MARK - NavigationBar
        self.navigationItem.hidesBackButton = true
        
    
        
        //MARK - LeftView
        self.LeftView.backgroundColor = UIColor.black
        self.LeftView.frame = CGRect(x: self.LeftView.frame.origin.x, y: self.LeftView.frame.origin.y, width: self.LeftView.frame.size.width, height: self.LeftView.frame.size.height)
        
        //MARK - LeftBackButton
        self.LeftBackButton.setImage(UIImage(named: "delete.png"), for: .normal)
        self.LeftBackButton.setTitle("", for: .normal)
        self.LeftBackButton.tintColor = UIColor.white
        self.LeftBackButton.addTarget(self, action: #selector(LeftBackButtonAction), for: .touchUpInside)
        
        //MARK - SlideProfileButton
        self.SlideProfileButton.setAttributedTitle(NSAttributedString(string: "내 정보", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]), for: .normal)
        self.SlideProfileButton.tintColor = UIColor.black
        self.SlideProfileButton.layer.addBorder([.bottom], color: UIColor.black, width: 3)
        
        //MARK - SlideSettingButton
        self.SlideSettingButton.setAttributedTitle(NSAttributedString(string: "설정", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]), for: .normal)
        self.SlideSettingButton.tintColor = UIColor.black
        self.SlideSettingButton.layer.addBorder([.bottom], color: UIColor.black, width: 3)
        
        //MARK - SlideLoginButton
        self.SlideLoginButton.backgroundColor = UIColor.white
        self.SlideLoginButton.tintColor = UIColor.black
        self.SlideLoginButton.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 1.0))]), for: .normal)
        self.SlideLoginButton.layer.cornerRadius = 5.0
        
        //MARK - SlideLoginPlacehoder
        self.SlideLoginPlacehoder.text = "로그인후 사용이 가능합니다"
        self.SlideLoginPlacehoder.textAlignment = .center
        self.SlideLoginPlacehoder.textColor = UIColor.lightGray
        self.SlideLoginPlacehoder.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    private func AutoLayoutView(){
        self.LeftView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(204)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(34)
            make.width.equalTo(self.view.frame.size.width / 2)
        }
    }
    
    
    @objc func LeftBackButtonAction(){
        UIView.animate(withDuration: 0.2, animations: {
            self.LeftBackButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        }) { (animated) in
             self.navigationController?.popViewController(animated: animated)
        }
        
    }
    
    
}


extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


