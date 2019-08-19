//
//  PopularCellViewModel.swift
//  MovieApp_MVVM
//
//  Created by Jobe Diego Dylbas dos Santos on 16/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

class PopularCellViewModel {
    
    var popularMovies = PopularMovies(page: 0, totalResults: 0, totalPages: 0, results: [])
    
    init() {
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        DataService.getPopularMovies { movies in
            self.popularMovies = movies
            //print(self.popularMovies)
        }
    }
    
}
