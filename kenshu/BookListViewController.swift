import UIKit
import APIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let pageFrom = 0
    var pageTo:Int?
    var books: [Book] = []

    @IBAction func didAddButtonTap(_ sender: UIBarButtonItem) {
        let nextView = R.storyboard.main.bookDetailVCAdd()!
        nextView.screen = .add
        present(nextView, animated: true, completion: nil)
    }

    @IBAction func didLoadButtonTap(_ sender: Any) {
        pageTo = pageTo!+1
        let page = pageFrom.description + "-" + (pageTo?.description)!
        getBooks(page: page)
    }

    func getBooks(page: String) {
        let bookListRequest = BookListRequest(page: page)
        Session.send(bookListRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                self.books = response.book
                print(self.books)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageTo = 150
        let page = pageFrom.description + "-" + (pageTo?.description)!
        getBooks(page:page)
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
        cell?.setCell(
            imageUrl: books[indexPath.row].imageUrl,
            title: books[indexPath.row].title,
            price: books[indexPath.row].price,
            purchaseDate: books[indexPath.row].purchaseDate
        )
        return cell!
    }
}

extension BookListViewController: UITableViewDataSource {
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBook = books[indexPath.row]
        let nextView = R.storyboard.main.bookDetailVCEdit()!
        nextView.selectBook = selectBook
        nextView.screen = .edit
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
