//
//  EditViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var addPic: UIButton!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookPrice: UITextField!
    @IBOutlet weak var bookPurchaseDate: UITextField!

    var selectedImage: UIImage!
    var selectedTitle: String!
    var selectedPrice: String!
    var selectedDate: String!
    
    var toolBar: UIToolbar!
    var myDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //戻るボタンの設定
        let leftButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(EditViewController.goBack))
        self.navigationItem.leftBarButtonItem = leftButton
        
        //既存の値の表示
        cameraView.image = selectedImage
        bookTitle.text = selectedTitle
        bookPrice.text = selectedPrice
        bookPurchaseDate.text = selectedDate
        
        //Pickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: #selector(AddViewController.onDidChangeDate(sender:)), for: .valueChanged)
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.datePickerMode = UIDatePickerMode.date
        bookPurchaseDate.inputView = myDatePicker
        
        //Picker>ToolBarの設定
        toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        //Picker>ToolBarButtonの設定
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        bookPurchaseDate.inputAccessoryView = toolBar
        }
    
    /* 戻るボタン押した時の処理 */
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /* 購入日入力の処理 */
    //完了ボタンタップ
    func doneClick(){
        bookPurchaseDate.resignFirstResponder()
    }
    //変更された値をtextFieldに入れる
    func onDidChangeDate(sender:UIDatePicker) {
        let dateFormatter       = DateFormatter()
        dateFormatter.locale    = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        bookPurchaseDate.text = dateFormatter.string(from: sender.date)
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
            cameraView.image = pickedImage
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
