//
//  Video.swift
//  iplix
//
//  Created by TEMP on 4/17/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

// model to fetch JSON object result
struct VideoResult: Decodable {
    let results: [Video]?
}


struct Video: Decodable {
    let id: String?
    let name: String?
    let key: String?
}
