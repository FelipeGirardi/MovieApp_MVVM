//
//  NowPlayingViewController.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .black
        // Do any additional setup after loading the view.
    }
}

extension NowPlayingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCell", for: indexPath) as? CollectionCellViewController
        cell?.titleLabel.text = "Fast and furios"
        cell?.posterImgView.image = UIImage(named: "lionking")
        cell?.scoreLabel.text = "2.3"
        cell?.posterImgView.layer.cornerRadius = 10.0
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
}
