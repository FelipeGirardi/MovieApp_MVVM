//
//  ViewController.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 14/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            print("Now playing")
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingCell") as? NowPlayingCell
            return cell!
        }
        else {
            print("Popular movies")
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell") as? PopularCell
            cell?.popularTableView.delegate = cell
            cell?.popularTableView.dataSource = cell
            
            return cell!
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

