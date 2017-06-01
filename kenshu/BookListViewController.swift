import UIKit

class BookListViewController: UIViewController {

    let books = [
    Book(imageUrl: "NEKOIMG_1.jpg", title: "ネコ1", price: 1000, purchasedDate: "2017/01/01"),
    Book(imageUrl: "NEKOIMG_2.jpg", title: "ネコ2", price: 2000, purchasedDate: "2017/02/01"),
    Book(imageUrl: "NEKOIMG_3.jpg", title: "ネコ3", price: 3000, purchasedDate: "2017/03/01"),
    Book(imageUrl: "NEKOIMG_4.jpg", title: "ネコ4", price: 4000, purchasedDate: "2017/04/01"),
    Book(imageUrl: "NEKOIMG_5.jpg", title: "ネコ5", price: 5000, purchasedDate: "2017/05/01")
    ]

    @IBAction func didAddButtonTap(_ sender: UIBarButtonItem) {
        let storyboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "Add") as! BookDetailViewController
        nextView.screen = .add
        present(nextView, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BookListViewController: UITableViewDelegate {
    //表示：リストのセルの個数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    //表示：リストのセルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? BookListTableViewCell
        //セルに値を設定
        cell?.bookImageView.image = UIImage(named: books[indexPath.row].imageUrl)
        cell?.bookTitleLabel.text = books[indexPath.row].title
        cell?.bookPriceLabel.text = (books[indexPath.row].price.description)+"円"
        cell?.bookPurchaseDateLabel.text = books[indexPath.row].purchasedDate
        return cell!
    }
}

extension BookListViewController: UITableViewDataSource {
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectBook = Book(
            imageUrl: books[indexPath.row].imageUrl,
            title: books[indexPath.row].title,
            price: books[indexPath.row].price,
            purchasedDate: books[indexPath.row].purchasedDate)
        let storyboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "Edit") as! BookDetailViewController
        nextView.selectBook = selectBook
        nextView.screen = .edit
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
