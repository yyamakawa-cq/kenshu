//
//  BookDataViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class BookDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var addPicButton: UIButton!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!

    var selectedImage: UIImage!
    var selectedTitle: String!
    var selectedPrice: String!
    var selectedDate: String!
    
    var datePickerToolBar: UIToolbar!
    var bookPurchaseDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        /* 編集時の設定 */
        //戻るボタンの設定
        let leftButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BookDataViewController.goBack))
        self.navigationItem.leftBarButtonItem = leftButton
        
        //既存の値の表示
        if selectedTitle != nil{
            bookImage.image = selectedImage
            bookTitleTextField.text = selectedTitle
            bookPriceTextField.text = selectedPrice
            bookPurchaseDateTextField.text = selectedDate
        }else{
            bookImage.image = UIImage(named: "Sample.jpg")
        }
        
        
        /* 購入日のピッカー設定 */
        //購入日入力：Pickerの設定
        bookPurchaseDatePicker = UIDatePicker()
        bookPurchaseDatePicker.addTarget(self, action: #selector(BookDataViewController.onDidChangeDate(sender:)), for: .valueChanged)
        bookPurchaseDatePicker.backgroundColor = UIColor.white
        bookPurchaseDatePicker.datePickerMode = UIDatePickerMode.date
        bookPurchaseDateTextField.inputView = bookPurchaseDatePicker
        
        //Picker>ToolBarの設定
        datePickerToolBar = UIToolbar()
        datePickerToolBar.barStyle = .default
        datePickerToolBar.isTranslucent = true
        datePickerToolBar.sizeToFit()
        
        //Picker>ToolBarButtonの設定
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BookDataViewController.datePickerDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerToolBar.setItems([spaceButton, doneButton], animated: false)
        datePickerToolBar.isUserInteractionEnabled = true
        
        bookPurchaseDateTextField.inputAccessoryView = datePickerToolBar
        }
    
    /* 編集画面 */
    //戻るボタン押した時の処理
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /* 購入日入力の処理 */
    //完了ボタンタップ
    func datePickerDoneClick(){
        bookPurchaseDateTextField.resignFirstResponder()
    }
    //変更された値をtextFieldに入れる
    func onDidChangeDate(sender:UIDatePicker) {
        let dateFormatter       = DateFormatter()
        dateFormatter.locale    = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        bookPurchaseDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    
    /* 画像添付のボタン */
    //アルバムを表示
    @IBAction func showAlbum(_ sender: AnyObject){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            //インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
    }
    //選んだ画像を表示
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            bookImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
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
