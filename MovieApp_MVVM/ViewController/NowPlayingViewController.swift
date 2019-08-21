//
//  NowPlayingViewController.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var resultsNumberLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var modelView: NowPlayingViewModel?
    var idMovie: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .black
        // Do any additional setup after loading the view.
        
        var resultsCount: String = "0"
        if let moviesNumber = self.modelView?.getNumberOfRsults() {
            resultsCount = moviesNumber
        }
        resultsNumberLabel.text = "Showing \(resultsCount) results"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toDetail":
            if let detailCtrl = segue.destination as? DetailsViewController {
                if detailCtrl.modelView == nil {
                    detailCtrl.modelView = DetailsViewModel(id: self.idMovie)
                }
            }
        default:
            break
        }
    }
}

extension NowPlayingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mv = modelView else { return 0 }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCell", for: indexPath) as? CollectionCellViewController
        cell?.titleLabel.text = self.modelView?.getNowPlayingTitleByIndex(indexPath.row)
        cell?.scoreLabel.text = self.modelView?.getNowPlayingScoreByIndex(indexPath.row)
        guard let posterURL = URL(string: self.modelView!.getNowPlayingPosterImageByIndex(indexPath.row)),
            let posterImgData = try? Data(contentsOf: posterURL) else { return cell! }
        cell?.posterImgView.image = UIImage(data: posterImgData)
        cell?.posterImgView.layer.cornerRadius = 10.0
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idMovie = self.modelView?.getNowPlayingIdByIndex(indexPath.row) ?? 0
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
}

extension NowPlayingViewController: FetchAllNowPlayingMovies {
    func didFinishedFetchNowPlayingMovies() {
        print(#function)
//        resultsNumberLabel.text = "Showing \(String(describing: self.modelView?.nowPlayingMovies.results?.count)) results"
        self.collectionView.reloadData()
    }
}
