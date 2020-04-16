//
//  MovieDetail.swift
//  iplix
//
//  Created by TEMP on 4/8/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

// model to fetch JSON object movie detail
struct MovieDetail: Decodable {
    let genres: [Genre]?
    let production_companies: [company]?
    let production_countries: [country]?
    let spoken_languages: [language]?
}


// model to fetch JSON object company
struct company: Decodable {
    let name: String?
    let origin_country: String?
}


// model to fetch JSON object country
struct country: Decodable {
    let name: String?
}


// model to fetch JSON object language
struct language: Decodable {
    let name: String?
}
