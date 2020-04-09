//
//  Genres.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

struct ResultGenres: Decodable {
    let genres: [Genres]
}

struct Genres: Decodable {
    let id: Int
    let name: String
}
