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
        let email = (emailAdressTextField.text)!
        let pwFirst = (passwordTextField.text)!
        let pwSecond = (comfirmPasswordTextField.text)!
        guard isEmptycheck(email: email,pwFirst: pwFirst,pwSecond: pwSecond) else {
            return showAlert()
        }
        guard isEqualCheck(pwFirst: pwFirst, pwSecond: pwSecond) else {
            return showAlert()
        }
        guard isCountCheck(email: email, pwFirst: pwFirst) else {
            return showAlert()
        }

        let userDefaults = UserDefaults()
        if userDefaults.object(forKey: "user_id") == nil {

            let signUpRequest = SignUpRequest(email: email, password:pwFirst)
            Session.send(signUpRequest) { result in
                switch result {
                case .success(let response):
                print(response)
                userDefaults.register(defaults: ["user_id" : response.id])
                userDefaults.register(defaults: ["request_token" : response.requestToken])
            case .failure(let error):
                print(error)
                self.showAlert()
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

    func isEmptycheck(email: String, pwFirst: String, pwSecond:String) -> Bool {
        return email != "" || pwFirst != "" || pwSecond != ""
    }

    func isEqualCheck(pwFirst: String, pwSecond: String) -> Bool {
        return pwFirst == pwSecond
    }

    func isCountCheck(email: String, pwFirst: String) -> Bool {
        let email = email.characters.count
        let pwFirst = pwFirst.characters.count
        return email >= 8 && pwFirst >= 6
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AccountViewController {
    func showAlert() {
        let alert = UIAlertController (
            title: "Error",
            message: nil,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction (
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
