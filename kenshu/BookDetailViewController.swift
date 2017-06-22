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
        let bookTitle = bookTitleTextField.text!
        let bookPrice = bookPriceTextField.text!
        let bookPurchaseDate = bookPurchaseDateTextField.text!
        let bookImage = bookImageView.image

        guard Validation.isNotEmpty(value: bookTitle) else {
            return UIAlertController.showAlert(
                error: R.string.localizable.errorEmpty(R.string.localizable.bookTitle()),
                view: self
            )
        }
        guard Validation.isNotEmpty(value: bookPrice) else {
            return UIAlertController.showAlert(
                error: R.string.localizable.errorEmpty(R.string.localizable.bookPrice()),
                view: self
            )
        }
        guard Validation.isNotEmpty(value: bookPurchaseDate) else {
            return UIAlertController.showAlert(
                error: R.string.localizable.errorEmpty(R.string.localizable.bookPurchaseDate()),
                view:self
            )
        }
        guard bookImage != R.image.sample() else {
            return UIAlertController.showAlert(
                error: R.string.localizable.errorEmpty(R.string.localizable.bookImage()),
                view: self
            )
        }
        saveBook(name:bookTitle, price:bookPrice, puruchaseDate: bookPurchaseDate, image:bookImage!)
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
    func saveBook(name:String, price:String, puruchaseDate:String, image:UIImage) {
        let purchaseDate = (puruchaseDate.replacingOccurrences(of: "/", with: "-"))
        let imageSize = CGSize(width:160, height:100)
        let imageResize = bookImageView.image?.resizeImage(size: imageSize)
        let imageData = UIImagePNGRepresentation(imageResize!)! as NSData
        let imageString = imageData.base64EncodedString()

        switch screen! {
        case .edit:
            let bookEditRequest = BookEditRequest(
                id:selectBook.id,
                name: name,
                price: Int(price)!,
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
                name: name,
                price: Int(price)!,
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
                let imageData = {() -> UIImage in
                    return ImageDownloader.loadImage(imageUrl: self.selectBook.imageUrl)!
                }
                bookImageView.image = imageData()
                bookTitleTextField.text = selectBook.title
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

//画像リサイズ処理
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
