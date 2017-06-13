import UIKit
import APIKit

class BookListViewController: UIViewController {

    let books = [
    Book(bookId: 1, imageUrl: "NEKOIMG_1.jpg", title: "ネコ1", price: 1000, purchaseDate: "2017/01/01"),
    Book(bookId: 2,imageUrl: "NEKOIMG_2.jpg", title: "ネコ2", price: 2000, purchaseDate: "2017/02/01"),
    Book(bookId: 3,imageUrl: "NEKOIMG_3.jpg", title: "ネコ3", price: 3000, purchaseDate: "2017/03/01"),
    Book(bookId: 4,imageUrl: "NEKOIMG_4.jpg", title: "ネコ4", price: 4000, purchaseDate: "2017/04/01"),
    Book(bookId: 5,imageUrl: "NEKOIMG_5.jpg", title: "ネコ5", price: 5000, purchaseDate: "2017/05/01")
    ]

    @IBAction func didAddButtonTap(_ sender: UIBarButtonItem) {
        let nextView = R.storyboard.main.bookDetailVCAdd()!
        nextView.screen = .add
        present(nextView, animated: true, completion: nil)
    }

    @IBAction func didLoadButtonTap(_ sender: Any) {
        getBooks()
    }

    func getBooks() {
        let bookListRequest = BookListRequest(page: "0-100")
        Session.send(bookListRequest) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myCell)
        //セルに値を設定
        cell?.bookImageView.image = UIImage(named: books[indexPath.row].imageUrl)
        cell?.bookTitleLabel.text = books[indexPath.row].title
        cell?.bookPriceLabel.text = R.string.localizable.currency(books[indexPath.row].price)
        cell?.bookPurchaseDateLabel.text = books[indexPath.row].purchaseDate
        return cell!
    }
}

extension BookListViewController: UITableViewDataSource {
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectBook = Book(
            bookId: 1,
            imageUrl: books[indexPath.row].imageUrl,
            title: books[indexPath.row].title,
            price: books[indexPath.row].price,
            purchaseDate: books[indexPath.row].purchaseDate)
        let nextView = R.storyboard.main.bookDetailVCEdit()!
        nextView.selectBook = selectBook
        nextView.screen = .edit
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
