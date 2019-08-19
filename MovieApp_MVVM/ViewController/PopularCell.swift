//
//  PopularCell.swift
//  MovieApp_MVVM
//
//  Created by Jobe Diego Dylbas dos Santos on 16/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import UIKit

class PopularCell: UITableViewCell {
    @IBOutlet weak var popularTableView: UITableView!
    var viewModel: PopularCellViewModel = PopularCellViewModel()
}

extension PopularCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? TableCellViewController
        cell?.titleLabel.text = "Rei leão"
        cell?.overviewLabel.text = "aidsaiosdjasiodasioj aoisdj aios jaso ijdasoi jdasoij dasioj doiajd oaij doiaj diosjdiojdaijdijaosd"
        cell?.scoreLabel.text = "9.0"
        cell?.posterImgView = UIImageView(image: UIImage(named: "lionking"))
        return cell!
    }
    
}
