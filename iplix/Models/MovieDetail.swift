//
//  MovieDetail.swift
//  iplix
//
//  Created by TEMP on 4/8/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let genres: [Genres]?
    let production_companies: [company]?
    let production_countries: [country]?
    let spoken_languages: [language]?
}

struct company: Decodable {
    let name: String?
    let origin_country: String?
}

struct country: Decodable {
    let name: String?
}

struct language: Decodable {
    let name: String?
}
