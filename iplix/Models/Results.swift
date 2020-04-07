//
//  Results.swift
//  iplix
//
//  Created by TEMP on 4/7/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let page: Int
    let results: [Movie]
}
