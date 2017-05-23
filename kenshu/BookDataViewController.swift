import UIKit

class BookDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var addPicButton: UIButton!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!

    var selectBookData:[String : String] = [:]
    
    var datePickerToolBar: UIToolbar!
    var bookPurchaseDatePicker: UIDatePicker!
    
    /* 編集画面 */
    //戻るボタン押した時の処理
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }

    /* 購入日入力の処理 */
    @IBAction func bookPurchaseDateTouchDown() {
        //購入日入力：Pickerの設定
        bookPurchaseDatePicker = UIDatePicker()
        bookPurchaseDatePicker.addTarget(self, action: #selector(BookDataViewController.onDidChangeDate(sender:)), for: .valueChanged)
        bookPurchaseDateTextField.inputView = bookPurchaseDatePicker
        bookPurchaseDatePicker.datePickerMode = UIDatePickerMode.date
        
        datePickerToolBar = UIToolbar()
        datePickerToolBar.barStyle = .default
        datePickerToolBar.isTranslucent = true
        datePickerToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BookDataViewController.datePickerDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerToolBar.setItems([spaceButton, doneButton], animated: false)
        datePickerToolBar.isUserInteractionEnabled = true
        bookPurchaseDateTextField.inputAccessoryView = datePickerToolBar
    }
    //変更された値をtextFieldに入れる
    func onDidChangeDate(sender:UIDatePicker) {
        let dateFormatter       = DateFormatter()
        dateFormatter.locale    = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        bookPurchaseDateTextField.text = dateFormatter.string(from: sender.date)
    }
    //完了ボタンタップ
    func datePickerDoneClick(){
        bookPurchaseDateTextField.resignFirstResponder()
    }
    /* 画像添付のボタン */
    //アルバムを表示
    @IBAction func showAlbum(_ sender: AnyObject){
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
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
    override func viewDidLoad() {
        super.viewDidLoad()
        /* 書籍編集画面 */
        //戻るボタン
        let leftButton = UIBarButtonItem(title: "戻る", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BookDataViewController.goBack))
        self.navigationItem.leftBarButtonItem = leftButton
        //既存の値の表示
        bookImage.image = UIImage(named:"\(selectBookData["bookImage"] ?? "Sample.jpg")")
        bookTitleTextField.text = selectBookData["bookTitle"]
        bookPriceTextField.text = selectBookData["bookPrice"]
        bookPurchaseDateTextField.text = selectBookData["bookPurchaseDate"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
