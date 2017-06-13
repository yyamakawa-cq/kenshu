import UIKit
import APIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPurchaseDateTextField: UITextField!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!

    var selectBook: Book!
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
        let bookTitle = bookTitleTextField.text
        let bookPrice = bookPriceTextField.text
        let bookPurchaseDate = bookPurchaseDateTextField.text?.replacingOccurrences(of: "/", with: "-")
        let bookImage = bookImageView.image
        let bookImageSize = CGSize(width:160, height:100)
        let bookImageResize = bookImageView.image?.resizeImage(size: bookImageSize)
        let bookImageData = UIImagePNGRepresentation(bookImageResize!)! as NSData
        let bookImageString = bookImageData.base64EncodedString()

        guard Validation.isEmptycheck(value: bookTitle!) else {
            return showAlert(error: R.string.localizable.errorEmpty(R.string.localizable.bookImage()))
        }
        guard Validation.isEmptycheck(value: bookPrice!) else {
            return showAlert(error: R.string.localizable.errorEmpty(R.string.localizable.bookPrice()))
        }
        guard Validation.isEmptycheck(value: bookPurchaseDate!) else {
            return showAlert(error: R.string.localizable.errorEmpty(R.string.localizable.bookPurchaseDate()))
        }
        guard bookImage != R.image.sample() else {
            return showAlert(error: R.string.localizable.errorEmpty(R.string.localizable.bookImage()))
        }
        let bookAddRequest = BookAddRequest(name: bookTitle!, price: Int(bookPrice!)!, purchaseDate:bookPurchaseDate!,imageData: bookImageString)
        Session.send(bookAddRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
                self.showAlert(error: R.string.localizable.errorApi())
            }
        }
    }

    //画像添付ボタンタップ
    @IBAction func didPicAttachButtonTap(_ sender: AnyObject) {
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
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

    //アラート表示
    func showAlert(error: String) {
        let alert = UIAlertController (
            title: R.string.localizable.error(),
            message: error,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction (
            title: R.string.localizable.ok(),
            style: .default,
            handler: nil
        )
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
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
                bookImageView.image = UIImage(named:selectBook.imageUrl)
                bookTitleTextField.text = selectBook.title
                bookPriceTextField?.text = selectBook.price.description
                bookPurchaseDateTextField?.text = selectBook.purchaseDate
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

extension UIImage {
    func resizeImage(size: CGSize) -> UIImage? {
        let widthRatio = size.width / size.width
        let heightRatio = size.height / size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
        let resizeSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(resizeSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizeSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
