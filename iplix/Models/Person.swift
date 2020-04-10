//
//  Person.swift
//  iplix
//
//  Created by TEMP on 4/10/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

struct PersonResult: Decodable {
    let results: [Person]?
}

struct Person: Decodable {
    let name: String?
    let profile_path: String?
}
