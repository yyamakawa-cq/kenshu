import UIKit

class BookListTableViewCell: UITableViewCell {
    //画像表示するImageView
    @IBOutlet weak var bookImageView: UIImageView!
    //タイトルを表示するLabel
    @IBOutlet weak var bookTitleLabel: UILabel!
    //価格を表示するLabel
    @IBOutlet weak var bookPriceLabel: UILabel!
    //更新日を表示するLabel
    @IBOutlet weak var bookPurchaseDateLabel: UILabel!

    func setCellBookData(imageUrl:String, title:String, price:Int, purchaseDate:String) {
        let imageUrl = URL(string:imageUrl)
        let purchaseDate = DateFormat.stringToDate(date:purchaseDate)
        bookImageView.kf.setImage(with:imageUrl)
        bookTitleLabel.text = title
        bookPriceLabel.text = R.string.localizable.currency(price)
        bookPurchaseDateLabel.text = DateFormat.dateToString(date: purchaseDate as Date)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
