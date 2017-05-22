//
//  CustomTableViewCell.swift
//  kenshu
//
//  Created by yukari on 2017/05/01.
//  Copyright © 2017年 yukari. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    //画像表示するImageView
    @IBOutlet weak var bookImage: UIImageView!

    //タイトルを表示するLabel
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    //価格を表示するLabel
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    //更新日を表示するLabel
    @IBOutlet weak var bookPurchaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
