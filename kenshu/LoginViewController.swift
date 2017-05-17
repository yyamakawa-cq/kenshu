//
//  ViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/24.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func goBack(seque: UIStoryboardSegue){ }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //初回起動だったらアカウント画面をモーダルで表示
    override func viewDidAppear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: "firstLaunch") {
            let storyboard: UIStoryboard = self.storyboard!
            let firstView = storyboard.instantiateViewController(withIdentifier: "Account")
            present(firstView, animated: true, completion: nil)
            userDefault.set(false, forKey: "firstLaunch")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

