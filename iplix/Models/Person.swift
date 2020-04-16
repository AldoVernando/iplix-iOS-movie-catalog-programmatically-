//
//  Person.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

// model to fetch JSON object result
struct PersonResult: Decodable {
    let results: [Person]?
}


// model to fetch JSON object person
struct Person: Decodable {
    let id: Int?
    let name: String?
    let profile_path: String?
    let biography: String?
    let place_of_birth: String?
    let birthday: String?
}
