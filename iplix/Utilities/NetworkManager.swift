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
    
    var delegate: NetworkDelegate!
   
    let posterURL = "https://image.tmdb.org/t/p/w500"
    let moviePageURL = "https://www.themoviedb.org/movie/"
    let personURL = "https://api.themoviedb.org/3/person"
    
    var genres: [Genre] = []
    var parameters: [String: String] = [
        "apiKey": "api_key=011476f22113ee2ae9d19f4d511997bc",
        "language": "language=en-US"
    ]

    init() {
        getGenres() { response in
            self.genres = response
            DispatchQueue.main.async {
                self.delegate.reloadTableView()
            }
        }
    }
    
}

// MARK: Functions
extension NetworkManager {
    
    
    // fetch movie list
    func getMovies(typeMovie: String, page: Int, completion: @escaping ([Movie]) -> ()) {
        
        let finalURL = createMovieURL(type: typeMovie, page: page)
        
        AF.request(finalURL, method: .get).responseDecodable(of: Results.self) { response in
            guard let movies = response.value?.results else { return }
            completion(movies)
        }
    }
    
    
    // fetch movie detail
    func getMovieDetail(movieId: String, completion: @escaping (MovieDetail) -> ()) {
        
        let finalURL = createMovieURL(type: movieId, page: 1)
        
        AF.request(finalURL, method: .get).responseDecodable(of: MovieDetail.self) { response in
            guard let movie = response.value else { return }
            completion(movie)
        }
    }
    
    
    // fetch movie detail for favorite
    func getMovieforFav(movieId: String, completion: @escaping (Movie) -> ()) {
        
        let finalURL = createMovieURL(type: movieId, page: 1)
        
        AF.request(finalURL, method: .get).responseDecodable(of: Movie.self) { response in
            guard let movie = response.value else { return }
            completion(movie)
        }
    }
    
    
    // fetch movie detail reviews
    func getMovieReview(movieId: String, completion: @escaping ([Review]) -> ()) {
        
        let finalURL = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?\(parameters["apiKey"]!)&\(parameters["language"]!)&page=1"
        
        AF.request(finalURL, method: .get).responseDecodable(of: ReviewResult.self) { response in
            guard let review = response.value?.results else { return }
            completion(review)
        }
    }
    
    
    // search movie
    func getMovieWithQuery(query: String, page: Int, completion: @escaping ([Movie]) -> ()) {
        
        var finalURL: String = ""
        
        if query != "" {
            
            var formatedQuery = query
            
            if query.contains(" ") {
                formatedQuery = query.replacingOccurrences(of: " ", with: "%20")
            }
            
            finalURL = "https://api.themoviedb.org/3/search/movie?\(String(describing: parameters["apiKey"]!))&\(String(describing: parameters["language"]!))&query=\(formatedQuery)&page=\(page)"
        } else {
            finalURL = createMovieURL(type: "upcoming", page: page)
        }
        
        AF.request(finalURL, method: .get).responseDecodable(of: Results.self) { response in
            guard let movies = response.value?.results else { return }
            completion(movies)
        }
    }
    
    
    // fetch genre list
    func getGenres(completion: @escaping ([Genre]) -> ()) {
        
        let genreURL = "https://api.themoviedb.org/3/genre/list?\(parameters["apiKey"]!)&\(parameters["language"]!)"
        
        AF.request(genreURL, method: .get).responseDecodable(of: ResultGenres.self) { response in
                guard let genres = response.value?.genres else { return }
                completion(genres)
            }
    }
    
    
    // fetch popular persons
    func getPersons(page: Int, completion: @escaping ([Person]) -> ()) {
        
        let finalURL = createPersonURL(type: "popular", page: page)
        
        AF.request(finalURL, method: .get).responseDecodable(of: PersonResult.self) { response in
                guard let persons = response.value?.results else { return }
                completion(persons)
            }
    }
    
    
    // fetch person detail
    func getPersonDetail(id: Int, completion: @escaping (Person) -> ()) {
        
        let finalURL = createPersonURL(type: String(id), page: 1)
        
        AF.request(finalURL, method: .get).responseDecodable(of: Person.self) { response in
            guard let person = response.value else { return }
                completion(person)
            }
    }
    
    
    // get movie's video
    func getVideoURL(id: Int, completion: @escaping ([Video]) -> ()) {
        
        let finalURL = createVideoURL(id: id)
        
        AF.request(finalURL, method: .get).responseDecodable(of: VideoResult.self) { response in
            guard let videos = response.value?.results else { return }
                completion(videos)
            }
    }
    
    
    // generate movie URL
    func createMovieURL(type: String, page: Int) -> String{
        let URL = "https://api.themoviedb.org/3/movie/\(type)?\(parameters["apiKey"]!)&\(parameters["language"]!)&page=\(page)"
        
        return URL
    }
    
    
    // generate person URL
    func createPersonURL(type: String, page: Int) -> String{
        let URL = "\(personURL)/\(type)?\(parameters["apiKey"]!)&\(parameters["language"]!)&page=\(page)"
        
        return URL
    }
    
    
    // generate video URL
    func createVideoURL(id: Int) -> String {
        let URL = "https://api.themoviedb.org/3/movie/\(id)/videos?\(parameters["apiKey"]!)"
        
        return URL
    }
    
}


// MARK: NetworkDelegate
protocol NetworkDelegate {
    func reloadTableView()
}
