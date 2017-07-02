//
//  AlbumsViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    var arrAlbum = [Album]()
    
    @IBOutlet weak var albumsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumsTableView.delegate = self
        self.albumsTableView.dataSource = self
        getAlbum()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAlbumVC" {
            if let toAlbumVC = segue.destination as? AlbumDetailedViewController {
                if let selectedIndexPath = albumsTableView.indexPathForSelectedRow {
                    toAlbumVC.album = arrAlbum[selectedIndexPath.row]
                }
            }
        }
    }
    
    func getAlbum() {
        let urlString = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topalbums/limit=25/json"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                
                if let feed = json?["feed"] as? [String: AnyObject] {
                    if let entry = feed["entry"] as? [[String: AnyObject]] {
                        self.arrAlbum = []
                        for entry3 in entry {
                            var album = Album()
                            if let name = entry3["im:name"] as? [String: AnyObject] {
                                album.title = name["label"] as? String
                            }
                            if let albumImage = entry3["im:image"] as? [[String: AnyObject]] {
                                album.images = albumImage[2]["label"] as? String
                            }
                            if let rights = entry3["rights"] as? [String: AnyObject] {
                                album.rights = rights["label"] as? String
                            }
                            if let price = entry3["im:price"] as? [String: AnyObject] {
                                album.price = price["label"] as? String
                            }
                            self.arrAlbum.append(album)
                        }       
                        DispatchQueue.main.async {
                            self.albumsTableView.reloadData()
                        }
                    }
                }
            }
        }.resume()
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromAlbumVC", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAlbumsCell", for: indexPath) as! AlbumsTableViewCell
        let album = arrAlbum[indexPath.row]
        cell.albumTitleLabel.text = album.title
        cell.descAlbumLabel.text = album.rights
        cell.postAlbumLabel.text = album.price
        
        if let imageAlbum = album.images {
            cell.albumImageView.contentMode = .scaleAspectFit
            cell.albumImageView.imageFromURL(urlString: imageAlbum)
        }
        return cell
    }
}
