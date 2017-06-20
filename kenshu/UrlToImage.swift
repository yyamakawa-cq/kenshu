import UIKit

class UrlToImage {
     func loadImage(imageUrl:String) -> UIImage? {
        let imageUrl = URL(string:imageUrl)
        guard let url = imageUrl else {
            return nil
        }
        var imageData: Data?
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            print ("fail to download")
        }
       return UIImage(data: imageData!)
    }

}
