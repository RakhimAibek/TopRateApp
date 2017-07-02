//
//  FirstViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class SongsViewController: UIViewController {
    
    @IBOutlet weak var songsTableView: UITableView!
    
    var arrSong = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songsTableView.delegate = self
        self.songsTableView.dataSource = self
        getSong()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSong" {
            if let toSongVC = segue.destination as? SongDetailedViewController {
                if let selectedIndexPath = songsTableView.indexPathForSelectedRow {
                    toSongVC.song = arrSong[selectedIndexPath.row]
                }
            }
        }
    }
    
    func getSong() {
        let url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=25/json"
        
        // request and compile dataTask with resume()
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                //try - если вышла ошибка, программа не будет идти дальше
                //allowFragments - позволяет игнорировать объекты кроме массива
                //getting JSON object
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                
                if let feed = json?["feed"] as? [String: AnyObject] {
                    if let entry = feed["entry"] as? [[String: AnyObject]] {
                        self.arrSong = []
                        for entry1 in entry {
                            var song = Song()
                            if let label = entry1["im:name"] as? [String: AnyObject] {
                                song.title = label["label"] as? String
                            }
                            if let imageI = entry1["im:image"] as? [[String: AnyObject]] {
                                song.images = imageI[2]["label"] as? String
                            }
                            if let price = entry1["im:price"] as? [String: AnyObject] {
                                song.price = price["label"] as? String
                            }
                            if let rights = entry1["rights"] as? [String: AnyObject] {
                                song.rights = rights["label"] as? String
                            }
                            self.arrSong.append(song)
                        }
                        
                        DispatchQueue.main.async {
                            self.songsTableView.reloadData()
                        }

                    }
                    
                }
            }
        }.resume()
    }
}
extension SongsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySongsCell", for: indexPath) as! SongsTableViewCell
        let songs = arrSong[indexPath.row]
        cell.songTitleLabel.text = songs.title
        cell.postSongLabel.text = songs.price
        cell.descSongLabel.text = songs.rights
        cell.songImageView.contentMode = .scaleAspectFit
        cell.songImageView.image = UIImage(named: songs.images!)
        
        if let imageURL = arrSong[indexPath.row].images {
            cell.songImageView.contentMode = .scaleAspectFit
            cell.songImageView.imageFromURL(urlString: imageURL)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromSong", sender: self)
    }
}

// to allow download Image from some Url
//We can add in info.plist Exception domains in Allow Arbitrary loads
extension UIImageView {
    
    public func imageFromURL(urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    if let image = UIImage(data: data!) {
                        //to immediately display image in tableViewCell
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }).resume()
        }
    }
}
