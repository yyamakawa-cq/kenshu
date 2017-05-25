import UIKit

class BookListViewController: UIViewController {
    @IBAction func goBack(seque: UIStoryboardSegue) {}
    let bookImage = ["NEKOIMG_1.jpg","NEKOIMG_2.jpg","NEKOIMG_3.jpg","NEKOIMG_4.jpg","NEKOIMG_5.jpg"]
    let bookTitle = ["ネコ1","ネコ2","ネコ3","ネコ4","ネコ5"]
    let bookPrice = ["1000","2000","3000","4000","5000"]
    let bookPurchaseDate = ["2017/05/01","2017/05/02","2017/05/03","2017/05/04","2017/05/05"]
    var selectBookData: [String:String] = [:]

    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        if (segue.identifier == "list") {
            let editViewController = segue.destination as! BookDataViewController
            editViewController.selectBookData = sender as! [String : String]
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
        return bookImage.count
    }

    //表示：リストのセルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        //セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CustomTableViewCell
        //セルに値を設定
        cell.bookImage.image = UIImage(named: bookImage[indexPath.row])
        cell.bookTitleLabel.text = bookTitle[indexPath.row]
        cell.bookPriceLabel.text = bookPrice[indexPath.row]+"円"
        cell.bookPurchaseDateLabel.text = bookPurchaseDate[indexPath.row]
        return cell
    }
}

extension BookListViewController: UITableViewDataSource {
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBookData = [
            "bookImage":bookImage[indexPath.row],
            "bookTitle":bookTitle[indexPath.row],
            "bookPrice":bookPrice[indexPath.row],
            "bookPurchaseDate":bookPurchaseDate[indexPath.row]
        ]
        performSegue(withIdentifier: "list", sender:selectBookData)
    }
}
