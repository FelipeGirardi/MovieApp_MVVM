//
//  DetailsViewModel.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    var movieInfo = Movie(adult: nil, backdropPath: nil, belongsToCollection: nil, budget: nil, genres: nil, homepage: nil, id: nil, imdbID: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, releaseDate: nil, revenue: nil, runtime: nil, spokenLanguages: nil, status: nil, tagline: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
    
    
    func fetchMovieFromID(id: Int) {
        DataService.getMovieDetails(movieID: id) { movie in
            self.movieInfo = movie
            //print(self.movieInfo)
        }
    }
    
}
