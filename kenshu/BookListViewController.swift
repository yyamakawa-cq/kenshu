import UIKit
import APIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let bookParLoad = 160
    var offset = 0
    var books: [BookGet] = []

    @IBAction func didAddButtonTap(_ sender: UIBarButtonItem) {
        let nextView = R.storyboard.main.bookDetailVCAdd()!
        nextView.screen = .add
        present(nextView, animated: true, completion: nil)
    }

    @IBAction func didLoadButtonTap(_ sender: Any) {
        let currentOffset = offset+bookParLoad
        let page = currentOffset.description + "-" + (currentOffset+bookParLoad).description
        let bookListRequest = BookListRequest(page: page)
        Session.send(bookListRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                self.books += response.book
                guard response.book.isEmpty else {
                    self.offset+=self.bookParLoad
                    return
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let page = "0-160"
        let bookListRequest = BookListRequest(page: page)
        Session.send(bookListRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                self.books = response.book
                self.tableView.reloadData()
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
        cell?.setCellBookData(book: books[indexPath.row])
        return cell!
    }
}

extension BookListViewController: UITableViewDataSource {
    //セルが選択された時:値を詳細画面に送る
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = R.storyboard.main.bookDetailVCEdit()!
        nextView.selectBook = books[indexPath.row]
        nextView.screen = .edit
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
