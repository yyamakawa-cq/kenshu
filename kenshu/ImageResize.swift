import UIKit
//画像リサイズ処理
extension UIImage {
    func resizeImage(size: CGSize) -> UIImage? {
        let widthRatio = size.width / size.width
        let heightRatio = size.height / size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
        let resizeSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(resizeSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizeSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
