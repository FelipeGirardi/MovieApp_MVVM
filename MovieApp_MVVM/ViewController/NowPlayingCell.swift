//
//  NowPlayingCell.swift
//  MovieApp_MVVM
//
//  Created by Jobe Diego Dylbas dos Santos on 16/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class NowPlayingCell: UITableViewCell {
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    private var modelView: NowPlayingCellViewModel = NowPlayingCellViewModel()
}

extension NowPlayingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as? CollectionCellViewController
        cell?.titleLabel.text = "Fast and furios"
        cell?.posterImgView.image = UIImage(named: "lionking")
        cell?.scoreLabel.text = "2.3"
        return cell!
    }
    
    
}
