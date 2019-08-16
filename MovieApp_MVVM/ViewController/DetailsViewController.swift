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
    
    private var modelView: DetailsViewModel = DetailsViewModel()
    
    var titleStr: String?
    var scoreFloat: Float?
    var overviewStr: String?
    var posterImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let overviewText: String = overviewStr {
            // Popular movies
            // Need to create a request for movie gender
        }
        else {
            // Now Playing
            // Need to create a request for movie gender
            // Need to create a request for movie overview
        }
    }
    
    
}
