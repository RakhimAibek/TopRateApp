//
//  DetailedViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 7/1/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class SongDetailedViewController: UIViewController {
    
    var song: Song?
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songDescLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let song = song else { return }
        
        songTitleLabel.text = song.title
        songDescLabel.text = song.rights
        songImageView.imageFromURL(urlString: song.images!)
    }
    
    @IBAction func backBTNpressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
