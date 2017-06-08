import UIKit
import APIKit

class AccountViewController: UIViewController {

    let alert = UIAlertController ()
    let alertAction = UIAlertAction()

    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var comfirmPasswordTextField: UITextField!

    @IBAction func didCloseButtonTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func editDone(_ sender: Any) {
        let email = emailAdressTextField.text!
        let password = passwordTextField.text!
        let comfirmPwd = comfirmPasswordTextField.text!

        guard Validation.isEmptycheck(value: email) else {
            return showAlert(error: "emptyEmail")
        }
        guard Validation.isEmptycheck(value: password) else {
            return showAlert(error: "emptyPassword")
        }
        guard Validation.isEmptycheck(value: comfirmPwd) else {
            return showAlert(error: "emptyCompwd")
        }
        guard Validation.isEqualCheck(pwFirst: password, pwSecond: comfirmPwd) else {
            return showAlert(error: "passNotEqual")
        }
        guard Validation.isCountCheck(value: email, count: 8) else {
            return showAlert(error: "countEmail")
        }
        guard Validation.isCountCheck(value: password, count: 3) else {
            return showAlert(error: "countPassword")
        }

        let userDefault = UserDefaults.standard
        guard userDefault.bool(forKey: "hasId") else {

            let signUpRequest = SignUpRequest(email: email, password:password)
            Session.send(signUpRequest) { result in
                switch result {
                case .success(let response):
                print(response)
                userDefault.register(defaults: ["user_id" : response.id])
                userDefault.register(defaults: ["request_token" : response.requestToken])
                userDefault.set(true, forKey: "hasId")
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
                self.showAlert(error:"ApiError")
                }
            }
        return
        }
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AccountViewController {
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
