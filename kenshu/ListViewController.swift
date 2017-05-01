//
//  ListViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate {
    
    @IBAction func goBack(seque: UIStoryboardSegue){ }
    
    let booktitle = ["本の名前1","本の名前2","本の名前3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int{
    return 0
}
func tableView(tableView: UITableView, cellForRowAtIndexPath indexpPath: NSIndexPath) -> UITableViewCell{
    return UITableViewCell()
}
func tableView(tableView:UITableView, didSelectRowAtIndexPath: NSIndexPath){}
