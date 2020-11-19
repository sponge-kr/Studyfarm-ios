//
//  BLMainCollectionViewCell.swift
//  BLProJect
//
//  Created by 김도현 on 19/07/2020.
//  Copyright © 2020 김도현. All rights reserved.
//

import UIKit

class BLMainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CellCardView: UIView!
    @IBOutlet weak var CellSubject: UILabel!
    @IBOutlet weak var CellWriter: UILabel!
    @IBOutlet weak var CellHuman: UILabel!
    @IBOutlet weak var CellStartDate: UILabel!
    @IBOutlet weak var CellState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initCellLayout()
        self.TraitCellLayout()
        // Initialization code
    }
    
    
    // MARK : initiailzation Cell Layout Code
    public func initCellLayout(){
        self.CellHuman.frame = CGRect(x: self.CellHuman.frame.origin.x, y: self.CellHuman.frame.origin.y, width: self.CellHuman.frame.size.width, height: self.CellHuman.frame.size.height)
        self.CellWriter.frame = CGRect(x: self.CellWriter.frame.origin.x, y: self.CellWriter.frame.origin.y, width: self.CellWriter.frame.size.width, height: self.CellWriter.frame.size.height)
        self.CellSubject.frame = CGRect(x: self.CellSubject.frame.origin.x, y: self.CellSubject.frame.origin.y, width: self.CellSubject.frame.size.width, height: self.CellSubject.frame.size.height)
        self.CellStartDate.frame = CGRect(x: self.CellStartDate.frame.origin.x, y: self.CellStartDate.frame.origin.y, width: self.CellStartDate.frame.size.width, height: self.CellStartDate.frame.height)
        self.CellState.frame = CGRect(x: self.CellState.frame.origin.x, y: self.CellState.frame.origin.y, width: self.CellState.frame.size.width, height: self.CellState.frame.size.height)
        self.CellCardView.frame = CGRect(x: self.CellCardView.frame.origin.x, y: self.CellCardView.frame.origin.y, width: self.CellCardView.frame.size.width, height: self.CellCardView.frame.size.height)
    }
    
    // MARK : Cell insert to Data
    private func TraitCellLayout(){
        self.CellHuman.textAlignment = .left
        self.CellHuman.textColor = UIColor(red: 87/255, green: 80/255, blue: 80/255, alpha: 1.0)
        self.CellHuman.font = UIFont.systemFont(ofSize: 14)
        
        self.CellWriter.textAlignment = .left
        self.CellWriter.textColor = UIColor(red: 87/255, green: 88/255, blue: 80/255, alpha: 1.0)
        self.CellWriter.font = UIFont.systemFont(ofSize: 14)
        
        self.CellSubject.textAlignment = .left
        self.CellSubject.textColor = .black
        self.CellSubject.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(1.0))
        
        self.CellStartDate.textAlignment = .left
        self.CellStartDate.textColor = .lightGray
        self.CellStartDate.font = UIFont.systemFont(ofSize: 12)
        
        self.CellState.textAlignment = .left
        self.CellState.textColor = .black
        self.CellState.font = UIFont.systemFont(ofSize: 12)
        self.CellState.numberOfLines = 3
        
        self.CellCardView.layer.masksToBounds = true
        self.CellCardView.layer.cornerRadius = 12
        self.CellCardView.layer.shadowColor = UIColor.gray.cgColor
        self.CellCardView.layer.shadowOffset = CGSize(width: 100, height: 100)
        self.CellCardView.layer.shadowOpacity = 0.7
        
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
    }

}

