//
//  Review.swift
//  iplix
//
//  Created by TEMP on 4/9/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

struct ReviewResult: Decodable {
    let results: [Review]?
}

struct Review: Decodable {
    let author: String?
    let content: String?
}
