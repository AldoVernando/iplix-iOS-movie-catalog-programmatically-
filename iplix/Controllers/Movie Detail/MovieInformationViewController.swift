//
//  MovieInformationViewController.swift
//  iplix
//
//  Created by TEMP on 4/8/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import UIKit

class MovieInformationViewController: UIViewController {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let genre: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let language: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Production Companies"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let companies: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Production Countries"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countries: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(infoLabel)
        view.addSubview(genreLabel)
        view.addSubview(genre)
        view.addSubview(languageLabel)
        view.addSubview(language)
        view.addSubview(companyLabel)
        view.addSubview(companies)
        view.addSubview(countryLabel)
        view.addSubview(countries)
        
        NSLayoutConstraint.activate([
            
            // info label constraints
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // genre label constraints
            genreLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            genreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            genreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie genres constraint
            genre.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            genre.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            genre.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // language label constraints
            languageLabel.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 16),
            languageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            languageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie languages constraints
            language.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            language.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            language.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // company label constraints
            companyLabel.topAnchor.constraint(equalTo: language.bottomAnchor, constant: 16),
            companyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            companyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie companies constraints
            companies.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            companies.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            companies.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            // country label constraints
            countryLabel.topAnchor.constraint(equalTo: companies.bottomAnchor, constant: 16),
            countryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            countryLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // movie countries constraints
            countries.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            countries.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            countries.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
        ])
        
        
        if let mov = movieDetail {
            setData(movie: mov)
        }
    }
    
}


// MARK: Functions
extension MovieInformationViewController {
    
    
    // set up the movie's data
    func setData(movie: MovieDetail) {
        getGenre(mov: movie)
        getLanguage(mov: movie)
        getCompany(mov: movie)
        getCountry(mov: movie)
    }
    
    
    // generate movie's genre
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
    
    
    // generate movie's language
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
    
    
    // generate movie's company production
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
    
    
    // generate movie's country production
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
