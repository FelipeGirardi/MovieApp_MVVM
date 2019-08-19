//
//  API.swift
//  MovieApp_MVVM
//
//  Created by Felipe Girardi on 15/08/19.
//  Copyright © 2019 Felipe Girardi. All rights reserved.
//

import Foundation

struct DataService {
    
    static func getNowPlayingMovies(completionHandler: @escaping (_ movies: NowPlayingMovies) -> Void) {
        
        let urlString = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=fb61737ab2cdee1c07a947778f249e7d&page=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let jsonData = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let modelData = try jsonDecoder.decode(NowPlayingMovies.self, from: jsonData)
                            //print(modelData)
                            
                            completionHandler(modelData)
                            
                        } catch {
                            print("JSON Processing Fail")
                        }
                    }
                }
            })
            task.resume()
        }
    }
    
    static func getPopularMovies(completionHandler: @escaping (_ movies: PopularMovies) -> Void) {
        
        let urlString = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=fb61737ab2cdee1c07a947778f249e7d&page=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let jsonData = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let modelData = try jsonDecoder.decode(PopularMovies.self, from: jsonData)
                            //print(modelData)
                            
                            completionHandler(modelData)
                            
                        } catch {
                            print("JSON Processing Fail")
                        }
                    }
                }
            })
            task.resume()
        }
    }

    static func getMoviesThroughSearch(typedString: String, completionHandler: @escaping (_ movie: SearchedMovies) -> Void) {
        
        let urlString = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=fb61737ab2cdee1c07a947778f249e7d&language=en-US&query=\(typedString)&page=1&include_adult=false")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let jsonData = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let modelData = try jsonDecoder.decode(SearchedMovies.self, from: jsonData)
                            //print(modelData)
                            
                            completionHandler(modelData)
                            
                        } catch {
                            print("JSON Processing Fail")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    static func getMovieDetails(movieID: Int, completionHandler: @escaping (_ movie: Movie) -> Void) {
        
        let urlString = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=fb61737ab2cdee1c07a947778f249e7d&language=en-US")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let jsonData = data {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let modelData = try jsonDecoder.decode(Movie.self, from: jsonData)
                            //print(modelData)
                            
                            completionHandler(modelData)
                            
                        } catch {
                            print("JSON Processing Fail")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}


