//
//  ListViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func goBack(seque: UIStoryboardSegue){ }
    
    let bookImage = ["NEKOIMG_1.jpg","NEKOIMG_2.jpg","NEKOIMG_3.jpg","NEKOIMG_4.jpg","NEKOIMG_5.jpg"]
    let bookTitle = ["ネコ1","ネコ2","ネコ3","ネコ4","ネコ5"]
    let bookDiscription = ["説明1","説明2","説明3","説明4","説明5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの個数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookImage.count
    }
    //セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell{
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CustomTableViewCell
        //セルに値を設定
        cell.bookImage.image = UIImage(named: bookImage[indexPath.row])
        cell.bookTitle.text = bookTitle[indexPath.row]
        cell.bookDiscription.text = bookDiscription[indexPath.row]
        return cell
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

