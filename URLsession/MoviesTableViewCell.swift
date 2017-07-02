//
//  MoviesTableViewCell.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    var movie: Movie?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var postMovieLabel: UILabel!
    @IBOutlet weak var descMovieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let movie = movie else { return }
        
        movieTitleLabel.text = movie.title
        postMovieLabel.text = movie.price
        descMovieLabel.text = movie.rights
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.imageFromURL(urlString: movie.images!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
