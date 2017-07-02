//
//  AlbumsTableViewCell.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    var album: Album?
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var postAlbumLabel: UILabel!
    @IBOutlet weak var descAlbumLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let album = album else { return }
        albumTitleLabel.text = album.title
        postAlbumLabel.text = album.price
        descAlbumLabel.text = album.rights
        albumImageView.imageFromURL(urlString: album.images!)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
