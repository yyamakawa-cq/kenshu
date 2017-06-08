import UIKit
import APIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func didSignInButtonTap() {
        let email = emailAdressTextField.text!
        let password = passwordTextField.text!

        guard Validation.isEmptycheck(value: email) else {
            return showAlert(error: "emptyEmail")
        }
        guard Validation.isEmptycheck(value: password) else {
            return showAlert(error: "emptyPassword")
        }
        let loginRequest = LoginRequest(email: email, password:password)
        Session.send(loginRequest) { result in
            switch result {
            case .success(let response):
                print(response)
                let userDefault = UserDefaults.standard
                guard userDefault.integer(forKey: "user_id") == response.id else {
                    userDefault.set(response.id, forKey: "user_id")
                    userDefault.set(response.requestToken, forKey: "request_token")
                    return
                }
                let nextView = R.storyboard.main.tabBarController()!
                self.present(nextView, animated: true, completion: nil)
            case .failure(let error):
                print(error)
                self.showAlert(error: "loginError")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //初回起動だったらアカウント画面をモーダルで表示
    override func viewDidAppear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        guard userDefault.bool(forKey: "hasId") else {
            let firstView = R.storyboard.main.accountVC()!
            return present(firstView, animated: true, completion: nil)
        }
    }
}

extension LoginViewController {
    func showAlert(error: String) {
        let alert = UIAlertController (
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction (
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
