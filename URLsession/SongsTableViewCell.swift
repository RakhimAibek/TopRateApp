//
//  SongsTableViewCell.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class SongsTableViewCell: UITableViewCell {
    
    var song: Song?
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var postSongLabel: UILabel!
    @IBOutlet weak var descSongLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        guard let song = song else { return }
        
        songTitleLabel.text = song.title
        postSongLabel.text = song.price
//        descSongLabel.text = song.rights
        songImageView.contentMode = .scaleAspectFit
        songImageView.imageFromURL(urlString: song.images!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
