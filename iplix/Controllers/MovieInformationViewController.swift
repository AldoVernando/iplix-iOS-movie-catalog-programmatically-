//
//  MovieInformationViewController.swift
//  iplix
//
//  Created by TEMP on 4/8/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieInformationViewController: UIViewController {

    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var companies: UILabel!
    @IBOutlet weak var countries: UILabel!
    
    var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let mov = movieDetail {
            setData(movie: mov)
        }
    }
    
    func setData(movie: MovieDetail) {
        getGenre(mov: movie)
        getLanguage(mov: movie)
        getCompany(mov: movie)
        getCountry(mov: movie)
    }
    
    func getGenre(mov: MovieDetail) {
        var genreText = ""
        for (index, genre) in mov.genres!.enumerated() {
            genreText += genre.name
            if index < mov.genres!.count - 1 {
                genreText += ", "
            }
        }
        
        genre.text = genreText
    }
    
    func getLanguage(mov: MovieDetail) {
        var langText = ""
        for (index, lang) in mov.spoken_languages!.enumerated() {
            langText += lang.name!
            if index < mov.spoken_languages!.count - 1 {
                langText += ", "
            }
        }
        
        language.text = langText
    }
    
    func getCompany(mov: MovieDetail) {
        var compText = ""
        for (index, comp) in mov.production_companies!.enumerated() {
            compText += comp.name!
            if index < mov.production_companies!.count - 1 {
                compText += ", "
            }
        }
        
        companies.text = compText
    }
    
    func getCountry(mov: MovieDetail) {
        var countryText = ""
        for (index, country) in mov.production_countries!.enumerated() {
            countryText += country.name!
            if index < mov.production_countries!.count - 1 {
                countryText += ", "
            }
        }
        
        countries.text = countryText
    }
}
