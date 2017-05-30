import UIKit

class BookDataViewController: UIViewController {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var addPicButton: UIButton!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!

    var selectBook: BookParams = BookParams()

    /* 購入日入力 */
    @IBAction func bookPurchaseDateTap() {
        //Pickerの表示
        var bookPurchaseDatePicker: UIDatePicker!
        var datePickerToolBar: UIToolbar!
        bookPurchaseDatePicker = UIDatePicker()
        bookPurchaseDatePicker.addTarget(
            self,
            action: #selector(BookDataViewController.onDidChangeDate(sender:)),
            for: .valueChanged
        )
        bookPurchaseDateTextField.inputView = bookPurchaseDatePicker
        bookPurchaseDatePicker.datePickerMode = UIDatePickerMode.date
        datePickerToolBar = UIToolbar()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(BookDataViewController.datePickerDoneTap)
        )
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerToolBar.setItems([spaceButton, doneButton], animated: false)
        datePickerToolBar.sizeToFit()
        datePickerToolBar.isUserInteractionEnabled = true
        bookPurchaseDateTextField.inputAccessoryView = datePickerToolBar
    }

    //Pickerで選択した値をTextFieldに入れる
    func onDidChangeDate(sender:UIDatePicker) {
        let dateFormatter       = DateFormatter()
        dateFormatter.locale    = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        bookPurchaseDateTextField.text = dateFormatter.string(from: sender.date)
    }

    //完了ボタンタップ
    func datePickerDoneTap() {
        bookPurchaseDateTextField.resignFirstResponder()
    }

    /* 編集画面 */
    //戻るボタン押した時の処理
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /* 書籍編集画面 */
        //戻るボタン
        let leftButton = UIBarButtonItem(
            title: "戻る",
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(BookDataViewController.goBack)
        )
        self.navigationItem.leftBarButtonItem = leftButton
        //既存の値の表示
        if self.title == "Edit"{
            bookImage.image = UIImage(named:(selectBook.imageUrl))
            bookTitleTextField.text = selectBook.title
            bookPriceTextField.text = selectBook.price.description
            bookPurchaseDateTextField.text = selectBook.purchasedDate
        } else {
            bookImage.image = UIImage(named: "sample.jpg")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BookDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /* 画像添付 */
    //画像添付ボタンタップでアルバムを表示
    @IBAction func showAlbum(_ sender: AnyObject) {
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    //選んだ画像を表示する
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bookImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
