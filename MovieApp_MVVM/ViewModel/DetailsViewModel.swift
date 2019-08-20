//
//  DetailsViewModel.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation


protocol FetchMovieDelegate: AnyObject {
    func didFinishFetchMovie()
}
class DetailsViewModel {

    var movieInfo = Movie(adult: nil, backdropPath: nil, belongsToCollection: nil, budget: nil, genres: nil, homepage: nil, id: nil, imdbID: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, releaseDate: nil, revenue: nil, runtime: nil, spokenLanguages: nil, status: nil, tagline: nil, title: nil, video: nil, voteAverage: nil, voteCount: nil)
    var idMovie: Int?
    weak var delegate: FetchMovieDelegate?

    func fetchMovieFromID() {
        DataService.getMovieDetails(movieID: self.idMovie ?? 0) { movie in
            self.movieInfo = movie
            self.delegate?.didFinishFetchMovie()
        }
    }
    
    func getTitle() -> String {
        return self.movieInfo.title ?? ""
    }
    
    func getScore() -> String {
        return String(self.movieInfo.voteAverage ?? 0.0)
    }

    func getOverview() -> String {
        return self.movieInfo.overview ?? ""
    }
    
    func getGenre() -> String {
        guard let genre = self.movieInfo.genres else { return "No genre"}
        return (genre.map({ $0.name ?? "" })
            .joined(separator: ", "))
    }
    
    init(id: Int) {
        self.idMovie = id
    }
    
}
