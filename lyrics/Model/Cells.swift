//
//  Cells.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 4..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit

class ListTableCell : UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel?
    @IBOutlet var timeLabel  : UILabel?
    @IBOutlet var checkBtn   : UIButton?
    
    var isChecked : Bool = false
    var delegate : AdjustDataProtocol?
    var data : LyricsListData?
    
    func configure(data:LyricsListData) {
        self.data = data
        self.titleLabel?.text = data.title
        self.timeLabel?.text = data.time
        if isChecked {
            self.checkBtn?.setTitle("O", for: .normal)
        } else {
            self.checkBtn?.setTitle("x", for: .normal)
        }
    }
    
    @IBAction func onCheckBtn(_ sender: UIButton) {
        self.isChecked = !isChecked
        guard let data = self.data else { return }
        if isChecked {
            self.checkBtn?.setTitle("O", for: .normal)
            self.delegate?.addData(data:data)
        } else {
            self.checkBtn?.setTitle("X", for: .normal)
            self.delegate?.removeData(data:data)
        }
    }
}

class EditLyricsTableCell : UITableViewCell {
    
    @IBOutlet var typeLabel     : UILabel?
    @IBOutlet var lyricsLabel   : UILabel?
    
    func configure(data:LyricsData) {
        self.typeLabel?.text = data.type
        self.lyricsLabel?.text = data.lyrics
    }
}

class EditLyricsCollectionCell : UICollectionViewCell {
    @IBOutlet var typeLabel : UILabel?
    
    func configure(data:LyricsData) {
        self.typeLabel?.text = data.type
    }
}
