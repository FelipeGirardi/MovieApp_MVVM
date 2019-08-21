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
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 212-30, y: 483, width: 35, height: 35))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
        
        self.viewModel.fetchPopularMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
        {
            self.mainTableView.delegate = self
            self.mainTableView.dataSource = self
            loadingIndicator.removeFromSuperview()
            self.mainTableView.isHidden = false
            self.mainTableView.reloadData()
        })
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func toNowPlayingVC(_ sender: Any) {
        performSegue(withIdentifier: "toNowPlayingSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetailSegue":
            if let detailCtrl = segue.destination as? DetailsViewController {
                if detailCtrl.modelView == nil {
                    detailCtrl.modelView = DetailsViewModel(id: self.idMovie)
                }
            }
        case "toNowPlayingSegue":
            if let nowPlayingCtrl = segue.destination as? NowPlayingViewController {
                if nowPlayingCtrl.modelView == nil {
                    nowPlayingCtrl.modelView = NowPlayingViewModel()
                }
            }
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
            cell?.modelView?.nowPlayingDelegate = cell
            cell?.nowPlayingCollection.delegate = cell
            cell?.nowPlayingCollection.dataSource = cell
            cell?.toDetailDelegate = self

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
        return (section == 0) ? 1 : min(20, viewModel.numberOfItems)
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

extension ViewController: PerformToDetailDelegate {
    func performSegueDelegate(id: Int) {
        self.idMovie = id
        performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }
}
