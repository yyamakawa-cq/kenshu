//
//  AddViewController.swift
//  kenshu
//
//  Created by yukari on 2017/04/28.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var addPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //デフォルト画像の表示
        initImageView()
    }
    
    //デフォルト画像の呼び出し処理
    private func initImageView(){
        let defaultImage = UIImage(named: "Sample.jpg")
        cameraView.image = defaultImage
    }
    
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
