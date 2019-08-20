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
    var popularMovies = PopularMovies(page: 0, totalResults: 0, totalPages: 0, results: [])
    
    func fetchSearchedMovies(typedString: String) {
        DataService.getMoviesThroughSearch(typedString: typedString, completionHandler: { movies in
            self.searchedMovies = movies
        })
    }
    
    
    init() {
        
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        DataService.getPopularMovies { movies in
            self.popularMovies = movies
//            print(self.popularMovies)
        }
    }
    
    func getPopularTitleByIndex(_ index: Int) -> String {
        if let result = self.popularMovies.results {
            return result[index].title ?? ""
        }
        return ""
    }
    
    func getPopularScoreByIndex(_ index: Int) -> String {
        if let result = self.popularMovies.results {
            return String(result[index].voteAverage ?? 0.0)
        }
        return ""
    }
    
    func getPopularOverviewByIndex(_ index: Int) -> String {
        if let result = self.popularMovies.results {
            return String(result[index].overview ?? "")
        }
        return ""
    }
    
    func getPopularPosterImageByIndex(_ index: Int) -> String {
        if let result = self.popularMovies.results {
            return "https://image.tmdb.org/t/p/w500\(result[index].posterPath ?? "")"
        }
        return ""
    }
    
    func getMovieIdByIndex(_ index: Int) -> Int {
        if let result = self.popularMovies.results {
            return result[index].id ?? 0
        }
        return 0
    }
}
