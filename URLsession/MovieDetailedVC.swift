//
//  MovieDetailedVC.swift
//  URLsession
//
//  Created by Aibek Rakhim on 7/2/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class MovieDetailedVC: UIViewController {

    var movie: Movie?
    @IBOutlet weak var detailedMovieImageView: UIImageView!
    @IBOutlet weak var detailedMovieTextLabel: UILabel!
    @IBOutlet weak var detailedDescMovieLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else { return }
        
        detailedMovieTextLabel.text = movie.title
        detailedDescMovieLabel.text = movie.rights
        detailedMovieImageView.contentMode = .scaleAspectFit
        detailedMovieImageView.imageFromURL(urlString: movie.images!)
    }
    
    @IBAction func backBTNpressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
