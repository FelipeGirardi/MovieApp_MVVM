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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .black
        // Do any additional setup after loading the view.
        resultsNumberLabel.text = "Showing \(self.modelView?.nowPlayingMovies.results?.count ?? 0) results"
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
    
}

extension NowPlayingViewController: FetchAllNowPlayingMovies {
    func didFinishedFetchNowPlayingMovies() {
        print(#function)
//        resultsNumberLabel.text = "Showing \(String(describing: self.modelView?.nowPlayingMovies.results?.count)) results"
        self.collectionView.reloadData()
    }
}
