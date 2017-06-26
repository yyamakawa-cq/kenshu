import UIKit
import APIKit
import Kingfisher

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!

    var selectBook: BookGet!
    var screen: ViewType!
    var bookPurchaseDatePicker = UIDatePicker()
    var datePickerToolBar = UIToolbar()

    enum ViewType {
        case add, edit
    }

    //閉じるボタンタップ
    @IBAction func didCloseButtonTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    //保存ボタンタップ
    @IBAction func didSaveButtonTap() {
        let book = BookPost(
            image: bookImageView.image!,
            name: bookTitleTextField.text!,
            price: bookPriceTextField.text!,
            purchaseDate: bookPurchaseDateTextField.text!
        )
        let validateResult = Validate.book(book: book)
        guard validateResult.0 else {
            return UIAlertController.showAlert(error:validateResult.1, view: self)
        }
        saveBook(book: book)
    }

    //画像添付ボタンタップ
    @IBAction func didPicAttachButtonTap(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .photoLibrary
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }

    //購入日タップ
    @IBAction func didBookPurchaseDateTapped() {
        //Pickerの表示
        bookPurchaseDatePicker.addTarget(
            self,
            action: #selector(BookDetailViewController.didDateChanged(sender:)),
            for: .valueChanged
        )
        bookPurchaseDateTextField.inputView = bookPurchaseDatePicker
        bookPurchaseDatePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(
            title: R.string.localizable.done(),
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

    //ApiRequest
    func saveBook(book:BookPost) {
        let purchaseDate = book.purchaseDate.replacingOccurrences(of: "/", with: "-")
        let imageSize = CGSize(width:160, height:100)
        let imageResize = bookImageView.image?.resizeImage(size: imageSize)
        let imageData = UIImagePNGRepresentation(imageResize!)! as NSData
        let imageString = imageData.base64EncodedString()

        switch screen! {
        case .edit:
            let bookEditRequest = BookEditRequest(
                id:selectBook.id,
                name: book.name,
                price: Int(book.price)!,
                purchaseDate:purchaseDate,
                imageData: imageString
            )
            Session.send(bookEditRequest) { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                    UIAlertController.showAlert(error: R.string.localizable.errorApi(),view: self)
                }
            }
        case .add:
            let bookAddRequest = BookAddRequest(
                name: book.name,
                price: Int(book.price)!,
                purchaseDate:purchaseDate,
                imageData: imageString
            )
            Session.send(bookAddRequest) { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                    UIAlertController.showAlert(error: R.string.localizable.errorApi(),view: self)
                }
            }
        }
    }

    //Pickerで選択した値をTextFieldに入れる
    func didDateChanged(sender: UIDatePicker) {
        bookPurchaseDateTextField.text = DateFormat.dateToString(date: sender.date)
    }

    //Picker完了ボタンタップ
    func didDatePickerDoneTap() {
        bookPurchaseDateTextField.resignFirstResponder()
    }

    //戻るボタンタップ
    func didBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switch screen! {
            case .edit:
                //戻るボタンの設定
                let leftButton = UIBarButtonItem(
                    title: R.string.localizable.back(),
                    style: .plain,
                    target: self,
                    action: #selector(BookDetailViewController.didBackButtonTapped)
                )
                self.navigationItem.leftBarButtonItem = leftButton
                //既存の値の表示
                let purchaseDate = DateFormat.stringToDate(date: selectBook.purchaseDate)
                let imageData = URL(string:selectBook.imageUrl)
                bookImageView.kf.setImage(with:imageData)
                bookTitleTextField.text = selectBook.name
                bookPriceTextField.text = selectBook.price.description
                bookPurchaseDateTextField.text = DateFormat.dateToString(date: purchaseDate as Date)
            case .add:
                bookImageView?.image = R.image.sample()
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //選んだ画像を表示する
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bookImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
