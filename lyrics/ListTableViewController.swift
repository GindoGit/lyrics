//
//  ListTableViewController.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 3..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

protocol AdjustDataProtocol : class {
    func addData(data:LyricsListData)
    func removeData(data:LyricsListData)
}

class ListTableViewController : UITableViewController {
    
    var lyricsArr : [LyricsListData] = []
    var sendDataArr : [LyricsListData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        let firstData = LyricsListData(title: "주님 다시오실 때까지", time: "today", typeArr: [LyricsData(type:"<V1>", lyrics:"벌스"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<V2>", lyrics:"벌스2"), LyricsData(type:"<P.C>", lyrics:"프리 코러스"), LyricsData(type:"<B>", lyrics:"브릿지")], lyricsArr: [LyricsData(type:"<V1>", lyrics:"벌스"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<V2>", lyrics:"벌스2"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<P.C>", lyrics:"프리 코러스"), LyricsData(type:"<B>", lyrics:"브릿지")])
        
        let secondData = LyricsListData(title: "나는 주의 친구", time: "today", typeArr: [LyricsData(type:"<V1>", lyrics:"벌스"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<V2>", lyrics:"벌스2"), LyricsData(type:"<P.C>", lyrics:"프리 코러스"), LyricsData(type:"<B>", lyrics:"브릿지")], lyricsArr: [LyricsData(type:"<V1>", lyrics:"벌스"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<V2>", lyrics:"벌스2"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<P.C>", lyrics:"프리 코러스"), LyricsData(type:"<B>", lyrics:"브릿지")])
        self.lyricsArr.append(firstData)
        self.lyricsArr.append(secondData)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? EditViewController, segue.identifier == "showEditVCSG", let cell = sender as? ListTableCell, let indexPath = self.tableView.indexPath(for: cell) {
            dest.typeArr = self.lyricsArr[indexPath.row].typeArr
            dest.lyricsArr = self.lyricsArr[indexPath.row].lyricsArr
            dest.title = cell.titleLabel?.text
        }
    }
}

extension ListTableViewController : AdjustDataProtocol {
    func addData(data: LyricsListData) {
        self.sendDataArr.append(data)
        print(self.sendDataArr)
    }
    
    func removeData(data: LyricsListData) {
        if let index = self.sendDataArr.index(where: { $0 == data }) {
            self.sendDataArr.remove(at: index)
            print(self.sendDataArr)
        }
    }
}

extension ListTableViewController {
    //dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lyricsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableCell {
            cell.delegate = self
            cell.configure(data:self.lyricsArr[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "showEditVCSG", sender: cell)
    }
}

extension ListTableViewController : MFMailComposeViewControllerDelegate {
    @IBAction func sendMail(sender: AnyObject) { //메일 보내기 버튼 선택시
        
        if self.sendDataArr.isEmpty {
            let sendMailErrorAlert = UIAlertController(title: "Error", message: "전송할 데이터가 없습니다.", preferredStyle: .alert)
            sendMailErrorAlert.addAction(UIAlertAction(title: "예", style: .cancel, handler: nil))
            self.present(sendMailErrorAlert, animated: true, completion: nil)
            return
        }
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
            print("can send mail")
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["podo4361@naver.com"])
        mailComposerVC.setSubject("유병재 IOS 문의 메일")
        
        var data = ""
        for i in 0..<self.sendDataArr.count {
            data.append("\n\(i+1). \(self.sendDataArr[i].title)\n\n")
            for j in 0..<self.sendDataArr[i].lyricsArr.count {
                data.append("\(self.sendDataArr[i].lyricsArr[j].type)\n")
                data.append("\(self.sendDataArr[i].lyricsArr[j].lyrics)\n")
            }
        }
        
        mailComposerVC.setMessageBody(data, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "예", style: .cancel, handler: nil))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
