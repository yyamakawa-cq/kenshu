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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
