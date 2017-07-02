//
//  AppDetailedViewController.swift
//  URLsession
//
//  Created by Aibek Rakhim on 7/2/17.
//  Copyright © 2017 ibek inc. All rights reserved.
//

import UIKit

class AppDetailedViewController: UIViewController {
    
    var app: App?
    
    @IBOutlet weak var appImageDetailedView: UIImageView!
    @IBOutlet weak var appDescLabel: UILabel!
    @IBOutlet weak var appTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let app = app else { return }
        
        appImageDetailedView.imageFromURL(urlString: app.images!)
        appDescLabel.text = app.rights
        appTextLabel.text = app.title
        
    }
    @IBAction func backBTNpressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
