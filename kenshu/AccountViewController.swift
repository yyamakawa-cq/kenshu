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
            return Alert.showAlert(error: R.string.localizable.errorEmpty(strEmail), view: self)
        }
        guard Validation.isEmptycheck(value: password) else {
            return Alert.showAlert(error: R.string.localizable.errorEmpty(strPassword), view: self)
        }
        guard Validation.isEmptycheck(value: comfirmPwd) else {
            return Alert.showAlert(error: R.string.localizable.errorEmpty(strComfirmPwd), view: self)
        }
        guard Validation.isEqualCheck(pwFirst: password, pwSecond: comfirmPwd) else {
            return Alert.showAlert(error: R.string.localizable.errorPasswod(), view: self)
        }
        guard Validation.isCountCheck(value: email, count: 8) else {
            return Alert.showAlert(error: R.string.localizable.errorCount(strEmail), view: self)
        }
        guard Validation.isCountCheck(value: password, count: 3) else {
            return Alert.showAlert(error: R.string.localizable.errorCount(strPassword), view: self)
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
                Alert.showAlert(error: R.string.localizable.errorApi(), view: self)
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
