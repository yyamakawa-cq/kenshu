//
//  BookListViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func goBack(seque: UIStoryboardSegue){ }
    
    let bookImage = ["NEKOIMG_1.jpg","NEKOIMG_2.jpg","NEKOIMG_3.jpg","NEKOIMG_4.jpg","NEKOIMG_5.jpg"]
    let bookTitle = ["ネコ1","ネコ2","ネコ3","ネコ4","ネコ5"]
    let bookPrice = ["1000円","2000円","3000円","4000円","5000円"]
    let bookDate = ["2017/05/01","2017/05/02","2017/05/03","2017/05/04","2017/05/05"]
    
    var selectedImage: UIImage?
    var selectedTitle: String?
    var selectedPrice: String?
    var selectedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //表示：リストのセルの個数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookImage.count
    }
    //表示：リストのセルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell{
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CustomTableViewCell
        //セルに値を設定
        cell.bookImage.image = UIImage(named: bookImage[indexPath.row])
        cell.bookTitleLabel.text = bookTitle[indexPath.row]
        cell.bookPriceLabel.text = bookPrice[indexPath.row]
        cell.bookPurchaseDateLabel.text = bookDate[indexPath.row]
        return cell
    }
    
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(bookUpdate[indexPath.row])
        
        selectedImage = UIImage(named:"\(bookImage[indexPath.row])")
        selectedTitle = bookTitle[indexPath.row]
        selectedPrice = bookPrice[indexPath.row]
        selectedDate = bookDate[indexPath.row]
        
        if selectedTitle != nil{
            performSegue(withIdentifier: "list", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any!){
        if (segue.identifier == "list"){
            
            let editVC: BookDataViewController = (segue.destination as? BookDataViewController)!
            
            editVC.selectedImage = selectedImage
            editVC.selectedTitle = selectedTitle
            editVC.selectedPrice = selectedPrice
            editVC.selectedDate = selectedDate
        }
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

