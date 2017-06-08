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
        let strEmail = R.string.localizable.email()
        let strPassword = R.string.localizable.password()
        let strComfirmPwd = R.string.localizable.comfirmPwd()

        guard Validation.isEmptycheck(value: email) else {
            return showAlert(error: R.string.localizable.errorEmpty(strEmail))
        }
        guard Validation.isEmptycheck(value: password) else {
            return showAlert(error: R.string.localizable.errorEmpty(strPassword))
        }
        guard Validation.isEmptycheck(value: comfirmPwd) else {
            return showAlert(error: R.string.localizable.errorEmpty(strComfirmPwd))
        }
        guard Validation.isEqualCheck(pwFirst: password, pwSecond: comfirmPwd) else {
            return showAlert(error: R.string.localizable.errorPasswod())
        }
        guard Validation.isCountCheck(value: email, count: 8) else {
            return showAlert(error: R.string.localizable.errorCount(strEmail))
        }
        guard Validation.isCountCheck(value: password, count: 3) else {
            return showAlert(error: R.string.localizable.errorCount(strPassword))
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
                self.showAlert(error: R.string.localizable.errorApi())
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
            title: R.string.localizable.error(),
            message: error,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction (
            title: R.string.localizable.ok(),
            style: .default,
            handler: nil
        )
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
