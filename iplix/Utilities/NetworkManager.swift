//
//  NetworkManager.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let movieURL = "https://api.themoviedb.org/3/movie"
    let posterURL = "https://image.tmdb.org/t/p/w500"
    let genreURL = "https://api.themoviedb.org/3/genre/list?api_key=011476f22113ee2ae9d19f4d511997bc&language=en-US"
    let moviePageURL = "https://www.themoviedb.org/movie/"
    
    var genres: [Genres] = []
    static let networkInstance = NetworkManager()
    
    var parameters: [String: String] = [
        "apiKey": "api_key=011476f22113ee2ae9d19f4d511997bc",
        "language": "language=en-US"
    ]

    //Init
    init() {
        getGenres() { response in
            self.genres = response
        }
    }
    
}

// MARK: Functions
extension NetworkManager {
    
    
    // Fetch Movie List
    func getMovies(typeMovie: String, page: Int, completion: @escaping ([Movie]) -> ()) {
        
        let finalURL = createURL(type: typeMovie, page: page)
        
        AF.request(finalURL, method: .get).responseDecodable(of: Results.self) { response in
            guard let movies = response.value?.results else { return }
            completion(movies)
        }
    }
    
    
    // Fetch Movie Detail
    func getMovieDetail(movieId: String, completion: @escaping (MovieDetail) -> ()) {
        
        let finalURL = createURL(type: movieId, page: 1)
        
        AF.request(finalURL, method: .get).responseDecodable(of: MovieDetail.self) { response in
            guard let movie = response.value else { return }
            completion(movie)
        }
    }
    
    
    // Search Movie
    func getMovieWithQuery(query: String, page: Int, completion: @escaping ([Movie]) -> ()) {
        
        var finalURL: String = ""
        
        if query != "" {
            finalURL = "https://api.themoviedb.org/3/search/movie?\(String(describing: parameters["apiKey"]!))&\(String(describing: parameters["language"]!))&query=\(query)&page=\(page)"
        } else {
            finalURL = createURL(type: "upcoming", page: page)
        }
        
        AF.request(finalURL, method: .get).responseDecodable(of: Results.self) { response in
            guard let movies = response.value?.results else { return }
            completion(movies)
        }
    }
    
    
    // Fetch Genre List
    func getGenres(completion: @escaping ([Genres]) -> ()) {
        AF.request(genreURL, method: .get).responseDecodable(of: ResultGenres.self) { response in
                guard let genres = response.value?.genres else { return }
                completion(genres)
            }
    }
    
    
    // Generate URL
    func createURL(type: String, page: Int) -> String{
        let URL = "\(movieURL)/\(type)?\(parameters["apiKey"]!)&\(parameters["language"]!)&page=\(page)"
        
        return URL
    }
}
