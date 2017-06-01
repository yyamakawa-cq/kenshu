import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!

    var selectBook: Book!
    var screen:ViewType!
    var bookPurchaseDatePicker: UIDatePicker! = UIDatePicker()
    var datePickerToolBar: UIToolbar! = UIToolbar()

    enum ViewType {
        case add, edit
    }

    /* 購入日入力 */
    @IBAction func didBookPurchaseDateTapped() {
        //Pickerの表示
        bookPurchaseDatePicker.addTarget(
            self,
            action: #selector(BookDetailViewController.didDateChanged(sender:)),
            for: .valueChanged
        )
        bookPurchaseDateTextField.inputView = bookPurchaseDatePicker
        bookPurchaseDatePicker.datePickerMode = UIDatePickerMode.date
        let doneButton = UIBarButtonItem(
            title: NSLocalizedString("Done", comment:""),
            style: .plain,
            target: self,
            action: #selector(BookDetailViewController.didDatePickerDoneTap)
        )
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerToolBar.setItems([spaceButton, doneButton], animated: false)
        datePickerToolBar.sizeToFit()
        datePickerToolBar.isUserInteractionEnabled = true
        bookPurchaseDateTextField.inputAccessoryView = datePickerToolBar
    }

    //Pickerで選択した値をTextFieldに入れる
    func didDateChanged(sender: UIDatePicker) {
        bookPurchaseDateTextField.text = DateFormat.dateToString(date: sender.date)
    }

    //完了ボタンタップ
    func didDatePickerDoneTap() {
        bookPurchaseDateTextField.resignFirstResponder()
    }

    //戻るボタンタップ
    func didBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    //閉じるボタンタップ
    @IBAction func didCloseButtonTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    /* 画像添付 */
    //画像添付ボタンタップでアルバムを表示
    @IBAction func didPicAttachButtonTap(_ sender: AnyObject) {
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch screen! {
            case .edit:
                //戻るボタンの設定
                let leftButton = UIBarButtonItem(
                    title: NSLocalizedString("Back", comment:""),
                    style: .plain,
                    target: self,
                    action: #selector(BookDetailViewController.didBackButtonTapped)
                )
                self.navigationItem.leftBarButtonItem = leftButton
                //既存の値の表示
                bookImageView?.image = UIImage(named:selectBook.imageUrl)
                bookTitleTextField.text = selectBook.title
                bookPriceTextField?.text = selectBook.price.description
                bookPurchaseDateTextField?.text = selectBook.purchasedDate
            case .add:
                bookImageView?.image = UIImage(named:"Sample")
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /* 画像添付 */
    //選んだ画像を表示する
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bookImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
