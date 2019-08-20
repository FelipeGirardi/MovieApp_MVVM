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
    
    var viewModel: MainViewModel = MainViewModel()
    var idMovie: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.isHidden = true
        
//        DispatchQueue.global(qos: .background).async {
//            self.viewModel.fetchPopularMovies()
//
//            DispatchQueue.main.async {
//                self.mainTableView.delegate = self
//                self.mainTableView.dataSource = self
//                self.mainTableView.isHidden = false
//                self.mainTableView.reloadData()
//            }
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
        {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()
            self.view.addSubview(loadingIndicator)
            self.viewModel.fetchPopularMovies()
            self.mainTableView.delegate = self
            self.mainTableView.dataSource = self
            loadingIndicator.removeFromSuperview()
            self.mainTableView.isHidden = false
            self.mainTableView.reloadData()
            

        })
//
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func toNowPlayingVC(_ sender: Any) {
        performSegue(withIdentifier: "toNowPlayingSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetailSegue":
            if let detailCtrl = segue.destination as? DetailsViewController {
                detailCtrl.modelView = DetailsViewModel(id: self.idMovie)
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
//            print("Now playing")
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingCell") as? NowPlayingCell
            cell?.modelView = NowPlayingCellViewModel()
            cell?.nowPlayingCollection.delegate = cell
            cell?.nowPlayingCollection.dataSource = cell
            return cell!
        }
        else {
//            print("Popular movies")
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? TableCellViewController
            cell?.titleLabel.text = self.viewModel.getPopularTitleByIndex(indexPath.row)
            cell?.overviewLabel.text = self.viewModel.getPopularOverviewByIndex(indexPath.row)
            cell?.scoreLabel.text = self.viewModel.getPopularScoreByIndex(indexPath.row)
            
            guard let posterURL = URL(string: self.viewModel.getPopularPosterImageByIndex(indexPath.row)),
                  let posterImgData = try? Data(contentsOf: posterURL) else { return cell! }
            cell?.posterImgView.image = UIImage(data: posterImgData)
            cell?.posterImgView.layer.cornerRadius = 10.0
            
            
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
            self.idMovie = self.viewModel.getMovieIdByIndex(indexPath.row)
            performSegue(withIdentifier: "toDetailSegue", sender: nil)
        }
    }
    
}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
