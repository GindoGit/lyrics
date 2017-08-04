//
//  EditViewController.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 3..
//  Copyright © 2017년 유병재. All rights reserved.
//

import UIKit

class EditViewController : UITableViewController {
    
    @IBOutlet var collectionView : UICollectionView?
    var typeArr     : [LyricsData] = []
    var lyricsArr   : [LyricsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
    }
    
    @IBAction func onPressedSaveBtn(_ sender:Any) {}
}

extension EditViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lyricsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "lyricsCell", for: indexPath) as? EditLyricsTableCell {
            cell.configure(data: self.lyricsArr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.lyricsArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension EditViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.typeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lyricsTypeCell", for: indexPath) as? EditLyricsCollectionCell {
            cell.configure(data: self.typeArr[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension EditViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = CGFloat(1.0)
        cell.layer.cornerRadius = CGFloat(25.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.lyricsArr.append(self.typeArr[indexPath.row])
        self.tableView.reloadData()
    }
}

extension EditViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let frame = self.collectionView?.frame {
            return CGSize(width: (frame.width - 40) / 3, height: 50.0)
        }
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout, self.typeArr.count > 1 {
            return layout.sectionInset
        }
        return UIEdgeInsets.zero
    }
}
