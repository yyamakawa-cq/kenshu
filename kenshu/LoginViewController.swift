import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //初回起動だったらアカウント画面をモーダルで表示
    override func viewDidAppear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: "firstLaunch") {
            let firstView = R.storyboard.main.account()!
            present(firstView, animated: true, completion: nil)
            userDefault.set(false, forKey: "firstLaunch")
        }
    }
}
