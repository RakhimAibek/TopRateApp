//
//  AppDetailedViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 7/2/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AlbumDetailedViewController: UIViewController {
    
    var album: Album?
    
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var detailedTitleAlbumLabel: UILabel!
    @IBOutlet weak var descAlbumTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let album = album else { return }
        
        detailedImageView.imageFromURL(urlString: album.images!)
        detailedTitleAlbumLabel.text = album.title
        descAlbumTextLabel.text = album.rights
    }
    @IBAction func backBTNpressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
