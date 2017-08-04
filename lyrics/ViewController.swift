//
//  ViewController.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 3..
//  Copyright © 2017년 유병재. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var loginBtn              : UIButton?
    @IBOutlet var inputPasswordField    : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton?) {
        if self.inputPasswordField?.text == "avec", let navigation = self.storyboard?.instantiateViewController(withIdentifier: "navi") {
            self.present(navigation, animated: true, completion: nil)
        }
    }


}

