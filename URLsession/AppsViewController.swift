//
//  SecondViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 6/30/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var appsTableView: UITableView!
    
    var arrApp = [App]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appsTableView.delegate = self
        appsTableView.dataSource = self
        getApp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromApps" {
            if let toAppVC = segue.destination as? AppDetailedViewController {
                if let seletedIndexPath = appsTableView.indexPathForSelectedRow {
                    toAppVC.app = arrApp[seletedIndexPath.row]
                }
            }
        }
    }
    
    func getApp() {
        let urlString = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=25/json"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                
                if let feed = json?["feed"] as? [String: AnyObject] {
                    if let entry = feed["entry"] as? [[String: AnyObject]] {
                        self.arrApp = []
                        for entry2 in entry {
                            var app = App()
                            if let name = entry2["im:name"] as? [String: AnyObject] {
                                app.title = name["label"] as? String
                            }
                            if let appImage = entry2["im:image"] as? [[String: AnyObject]] {
                                app.images = appImage[2]["label"] as? String
                            }
                            if let appPrice = entry2["im:price"] as? [String: AnyObject] {
                                app.price = appPrice["label"] as? String
                            }
                            if let rights = entry2["rights"] as? [String: AnyObject] {
                                app.rights = rights["label"] as? String
                            }
                            self.arrApp.append(app)
                        }
                        
                        DispatchQueue.main.async {
                            self.appsTableView.reloadData()
                        }
                        
                    }
                    
                }
            }
        }.resume()
    }
}

extension AppsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrApp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAppsCell", for: indexPath) as! AppsTableViewCell
        let apps = arrApp[indexPath.row]
        
        cell.appsTitleLabel.text = apps.title
        cell.descAppLabel.text = apps.rights
        cell.appPostLabel.text = apps.price
        
        if let imageURL = apps.images {
            cell.appImageView.contentMode = .scaleAspectFit
            cell.appImageView.imageFromURL(urlString: imageURL)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromApps", sender: self)
    }
}

