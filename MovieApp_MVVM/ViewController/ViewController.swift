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
    
    private var viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toNowPlayingVC(_ sender: Any) {
        performSegue(withIdentifier: "toNowPlayingSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetailSegue":
            if let detailCtrl = segue.destination as? DetailsViewController {
                print("lola")
            }
        case "toNowPlayingSegue":
            print("foi")
        default:
            break
            
        }
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            print("Now playing")
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingCell") as? NowPlayingCell
            cell?.nowPlayingCollection.delegate = cell
            cell?.nowPlayingCollection.dataSource = cell
            return cell!
        }
        else {
            print("Popular movies")
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? TableCellViewController
            cell?.titleLabel.text = "Rei leão"
            cell?.overviewLabel.text = "aidsaiosdjasiodasioj aoisdj aios jaso ijdasoi jdasoij dasioj doiajd oaij doiaj diosjdiojdaijdijaosd"
            cell?.scoreLabel.text = "9.0"
            cell?.posterImgView.image = UIImage(named: "lionking")
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Popular Movies" : nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 371.0
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = header?.textLabel?.font.withSize(21)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            performSegue(withIdentifier: "toDetailSegue", sender: nil)
        }
    }
    
}


