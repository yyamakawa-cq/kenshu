import UIKit

class BookListViewController: UIViewController {
    @IBAction func goBack(seque: UIStoryboardSegue) {}

    let books = [
    Book(imageUrl: "NEKOIMG_1.jpg", title: "ネコ1", price: 1000, purchasedDate: "2017/01/01"),
    Book(imageUrl: "NEKOIMG_2.jpg", title: "ネコ2", price: 2000, purchasedDate: "2017/02/01"),
    Book(imageUrl: "NEKOIMG_3.jpg", title: "ネコ3", price: 3000, purchasedDate: "2017/03/01"),
    Book(imageUrl: "NEKOIMG_4.jpg", title: "ネコ4", price: 4000, purchasedDate: "2017/04/01"),
    Book(imageUrl: "NEKOIMG_5.jpg", title: "ネコ5", price: 5000, purchasedDate: "2017/05/01")
    ]

    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        if (segue.identifier == "list") {
            let editViewController = segue.destination as? BookDataViewController
            editViewController?.selectBook = (sender as? Book)!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(books[0].title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BookListViewController: UITableViewDelegate {
    //表示：リストのセルの個数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    //表示：リストのセルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CustomTableViewCell
        //セルに値を設定
        cell?.bookImage.image = UIImage(named: books[indexPath.row].imageUrl)
        cell?.bookTitleLabel.text = books[indexPath.row].title
        cell?.bookPriceLabel.text = books[indexPath.row].price.description
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
        performSegue(withIdentifier: "list", sender:selectBook)
    }
}
