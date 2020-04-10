//
//  Review.swift
//  iplix
//
//  Created by TEMP on 4/9/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

// model to fetch JSON object result
struct ReviewResult: Decodable {
    let results: [Review]?
}

// model to fetch JSON object review
struct Review: Decodable {
    let author: String?
    let content: String?
}
