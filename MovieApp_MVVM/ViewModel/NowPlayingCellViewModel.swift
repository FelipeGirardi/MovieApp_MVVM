//
//  NowPlayingCellViewModel.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 17/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

protocol FetchNowPlayingMovies {
    func didFinishedFetchNowPlayingMovies()
}

class NowPlayingCellViewModel {

    var nowPlayingMovies = NowPlayingMovies(results: [], page: 0, totalResults: 0, dates: Dates(maximum: "", minimum: ""), totalPages: 0)
    var nowPlayingDelegate: FetchNowPlayingMovies?
    
    init() {
        fetchNowPlayingMovies()
    }

    func fetchNowPlayingMovies() {
        DataService.getNowPlayingMovies { movies in

            let filteredSlice = movies.results?[...4] ?? []

            self.nowPlayingMovies.results = Array(filteredSlice)
            self.nowPlayingDelegate?.didFinishedFetchNowPlayingMovies()
        }
    }
    
    func getNowPlayingTitleByIndex(_ index: Int) -> String {
        if let result = self.nowPlayingMovies.results {
            return result[index].title ?? ""
        }
        return ""
    }
    
    func getNowPlayingScoreByIndex(_ index: Int) -> String {
        if let result = self.nowPlayingMovies.results {
            return String(result[index].voteAverage ?? 0.0)
        }
        return ""
    }
    
    func getNowPlayingPosterImageByIndex(_ index: Int) -> String {
        if let result = self.nowPlayingMovies.results {
            return "https://image.tmdb.org/t/p/w500\(result[index].posterPath ?? "")"
        }
        return ""
    }
    
}
