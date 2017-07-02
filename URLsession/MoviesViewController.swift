//
//  MoviesViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var movieArr = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        getMovie()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMovieVC" {
            if let toMovieVC = segue.destination as? MovieDetailedVC {
                if let selectedIndexPath = moviesTableView.indexPathForSelectedRow {
                    toMovieVC.movie = movieArr[selectedIndexPath.row]
                }
            }
        }
    }
    
    func getMovie() {
        let urlString = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/limit=25/json"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                
                if let feed = json?["feed"] as? [String: AnyObject] {
                    if let entry = feed["entry"] as? [[String: AnyObject]] {
                        self.movieArr = []
                        
                        for entry1 in entry {
                            var movie = Movie()
                            
                            if let name = entry1["im:name"] as? [String: AnyObject] {
                                movie.title = name["label"] as? String
                            }
                            if let price = entry1["im:price"] as? [String: AnyObject] {
                                movie.price = price["label"] as? String
                            }
                            if let rights = entry1["rights"] as? [String: AnyObject] {
                                movie.rights = rights["label"] as? String
                            }
                            if let imageMovie = entry1["im:image"] as? [[String: AnyObject]] {
                                movie.images = imageMovie[2]["label"] as? String
                            }
                            self.movieArr.append(movie)
                        }
                        DispatchQueue.main.async {
                            self.moviesTableView.reloadData()
                        }
                    }
                }
            }
        }.resume()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromMovieVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMoviesCell", for: indexPath) as? MoviesTableViewCell
        let movies = movieArr[indexPath.row]
        
        cell?.movieTitleLabel.text = movies.title
        cell?.descMovieLabel.text = movies.price
        cell?.postMovieLabel.text = movies.rights
        
        if let imageAlbum = movies.images {
            cell?.movieImageView.contentMode = .scaleAspectFit
            cell?.movieImageView.imageFromURL(urlString: imageAlbum)
        }
        
        return cell!
    }
}
