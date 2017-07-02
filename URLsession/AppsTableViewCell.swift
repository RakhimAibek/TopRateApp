//
//  AppsTableViewCell.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AppsTableViewCell: UITableViewCell {

    var app: App?
    
    @IBOutlet weak var appsTitleLabel: UILabel!
    @IBOutlet weak var appPostLabel: UILabel!
    @IBOutlet weak var descAppLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let app = app else { return }
        appsTitleLabel.text = app.title
        appPostLabel.text = app.price
        descAppLabel.text = app.rights
        appImageView.imageFromURL(urlString: app.images!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
