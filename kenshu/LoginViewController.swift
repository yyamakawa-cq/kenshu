import UIKit

class LoginViewController: UIViewController {
    @IBAction func goBack(seque: UIStoryboardSegue) { }
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
            let storyboard: UIStoryboard = self.storyboard!
            let firstView = storyboard.instantiateViewController(withIdentifier: "Account")
            present(firstView, animated: true, completion: nil)
            userDefault.set(false, forKey: "firstLaunch")
        }
    }
}
