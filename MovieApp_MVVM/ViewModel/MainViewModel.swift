//
//  MainViewModel.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 17/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

class MainViewModel {
    
    var searchedMovies = SearchedMovies(page: 0, totalResults: 0, totalPages: 0, results: [])
    
    func fetchSearchedMovies(typedString: String) {
        DataService.getMoviesThroughSearch(typedString: typedString, completionHandler: { movies in
            self.searchedMovies = movies
        })
    }
    
}
