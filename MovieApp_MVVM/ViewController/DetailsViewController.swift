//
//  DetailsViewController.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 212-30, y: 483, width: 35, height: 35))
    var modelView: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        starImage.isHidden = true
        overviewLabel.isHidden = true
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
        
        self.modelView?.delegate = self
        self.modelView?.fetchMovieFromID()
    }
}

extension DetailsViewController: FetchMovieDelegate {
    func didFinishFetchingMovie() {
        
        DispatchQueue.main.async {
            self.loadingIndicator.removeFromSuperview()
            self.starImage.isHidden = false
            self.overviewLabel.isHidden = false
            
            self.titleLabel.text = self.modelView?.getTitle()
            self.genreLabel.text = self.modelView?.getGenre()
            self.scoreLabel.text = self.modelView?.getScore()
            self.overviewTextView.text = self.modelView?.getOverview()
            
            guard let posterURL = URL(string: self.modelView?.getPoster() ?? ""),
                let posterImgData = try? Data(contentsOf: posterURL) else { return }
            self.posterImgView.image = UIImage(data: posterImgData)
            self.posterImgView.layer.cornerRadius = 10.0
        }
        
    }
}
