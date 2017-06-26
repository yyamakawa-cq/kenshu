import UIKit
import APIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var comfirmPasswordTextField: UITextField!
    @IBAction func didCloseButtonTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func editDone(_ sender: Any) {
        let email = emailAddressTextField.text!
        let password = passwordTextField.text!
        let comfirmPwd = comfirmPasswordTextField.text!
        let validateResult = Validate.account(email: email, password: password, comfirmPwd: comfirmPwd)
        let userDefault = UserDefaults.standard

        if validateResult == "ok" {

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
                        UIAlertController.showAlert(error: R.string.localizable.errorApi(), view: self)
                    }
                }

                return
            }
        self.dismiss(animated: true, completion: nil)
        } else {
                UIAlertController.showAlert(error:validateResult, view: self)
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
