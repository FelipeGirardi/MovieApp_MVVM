//
//  NowPlayingCell.swift
//  MovieApp_MVVM
//
//  Created by Jobe Diego Dylbas dos Santos on 16/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

protocol PerformToDetailDelegate {
    func performSegueDelegate(id: Int)
}

class NowPlayingCell: UITableViewCell {
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    var modelView: NowPlayingCellViewModel?
    var toDetailDelegate: PerformToDetailDelegate?
}

extension NowPlayingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mv = modelView else { return 0 }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as? CollectionCellViewController
        cell?.titleLabel.text = self.modelView!.getNowPlayingTitleByIndex(indexPath.row)
//        print(cell?.titleLabel.text)
        cell?.scoreLabel.text = self.modelView!.getNowPlayingScoreByIndex(indexPath.row)
//        print("criou cell")
        guard let posterURL = URL(string: self.modelView!.getNowPlayingPosterImageByIndex(indexPath.row)),
            let posterImgData = try? Data(contentsOf: posterURL) else { return cell! }
        cell?.posterImgView.image = UIImage(data: posterImgData)
        cell?.posterImgView.layer.cornerRadius = 10.0
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.toDetailDelegate?.performSegueDelegate(id: self.modelView?.getNowPlayingIdByIndex(indexPath.row) ?? 0)
    }
}

extension NowPlayingCell: FetchNowPlayingMovies {
    func didFinishedFetchNowPlayingMovies() {
//        print(#function)
        self.nowPlayingCollection.reloadData()
    }
}
