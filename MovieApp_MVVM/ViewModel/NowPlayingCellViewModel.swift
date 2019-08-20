//
//  NowPlayingCellViewModel.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 17/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

class NowPlayingCellViewModel {

    var nowPlayingMovies = NowPlayingMovies(results: [], page: 0, totalResults: 0, dates: Dates(maximum: "", minimum: ""), totalPages: 0)

    init() {
        fetchNowPlayingMovies()
    }

    func fetchNowPlayingMovies() {
        DataService.getNowPlayingMovies { movies in

            let filteredSlice = movies.results?[...4] ?? []

            self.nowPlayingMovies.results = Array(filteredSlice)
            //print(self.nowPlayingMovies)
        }

    }
}
