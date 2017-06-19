import UIKit

class Alert {
    //アラート表示
    static func showAlert(error: String, view: UIViewController) {
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
        view.present(alert, animated: true, completion: nil)
    }
}
